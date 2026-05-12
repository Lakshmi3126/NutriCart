import '../models/meal_feedback.dart';
import '../models/adaptive_meal_plan.dart';
import './meal_feedback_service.dart';
import './adaptive_patterns_service.dart';
import './meal_api_service.dart';

/// Service for adaptive meal planning based on user behavior
class AdaptiveMealService {
  final MealFeedbackService _feedbackService = MealFeedbackService();
  final MealApiService _mealApiService = MealApiService();

  /// Calculate adjusted portion multiplier based on feedback history
  Future<double> calculateAdaptivePortionMultiplier(
    String mealType, {
    int days = 7,
  }) async {
    final avgPortion = await _feedbackService.calculateAveragePortionConsumed(
      mealType,
      days: days,
    );

    // Adjust portion multiplier based on consumption patterns
    // If user consistently eats less, reduce portion
    // If user consistently eats full portions, maintain or increase
    if (avgPortion < 0.6) {
      // Save adaptive pattern to Supabase
      await AdaptivePatternsService.saveAdaptivePattern(
        mealType: mealType,
        patternType: 'portion_adjustment',
        patternData: {
          'multiplier': 0.75,
          'reason': 'User consistently eats less than 60% of portions',
        },
        confidenceScore: 0.85,
      );
      return 0.75; // Reduce to 75%
    } else if (avgPortion < 0.8) {
      await AdaptivePatternsService.saveAdaptivePattern(
        mealType: mealType,
        patternType: 'portion_adjustment',
        patternData: {
          'multiplier': 0.85,
          'reason': 'User consistently eats 60-80% of portions',
        },
        confidenceScore: 0.75,
      );
      return 0.85; // Reduce to 85%
    } else if (avgPortion > 0.95) {
      return 1.0; // Maintain standard
    }
    return 1.0;
  }

  /// Determine if a meal should be replaced based on skip patterns
  Future<bool> shouldReplaceMeal(
    String mealId,
    String mealType, {
    int days = 7,
  }) async {
    final mealFeedback = await _feedbackService.getFeedbackByMealId(mealId);
    final recentFeedback = mealFeedback.where((f) {
      final cutoffDate = DateTime.now().subtract(Duration(days: days));
      return f.date.isAfter(cutoffDate);
    }).toList();

    if (recentFeedback.isEmpty) return false;

    // Replace if skipped more than 60% of the time
    final skipCount = recentFeedback
        .where((f) => f.status == FeedbackStatus.skipped)
        .length;
    final skipRate = skipCount / recentFeedback.length;

    if (skipRate > 0.6) {
      // Save skip pattern to Supabase
      await AdaptivePatternsService.saveAdaptivePattern(
        mealType: mealType,
        patternType: 'skip_pattern',
        patternData: {
          'avoided_meal_id': mealId,
          'skip_rate': skipRate,
          'reason': 'Meal skipped more than 60% of the time',
        },
        confidenceScore: skipRate,
      );
    }

    return skipRate > 0.6;
  }

  /// Find alternative meal using backend API
  Future<Map<String, dynamic>?> findAlternativeMealFromBackend(
    String mealType,
    String mealIdToReplace,
    Set<String> healthConditions,
    Set<String> dietaryPreferences,
  ) async {
    try {
      final alternatives = await _mealApiService.fetchMealsByFilters(
        mealType: mealType,
        healthConditions: healthConditions.toList(),
        dietaryPreferences: dietaryPreferences.toList(),
      );

      // Filter out the meal to replace
      final filteredAlternatives = alternatives
          .where((m) => m['id'] != mealIdToReplace)
          .toList();

      return filteredAlternatives.isNotEmpty
          ? filteredAlternatives.first
          : null;
    } catch (e) {
      print('Error finding alternative meal from backend: $e');
      return null;
    }
  }

  /// Find alternative meal (local fallback)
  Map<String, dynamic>? findAlternativeMeal(
    List<Map<String, dynamic>> availableMeals,
    String mealIdToReplace,
    Set<String> healthConditions,
    Set<String> dietaryPreferences,
  ) {
    // Filter out the meal to replace
    final alternatives = availableMeals
        .where((m) => m['id'] != mealIdToReplace)
        .toList();

    if (alternatives.isEmpty) return null;

    // Prioritize meals matching health conditions
    final healthFriendly = alternatives.where((m) {
      if (healthConditions.contains('Diabetes')) {
        return m['isDiabeticFriendly'] == true;
      }
      return true;
    }).toList();

    // Filter by dietary preferences
    final dietaryMatches =
        (healthFriendly.isNotEmpty ? healthFriendly : alternatives).where((m) {
          if (dietaryPreferences.contains('Vegetarian') ||
              dietaryPreferences.contains('Vegan') ||
              dietaryPreferences.contains('Jain')) {
            return m['isVegetarian'] == true;
          }
          return true;
        }).toList();

    // Return first match or random alternative
    return dietaryMatches.isNotEmpty
        ? dietaryMatches.first
        : (alternatives.isNotEmpty ? alternatives.first : null);
  }

  /// Calculate adjusted nutrient targets based on consumption patterns
  Future<NutrientTargets> calculateAdjustedNutrientTargets(
    NutrientTargets baseTargets, {
    int days = 7,
  }) async {
    final recentFeedback = await _feedbackService.getRecentFeedback(days: days);

    if (recentFeedback.isEmpty) return baseTargets;

    // Calculate average consumption rate
    final consumedFeedback = recentFeedback
        .where((f) => f.status != FeedbackStatus.skipped)
        .toList();
    final avgConsumption = consumedFeedback.isEmpty
        ? 1.0
        : consumedFeedback.fold<double>(
                0.0,
                (sum, f) => sum + f.portionConsumed,
              ) /
              consumedFeedback.length;

    // Adjust targets based on consumption patterns
    // If user consistently eats less, reduce targets slightly
    if (avgConsumption < 0.7) {
      return baseTargets * 0.85;
    } else if (avgConsumption < 0.85) {
      return baseTargets * 0.9;
    }

    return baseTargets;
  }

  /// Rebalance nutrients for remaining meals if one meal is skipped
  NutrientTargets rebalanceNutrientsForSkippedMeal(
    NutrientTargets dailyTargets,
    NutrientTargets skippedMealNutrients,
    int remainingMeals,
  ) {
    if (remainingMeals <= 0) return dailyTargets;

    // Distribute skipped meal nutrients across remaining meals
    final redistributedNutrients =
        skippedMealNutrients * (1.0 / remainingMeals);
    return redistributedNutrients;
  }

  /// Calculate adaptation score (0.0 to 1.0) indicating how personalized the plan is
  Future<double> calculateAdaptationScore({int days = 7}) async {
    final recentFeedback = await _feedbackService.getRecentFeedback(days: days);

    if (recentFeedback.isEmpty) return 0.0;

    // Score based on:
    // 1. Number of feedback entries (more data = better adaptation)
    // 2. Variety of feedback types (eaten, skipped, partial)
    // 3. Consistency of patterns

    final feedbackCount = recentFeedback.length;
    final maxExpectedFeedback = days * 4; // 4 meals per day

    final dataScore = (feedbackCount / maxExpectedFeedback).clamp(0.0, 1.0);

    // Variety score
    final hasEaten = recentFeedback.any(
      (f) => f.status == FeedbackStatus.eaten,
    );
    final hasSkipped = recentFeedback.any(
      (f) => f.status == FeedbackStatus.skipped,
    );
    final hasPartial = recentFeedback.any(
      (f) => f.status == FeedbackStatus.partial,
    );

    final varietyScore =
        ([hasEaten, hasSkipped, hasPartial].where((v) => v).length / 3.0);

    return (dataScore * 0.7 + varietyScore * 0.3).clamp(0.0, 1.0);
  }
}

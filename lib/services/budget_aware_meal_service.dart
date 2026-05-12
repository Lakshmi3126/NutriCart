import '../models/dish.dart';
import '../models/meal_plan_output.dart';
import './meal_filter_service.dart';

/// Service for budget-aware meal planning decisions
/// Replaces expensive meals with safe alternatives while maintaining medical safety
class BudgetAwareMealService {
  /// Check if meal plan exceeds budget and apply budget-aware adjustments
  static MealPlanOutput applyBudgetAwareLogic({
    required MealPlanOutput originalPlan,
    required double dailyBudget,
    required List<String> healthConditions,
    required String dietaryPreference,
    required String cuisinePreference,
    required int dailyCalorieTarget,
  }) {
    // Check if plan is within budget
    if (originalPlan.totalCost <= dailyBudget) {
      return originalPlan; // No changes needed
    }

    // Plan exceeds budget - apply budget-aware adjustments
    List<SelectedMeal> adjustedMeals = [];
    double totalCost = 0.0;
    int totalCalories = 0;

    for (SelectedMeal meal in originalPlan.selectedMeals) {
      double mealBudgetTarget = _getMealBudgetTarget(
        meal.mealType,
        dailyBudget,
      );

      // If meal exceeds its budget target, try to replace or adjust
      if (meal.cost > mealBudgetTarget) {
        SelectedMeal adjustedMeal = _applyBudgetAdjustment(
          originalMeal: meal,
          budgetTarget: mealBudgetTarget,
          healthConditions: healthConditions,
          dietaryPreference: dietaryPreference,
          cuisinePreference: cuisinePreference,
          calorieTarget: meal.calories,
        );
        adjustedMeals.add(adjustedMeal);
        totalCost += adjustedMeal.cost;
        totalCalories += adjustedMeal.calories;
      } else {
        adjustedMeals.add(meal);
        totalCost += meal.cost;
        totalCalories += meal.calories;
      }
    }

    // Recalculate nutrient summary
    NutrientSummary nutrientSummary = _calculateNutrientSummary(adjustedMeals);

    return MealPlanOutput(
      selectedMeals: adjustedMeals,
      totalCalories: totalCalories,
      totalCost: totalCost,
      nutrientSummary: nutrientSummary,
      generatedDate: originalPlan.generatedDate,
      planType: 'Budget-Optimized Daily Meal Plan',
    );
  }

  /// Apply budget adjustment to a single meal
  static SelectedMeal _applyBudgetAdjustment({
    required SelectedMeal originalMeal,
    required double budgetTarget,
    required List<String> healthConditions,
    required String dietaryPreference,
    required String cuisinePreference,
    required int calorieTarget,
  }) {
    // Strategy 1: Try to find a lower-cost safe alternative
    Dish? replacement = _findLowerCostAlternative(
      mealType: originalMeal.mealType,
      maxCost: budgetTarget,
      healthConditions: healthConditions,
      dietaryPreference: dietaryPreference,
      cuisinePreference: cuisinePreference,
      calorieTarget: calorieTarget,
    );

    if (replacement != null) {
      return _createSelectedMeal(
        dish: replacement,
        mealType: originalMeal.mealType,
        reason:
            'This meal was chosen because it fits your budget (₹${replacement.estimatedCostInr.toStringAsFixed(2)}) while maintaining medical safety and nutritional balance.',
      );
    }

    // Strategy 2: Adjust portion size safely
    SelectedMeal adjustedPortion = _adjustPortionSafely(
      originalMeal: originalMeal,
      budgetTarget: budgetTarget,
      healthConditions: healthConditions,
    );

    return adjustedPortion;
  }

  /// Find lower-cost alternative that maintains medical safety
  static Dish? _findLowerCostAlternative({
    required String mealType,
    required double maxCost,
    required List<String> healthConditions,
    required String dietaryPreference,
    required String cuisinePreference,
    required int calorieTarget,
  }) {
    // Get all medically safe dishes for this meal type
    List<Dish> safeDishes = MealFilterService.getSuitableDishes(
      mealType: mealType,
      healthConditions: healthConditions,
      dietaryPreference: dietaryPreference,
      cuisinePreference: cuisinePreference,
      maxCostPerMeal: maxCost,
    );

    if (safeDishes.isEmpty) {
      // Relax cuisine preference but maintain medical safety
      safeDishes = MealFilterService.getSuitableDishes(
        mealType: mealType,
        healthConditions: healthConditions,
        dietaryPreference: dietaryPreference,
        cuisinePreference: '',
        maxCostPerMeal: maxCost,
      );
    }

    if (safeDishes.isEmpty) return null;

    // Prefer seasonal and local ingredients (lower cost dishes)
    safeDishes.sort((a, b) => a.estimatedCostInr.compareTo(b.estimatedCostInr));

    // Score dishes based on calorie match and cost efficiency
    Dish? bestAlternative;
    double bestScore = -1;

    for (Dish dish in safeDishes) {
      double calorieScore = _calculateCalorieMatchScore(
        dish.caloriesPerServing,
        calorieTarget,
      );
      double costScore = _calculateCostEfficiencyScore(
        dish.estimatedCostInr,
        maxCost,
      );
      double nutritionScore = _calculateNutritionQualityScore(
        dish,
        healthConditions,
      );
      double seasonalScore = _calculateSeasonalLocalScore(dish);

      // Weighted scoring: 30% calorie, 30% cost, 25% nutrition, 15% seasonal
      double totalScore =
          (calorieScore * 0.30) +
          (costScore * 0.30) +
          (nutritionScore * 0.25) +
          (seasonalScore * 0.15);

      if (totalScore > bestScore) {
        bestScore = totalScore;
        bestAlternative = dish;
      }
    }

    return bestAlternative;
  }

  /// Adjust portion size safely while maintaining medical safety
  static SelectedMeal _adjustPortionSafely({
    required SelectedMeal originalMeal,
    required double budgetTarget,
    required List<String> healthConditions,
  }) {
    // Calculate required portion reduction
    double targetRatio = budgetTarget / originalMeal.cost;
    targetRatio = targetRatio.clamp(0.6, 1.0); // Max 40% reduction for safety

    // Adjust all nutritional values proportionally
    int adjustedCalories = (originalMeal.calories * targetRatio).round();
    double adjustedCost = originalMeal.cost * targetRatio;

    MacroNutrients adjustedMacros = MacroNutrients(
      carbsG: originalMeal.macros.carbsG * targetRatio,
      proteinG: originalMeal.macros.proteinG * targetRatio,
      fatG: originalMeal.macros.fatG * targetRatio,
      fiberG: originalMeal.macros.fiberG * targetRatio,
    );

    MicroNutrients adjustedMicros = MicroNutrients(
      ironMg: originalMeal.micros.ironMg * targetRatio,
      sodiumMg: originalMeal.micros.sodiumMg * targetRatio,
    );

    String adjustedPortionSize = _calculateAdjustedPortionSize(
      originalMeal.portionSize,
      targetRatio,
    );

    int reductionPercent = ((1 - targetRatio) * 100).round();

    return SelectedMeal(
      mealType: originalMeal.mealType,
      dishName: originalMeal.dishName,
      dishId: originalMeal.dishId,
      calories: adjustedCalories,
      cost: adjustedCost,
      cuisineType: originalMeal.cuisineType,
      isVegetarian: originalMeal.isVegetarian,
      portionSize: adjustedPortionSize,
      macros: adjustedMacros,
      micros: adjustedMicros,
      selectionReason:
          'Portion size adjusted by $reductionPercent% to fit your budget (₹${adjustedCost.toStringAsFixed(2)}) while maintaining medical safety and nutritional adequacy.',
    );
  }

  /// Calculate adjusted portion size description
  static String _calculateAdjustedPortionSize(
    String originalPortion,
    double ratio,
  ) {
    if (ratio >= 0.9) return originalPortion;
    if (ratio >= 0.75) return 'Reduced portion: $originalPortion (75-90%)';
    if (ratio >= 0.6) return 'Smaller portion: $originalPortion (60-75%)';
    return 'Adjusted: $originalPortion';
  }

  /// Calculate meal budget target based on meal type
  static double _getMealBudgetTarget(String mealType, double dailyBudget) {
    switch (mealType.toLowerCase()) {
      case 'breakfast':
        return dailyBudget * 0.20;
      case 'lunch':
        return dailyBudget * 0.40;
      case 'dinner':
        return dailyBudget * 0.40;
      case 'snack':
        return dailyBudget * 0.15;
      default:
        return dailyBudget * 0.25;
    }
  }

  /// Calculate calorie match score (0-100)
  static double _calculateCalorieMatchScore(
    int actualCalories,
    int targetCalories,
  ) {
    if (targetCalories == 0) return 50.0;

    double difference =
        (actualCalories - targetCalories).abs() / targetCalories;

    if (difference <= 0.1) return 100.0; // Within 10%
    if (difference <= 0.2) return 85.0; // Within 20%
    if (difference <= 0.3) return 70.0; // Within 30%
    if (difference <= 0.5) return 50.0; // Within 50%
    return 30.0;
  }

  /// Calculate cost efficiency score (0-100)
  static double _calculateCostEfficiencyScore(
    double actualCost,
    double maxBudget,
  ) {
    if (maxBudget == 0) return 50.0;

    double ratio = actualCost / maxBudget;

    if (ratio <= 0.5) return 100.0; // Very affordable (50% or less)
    if (ratio <= 0.7) return 85.0; // Good value (70% or less)
    if (ratio <= 0.85) return 70.0; // Acceptable (85% or less)
    if (ratio <= 1.0) return 50.0; // At budget limit
    return 20.0; // Over budget
  }

  /// Calculate nutrition quality score (0-100)
  static double _calculateNutritionQualityScore(
    Dish dish,
    List<String> healthConditions,
  ) {
    double score = 50.0; // Base score

    // Bonus for high fiber
    if (dish.fiberG >= 5.0) {
      score += 15.0;
    } else if (dish.fiberG >= 3.0) {
      score += 10.0;
    }

    // Bonus for high protein
    if (dish.proteinG >= 15.0) {
      score += 15.0;
    } else if (dish.proteinG >= 8.0) {
      score += 10.0;
    }

    // Bonus for low sodium
    if (dish.sodiumMg <= 300) {
      score += 10.0;
    } else if (dish.sodiumMg <= 400) {
      score += 5.0;
    }

    // Bonus for low GI
    if (dish.glycemicIndexCategory == 'low') {
      score += 10.0;
    } else if (dish.glycemicIndexCategory == 'medium') {
      score += 5.0;
    }

    return score.clamp(0.0, 100.0);
  }

  /// Calculate seasonal and local ingredient preference score (0-100)
  static double _calculateSeasonalLocalScore(Dish dish) {
    double score = 50.0; // Base score

    // Lower cost generally indicates seasonal/local availability
    if (dish.estimatedCostInr <= 30) {
      score += 30.0; // Very affordable - likely seasonal/local
    } else if (dish.estimatedCostInr <= 50) {
      score += 20.0; // Affordable - possibly seasonal
    } else if (dish.estimatedCostInr <= 75) {
      score += 10.0; // Moderate cost
    }

    // Bonus for vegetarian dishes (often more local/seasonal)
    if (dish.isVegetarian) {
      score += 10.0;
    }

    // Bonus for dishes with simple ingredients (more likely local)
    if (dish.ingredients.length <= 8) {
      score += 10.0;
    }

    return score.clamp(0.0, 100.0);
  }

  /// Create SelectedMeal from Dish with custom reason
  static SelectedMeal _createSelectedMeal({
    required Dish dish,
    required String mealType,
    required String reason,
  }) {
    return SelectedMeal(
      mealType: mealType,
      dishName: dish.dishName,
      dishId: dish.dishId,
      calories: dish.caloriesPerServing,
      cost: dish.estimatedCostInr,
      cuisineType: dish.cuisineType,
      isVegetarian: dish.isVegetarian,
      portionSize: dish.portionSize,
      macros: MacroNutrients(
        carbsG: dish.carbsG,
        proteinG: dish.proteinG,
        fatG: dish.fatG,
        fiberG: dish.fiberG,
      ),
      micros: MicroNutrients(ironMg: dish.ironMg, sodiumMg: dish.sodiumMg),
      selectionReason: reason,
    );
  }

  /// Calculate nutrient summary from selected meals
  static NutrientSummary _calculateNutrientSummary(List<SelectedMeal> meals) {
    double totalCarbs = meals.fold(
      0.0,
      (sum, meal) => sum + meal.macros.carbsG,
    );
    double totalProtein = meals.fold(
      0.0,
      (sum, meal) => sum + meal.macros.proteinG,
    );
    double totalFat = meals.fold(0.0, (sum, meal) => sum + meal.macros.fatG);
    double totalFiber = meals.fold(
      0.0,
      (sum, meal) => sum + meal.macros.fiberG,
    );
    double totalIron = meals.fold(0.0, (sum, meal) => sum + meal.micros.ironMg);
    double totalSodium = meals.fold(
      0.0,
      (sum, meal) => sum + meal.micros.sodiumMg,
    );

    // Calculate calorie distribution from macros
    double carbCalories = totalCarbs * 4;
    double proteinCalories = totalProtein * 4;
    double fatCalories = totalFat * 9;
    double totalMacroCalories = carbCalories + proteinCalories + fatCalories;

    String carbsPercentage = totalMacroCalories > 0
        ? '${((carbCalories / totalMacroCalories) * 100).toStringAsFixed(1)}%'
        : '0%';
    String proteinPercentage = totalMacroCalories > 0
        ? '${((proteinCalories / totalMacroCalories) * 100).toStringAsFixed(1)}%'
        : '0%';
    String fatPercentage = totalMacroCalories > 0
        ? '${((fatCalories / totalMacroCalories) * 100).toStringAsFixed(1)}%'
        : '0%';

    // Check if nutrient balance is good
    double carbPercent = totalMacroCalories > 0
        ? (carbCalories / totalMacroCalories) * 100
        : 0;
    double proteinPercent = totalMacroCalories > 0
        ? (proteinCalories / totalMacroCalories) * 100
        : 0;
    double fatPercent = totalMacroCalories > 0
        ? (fatCalories / totalMacroCalories) * 100
        : 0;

    bool meetsBalance = _checkNutrientBalance(
      carbPercent,
      proteinPercent,
      fatPercent,
    );

    List<String> nutritionNotes = [];
    nutritionNotes.add(
      'Budget-optimized meal plan with medical safety maintained',
    );

    return NutrientSummary(
      totalCarbsG: totalCarbs,
      totalProteinG: totalProtein,
      totalFatG: totalFat,
      totalFiberG: totalFiber,
      totalIronMg: totalIron,
      totalSodiumMg: totalSodium,
      carbsPercentage: carbsPercentage,
      proteinPercentage: proteinPercentage,
      fatPercentage: fatPercentage,
      meetsNutrientBalance: meetsBalance,
      nutritionNotes: nutritionNotes,
    );
  }

  /// Check if nutrient balance meets healthy guidelines
  static bool _checkNutrientBalance(
    double carbPercent,
    double proteinPercent,
    double fatPercent,
  ) {
    // Healthy ranges: Carbs 45-65%, Protein 10-35%, Fat 20-35%
    bool carbsOk = carbPercent >= 45 && carbPercent <= 65;
    bool proteinOk = proteinPercent >= 10 && proteinPercent <= 35;
    bool fatOk = fatPercent >= 20 && fatPercent <= 35;

    return carbsOk && proteinOk && fatOk;
  }
}

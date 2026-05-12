import '../core/supabase_client.dart';
import './api_service.dart';

/// Service for meal-related API calls to backend
class MealApiService {
  final ApiService _apiService = ApiService();

  /// Fetch daily meal plan from backend
  /// Returns meals for breakfast, lunch, dinner, and snacks based on user profile
  Future<Map<String, dynamic>> fetchDailyMealPlan({
    required DateTime date,
  }) async {
    final user = supabase.auth.currentUser;
    if (user == null) {
      throw Exception('User not authenticated');
    }

    try {
      final response = await _apiService.get(
        '/meals/daily-plan',
        queryParameters: {
          'date': date.toIso8601String().split('T')[0],
          'user_id': user.id,
        },
      );

      return response.data as Map<String, dynamic>;
    } catch (e) {
      print('Error fetching daily meal plan: $e');
      rethrow;
    }
  }

  /// Submit meal feedback to backend
  /// Sends user feedback (eaten, skipped, partial) for adaptive learning
  Future<void> submitMealFeedback({
    required String mealId,
    required String mealType,
    required DateTime date,
    required String status, // 'eaten', 'skipped', 'partial'
    required double portionConsumed,
    String? reason,
  }) async {
    final user = supabase.auth.currentUser;
    if (user == null) {
      throw Exception('User not authenticated');
    }

    try {
      await _apiService.post(
        '/meals/feedback',
        data: {
          'user_id': user.id,
          'meal_id': mealId,
          'meal_type': mealType,
          'date': date.toIso8601String().split('T')[0],
          'status': status,
          'portion_consumed': portionConsumed,
          'reason': reason,
        },
      );
    } catch (e) {
      print('Error submitting meal feedback: $e');
      rethrow;
    }
  }

  /// Regenerate adaptive meal plan based on feedback
  /// Backend analyzes user patterns and generates improved meal plan
  Future<Map<String, dynamic>> regenerateAdaptivePlan({
    required DateTime date,
    String?
    specificMealType, // Optional: regenerate only breakfast/lunch/dinner
  }) async {
    final user = supabase.auth.currentUser;
    if (user == null) {
      throw Exception('User not authenticated');
    }

    try {
      final response = await _apiService.post(
        '/meals/regenerate',
        data: {
          'user_id': user.id,
          'date': date.toIso8601String().split('T')[0],
          'meal_type': specificMealType,
        },
      );

      return response.data as Map<String, dynamic>;
    } catch (e) {
      print('Error regenerating adaptive plan: $e');
      rethrow;
    }
  }

  /// Fetch detailed recipe for a meal
  /// Returns ingredients, cooking instructions, prep time, etc.
  Future<Map<String, dynamic>> fetchRecipe({required String mealId}) async {
    try {
      final response = await _apiService.get('/meals/$mealId/recipe');

      return response.data as Map<String, dynamic>;
    } catch (e) {
      print('Error fetching recipe: $e');
      rethrow;
    }
  }

  /// Fetch health explanation for a meal
  /// Returns why this meal was chosen, health benefits, and nutritional reasoning
  Future<Map<String, dynamic>> fetchMealExplanation({
    required String mealId,
  }) async {
    final user = supabase.auth.currentUser;
    if (user == null) {
      throw Exception('User not authenticated');
    }

    try {
      final response = await _apiService.get(
        '/meals/$mealId/explanation',
        queryParameters: {'user_id': user.id},
      );

      return response.data as Map<String, dynamic>;
    } catch (e) {
      print('Error fetching meal explanation: $e');
      rethrow;
    }
  }

  /// Fetch meals by filters (for meal replacement)
  /// Returns list of meals matching health conditions, dietary preferences, etc.
  Future<List<Map<String, dynamic>>> fetchMealsByFilters({
    required String mealType,
    List<String>? healthConditions,
    List<String>? dietaryPreferences,
    String? cuisineType,
    double? maxCalories,
    double? maxCost,
  }) async {
    final user = supabase.auth.currentUser;
    if (user == null) {
      throw Exception('User not authenticated');
    }

    try {
      final response = await _apiService.get(
        '/meals/search',
        queryParameters: {
          'user_id': user.id,
          'meal_type': mealType,
          'health_conditions': healthConditions?.join(','),
          'dietary_preferences': dietaryPreferences?.join(','),
          'cuisine_type': cuisineType,
          'max_calories': maxCalories,
          'max_cost': maxCost,
        },
      );

      return List<Map<String, dynamic>>.from(response.data as List);
    } catch (e) {
      print('Error fetching meals by filters: $e');
      rethrow;
    }
  }

  /// Get adaptive insights for user
  /// Returns personalized insights based on eating patterns
  Future<Map<String, dynamic>> fetchAdaptiveInsights() async {
    final user = supabase.auth.currentUser;
    if (user == null) {
      throw Exception('User not authenticated');
    }

    try {
      final response = await _apiService.get(
        '/meals/adaptive-insights',
        queryParameters: {'user_id': user.id},
      );

      return response.data as Map<String, dynamic>;
    } catch (e) {
      print('Error fetching adaptive insights: $e');
      rethrow;
    }
  }
}

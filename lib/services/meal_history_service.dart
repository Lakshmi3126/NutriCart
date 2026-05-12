import '../core/supabase_client.dart';

/// Service for managing meal history in Supabase
class MealHistoryService {
  /// Save meal to history
  static Future<void> saveMealToHistory({
    required String mealId,
    required String mealName,
    required String mealType,
    required DateTime mealDate,
    required double calories,
    required double protein,
    required double carbs,
    required double fat,
    required double fiber,
    required double cost,
  }) async {
    final user = supabase.auth.currentUser;
    if (user == null) throw Exception('Not authenticated');

    await supabase.from('meal_history').insert({
      'user_id': user.id,
      'meal_id': mealId,
      'meal_name': mealName,
      'meal_type': mealType,
      'meal_date': mealDate.toIso8601String().split('T')[0],
      'calories': calories,
      'protein': protein,
      'carbs': carbs,
      'fat': fat,
      'fiber': fiber,
      'cost': cost,
    });
  }

  /// Get meal history for date range
  static Future<List<Map<String, dynamic>>> getMealHistory({
    DateTime? startDate,
    DateTime? endDate,
    String? mealType,
  }) async {
    final user = supabase.auth.currentUser;
    if (user == null) return [];

    var query = supabase.from('meal_history').select().eq('user_id', user.id);

    if (startDate != null) {
      query = query.gte('meal_date', startDate.toIso8601String().split('T')[0]);
    }
    if (endDate != null) {
      query = query.lte('meal_date', endDate.toIso8601String().split('T')[0]);
    }
    if (mealType != null) {
      query = query.eq('meal_type', mealType);
    }

    final data = await query.order('meal_date', ascending: false);

    return List<Map<String, dynamic>>.from(data);
  }

  /// Get meal history for specific date
  static Future<List<Map<String, dynamic>>> getMealHistoryByDate(
    DateTime date,
  ) async {
    final user = supabase.auth.currentUser;
    if (user == null) return [];

    final data = await supabase
        .from('meal_history')
        .select()
        .eq('user_id', user.id)
        .eq('meal_date', date.toIso8601String().split('T')[0])
        .order('created_at', ascending: true);

    return List<Map<String, dynamic>>.from(data);
  }

  /// Get recent meal history (last N days)
  static Future<List<Map<String, dynamic>>> getRecentMealHistory(
    int days,
  ) async {
    final endDate = DateTime.now();
    final startDate = endDate.subtract(Duration(days: days));
    return getMealHistory(startDate: startDate, endDate: endDate);
  }

  /// Delete meal from history
  static Future<void> deleteMealFromHistory(String mealHistoryId) async {
    final user = supabase.auth.currentUser;
    if (user == null) throw Exception('Not authenticated');

    await supabase
        .from('meal_history')
        .delete()
        .eq('id', mealHistoryId)
        .eq('user_id', user.id);
  }
}
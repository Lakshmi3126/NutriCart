import '../core/supabase_client.dart';

/// Service for managing daily meal plans in Supabase
class DailyMealPlanService {
  /// Save daily meal plan
  static Future<void> saveMealPlan({
    required DateTime planDate,
    required Map<String, dynamic> meals,
    required Map<String, dynamic> dailyTargets,
    required Map<String, dynamic> adjustedTargets,
    required double adaptationScore,
    required double totalCalories,
    required double totalCost,
  }) async {
    final user = supabase.auth.currentUser;
    if (user == null) throw Exception('Not authenticated');

    await supabase.from('daily_meal_plans').upsert({
      'user_id': user.id,
      'plan_date': planDate.toIso8601String().split('T')[0],
      'meals': meals,
      'daily_targets': dailyTargets,
      'adjusted_targets': adjustedTargets,
      'adaptation_score': adaptationScore,
      'total_calories': totalCalories,
      'total_cost': totalCost,
    });
  }

  /// Get meal plan for specific date
  static Future<Map<String, dynamic>?> getMealPlanByDate(DateTime date) async {
    final user = supabase.auth.currentUser;
    if (user == null) return null;

    try {
      final data = await supabase
          .from('daily_meal_plans')
          .select()
          .eq('user_id', user.id)
          .eq('plan_date', date.toIso8601String().split('T')[0])
          .single();
      return data;
    } catch (e) {
      return null;
    }
  }

  /// Get meal plans for date range
  static Future<List<Map<String, dynamic>>> getMealPlans({
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    final user = supabase.auth.currentUser;
    if (user == null) return [];

    final data = await supabase
        .from('daily_meal_plans')
        .select()
        .eq('user_id', user.id)
        .gte('plan_date', startDate.toIso8601String().split('T')[0])
        .lte('plan_date', endDate.toIso8601String().split('T')[0])
        .order('plan_date', ascending: false);

    return List<Map<String, dynamic>>.from(data);
  }

  /// Get recent meal plans (last N days)
  static Future<List<Map<String, dynamic>>> getRecentMealPlans(int days) async {
    final endDate = DateTime.now();
    final startDate = endDate.subtract(Duration(days: days));
    return getMealPlans(startDate: startDate, endDate: endDate);
  }

  /// Delete meal plan
  static Future<void> deleteMealPlan(DateTime planDate) async {
    final user = supabase.auth.currentUser;
    if (user == null) throw Exception('Not authenticated');

    await supabase
        .from('daily_meal_plans')
        .delete()
        .eq('user_id', user.id)
        .eq('plan_date', planDate.toIso8601String().split('T')[0]);
  }
}

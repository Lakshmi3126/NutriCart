import '../core/supabase_client.dart';

/// Service for tracking daily nutrient consumption in Supabase
class NutrientTrackingService {
  /// Save or update daily nutrient tracking
  static Future<void> saveNutrientTracking({
    required DateTime trackingDate,
    required double calories,
    required double protein,
    required double carbs,
    required double fat,
    required double fiber,
  }) async {
    final user = supabase.auth.currentUser;
    if (user == null) throw Exception('Not authenticated');

    await supabase.from('nutrient_tracking').upsert({
      'user_id': user.id,
      'tracking_date': trackingDate.toIso8601String().split('T')[0],
      'calories': calories,
      'protein': protein,
      'carbs': carbs,
      'fat': fat,
      'fiber': fiber,
    });
  }

  /// Get nutrient tracking for specific date
  static Future<Map<String, dynamic>?> getNutrientTrackingByDate(
    DateTime date,
  ) async {
    final user = supabase.auth.currentUser;
    if (user == null) return null;

    try {
      final data = await supabase
          .from('nutrient_tracking')
          .select()
          .eq('user_id', user.id)
          .eq('tracking_date', date.toIso8601String().split('T')[0])
          .single();
      return data;
    } catch (e) {
      return null;
    }
  }

  /// Get nutrient tracking for date range
  static Future<List<Map<String, dynamic>>> getNutrientTracking({
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    final user = supabase.auth.currentUser;
    if (user == null) return [];

    final data = await supabase
        .from('nutrient_tracking')
        .select()
        .eq('user_id', user.id)
        .gte('tracking_date', startDate.toIso8601String().split('T')[0])
        .lte('tracking_date', endDate.toIso8601String().split('T')[0])
        .order('tracking_date', ascending: false);

    return List<Map<String, dynamic>>.from(data);
  }

  /// Get recent nutrient tracking (last N days)
  static Future<List<Map<String, dynamic>>> getRecentNutrientTracking(
    int days,
  ) async {
    final endDate = DateTime.now();
    final startDate = endDate.subtract(Duration(days: days));
    return getNutrientTracking(startDate: startDate, endDate: endDate);
  }

  /// Calculate average nutrients over period
  static Future<Map<String, double>> calculateAverageNutrients(int days) async {
    final tracking = await getRecentNutrientTracking(days);
    if (tracking.isEmpty) {
      return {
        'calories': 0.0,
        'protein': 0.0,
        'carbs': 0.0,
        'fat': 0.0,
        'fiber': 0.0,
      };
    }

    final totals = tracking.fold<Map<String, double>>(
      {'calories': 0.0, 'protein': 0.0, 'carbs': 0.0, 'fat': 0.0, 'fiber': 0.0},
      (acc, item) {
        acc['calories'] =
            (acc['calories'] ?? 0.0) + (item['calories'] as num).toDouble();
        acc['protein'] =
            (acc['protein'] ?? 0.0) + (item['protein'] as num).toDouble();
        acc['carbs'] =
            (acc['carbs'] ?? 0.0) + (item['carbs'] as num).toDouble();
        acc['fat'] = (acc['fat'] ?? 0.0) + (item['fat'] as num).toDouble();
        acc['fiber'] =
            (acc['fiber'] ?? 0.0) + (item['fiber'] as num).toDouble();
        return acc;
      },
    );

    final count = tracking.length.toDouble();
    return {
      'calories': totals['calories']! / count,
      'protein': totals['protein']! / count,
      'carbs': totals['carbs']! / count,
      'fat': totals['fat']! / count,
      'fiber': totals['fiber']! / count,
    };
  }
}

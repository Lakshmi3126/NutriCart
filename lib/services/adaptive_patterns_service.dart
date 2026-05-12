import '../core/supabase_client.dart';

/// Service for managing adaptive learning patterns in Supabase
class AdaptivePatternsService {
  /// Save adaptive pattern
  static Future<void> saveAdaptivePattern({
    required String mealType,
    required String patternType,
    required Map<String, dynamic> patternData,
    required double confidenceScore,
  }) async {
    final user = supabase.auth.currentUser;
    if (user == null) throw Exception('Not authenticated');

    // Check if pattern exists
    final existing = await supabase
        .from('adaptive_patterns')
        .select()
        .eq('user_id', user.id)
        .eq('meal_type', mealType)
        .eq('pattern_type', patternType)
        .maybeSingle();

    if (existing != null) {
      // Update existing pattern
      await supabase
          .from('adaptive_patterns')
          .update({
            'pattern_data': patternData,
            'confidence_score': confidenceScore,
            'last_updated': DateTime.now().toIso8601String(),
          })
          .eq('id', existing['id']);
    } else {
      // Insert new pattern
      await supabase.from('adaptive_patterns').insert({
        'user_id': user.id,
        'meal_type': mealType,
        'pattern_type': patternType,
        'pattern_data': patternData,
        'confidence_score': confidenceScore,
      });
    }
  }

  /// Get adaptive patterns for user
  static Future<List<Map<String, dynamic>>> getAdaptivePatterns({
    String? mealType,
    String? patternType,
  }) async {
    final user = supabase.auth.currentUser;
    if (user == null) return [];

    var query = supabase
        .from('adaptive_patterns')
        .select()
        .eq('user_id', user.id);

    if (mealType != null) {
      query = query.eq('meal_type', mealType);
    }
    if (patternType != null) {
      query = query.eq('pattern_type', patternType);
    }

    final data = await query.order('confidence_score', ascending: false);
    return List<Map<String, dynamic>>.from(data);
  }

  /// Get specific adaptive pattern
  static Future<Map<String, dynamic>?> getAdaptivePattern({
    required String mealType,
    required String patternType,
  }) async {
    final user = supabase.auth.currentUser;
    if (user == null) return null;

    try {
      final data = await supabase
          .from('adaptive_patterns')
          .select()
          .eq('user_id', user.id)
          .eq('meal_type', mealType)
          .eq('pattern_type', patternType)
          .single();
      return data;
    } catch (e) {
      return null;
    }
  }

  /// Delete adaptive pattern
  static Future<void> deleteAdaptivePattern(String patternId) async {
    final user = supabase.auth.currentUser;
    if (user == null) throw Exception('Not authenticated');

    await supabase
        .from('adaptive_patterns')
        .delete()
        .eq('id', patternId)
        .eq('user_id', user.id);
  }

  /// Clear all adaptive patterns (reset learning)
  static Future<void> clearAllPatterns() async {
    final user = supabase.auth.currentUser;
    if (user == null) throw Exception('Not authenticated');

    await supabase.from('adaptive_patterns').delete().eq('user_id', user.id);
  }
}
import '../core/supabase_client.dart';

/// Service for managing user profiles in Supabase
class UserProfileService {
  /// Get current user profile
  static Future<Map<String, dynamic>?> getCurrentUserProfile() async {
    final user = supabase.auth.currentUser;
    if (user == null) return null;

    try {
      final data = await supabase
          .from('user_profiles')
          .select()
          .eq('id', user.id)
          .single();
      return data;
    } catch (e) {
      return null;
    }
  }

  /// Update user profile
  static Future<void> updateUserProfile({
    String? fullName,
    int? age,
    String? gender,
    double? weight,
    double? monthlyBudget,
  }) async {
    final user = supabase.auth.currentUser;
    if (user == null) throw Exception('Not authenticated');

    final updates = <String, dynamic>{};
    if (fullName != null) updates['full_name'] = fullName;
    if (age != null) updates['age'] = age;
    if (gender != null) updates['gender'] = gender;
    if (weight != null) updates['weight'] = weight;
    if (monthlyBudget != null) updates['monthly_budget'] = monthlyBudget;

    await supabase.from('user_profiles').update(updates).eq('id', user.id);
  }

  /// Get user health conditions
  static Future<List<Map<String, dynamic>>> getHealthConditions() async {
    final user = supabase.auth.currentUser;
    if (user == null) return [];

    final data = await supabase
        .from('health_conditions')
        .select()
        .eq('user_id', user.id);
    return List<Map<String, dynamic>>.from(data);
  }

  /// Add health condition
  static Future<void> addHealthCondition(
    String conditionName, {
    double? hba1c,
    String? notes,
  }) async {
    final user = supabase.auth.currentUser;
    if (user == null) throw Exception('Not authenticated');

    await supabase.from('health_conditions').insert({
      'user_id': user.id,
      'condition_name': conditionName,
      'hba1c': hba1c,
      'notes': notes,
    });
  }

  /// Remove health condition
  static Future<void> removeHealthCondition(String conditionId) async {
    final user = supabase.auth.currentUser;
    if (user == null) throw Exception('Not authenticated');

    await supabase
        .from('health_conditions')
        .delete()
        .eq('id', conditionId)
        .eq('user_id', user.id);
  }

  /// Get dietary preferences
  static Future<List<String>> getDietaryPreferences() async {
    final user = supabase.auth.currentUser;
    if (user == null) return [];

    final data = await supabase
        .from('dietary_preferences')
        .select('preference_name')
        .eq('user_id', user.id);
    return List<String>.from(data.map((item) => item['preference_name']));
  }

  /// Set dietary preferences (replaces existing)
  static Future<void> setDietaryPreferences(Set<String> preferences) async {
    final user = supabase.auth.currentUser;
    if (user == null) throw Exception('Not authenticated');

    // Delete existing preferences
    await supabase.from('dietary_preferences').delete().eq('user_id', user.id);

    // Insert new preferences
    if (preferences.isNotEmpty) {
      final inserts = preferences
          .map((pref) => {'user_id': user.id, 'preference_name': pref})
          .toList();
      await supabase.from('dietary_preferences').insert(inserts);
    }
  }

  /// Get allergies
  static Future<List<Map<String, dynamic>>> getAllergies() async {
    final user = supabase.auth.currentUser;
    if (user == null) return [];

    final data = await supabase
        .from('allergies')
        .select()
        .eq('user_id', user.id);
    return List<Map<String, dynamic>>.from(data);
  }

  /// Add allergy
  static Future<void> addAllergy(
    String allergenName, {
    String? severity,
  }) async {
    final user = supabase.auth.currentUser;
    if (user == null) throw Exception('Not authenticated');

    await supabase.from('allergies').insert({
      'user_id': user.id,
      'allergen_name': allergenName,
      'severity': severity,
    });
  }

  /// Remove allergy
  static Future<void> removeAllergy(String allergyId) async {
    final user = supabase.auth.currentUser;
    if (user == null) throw Exception('Not authenticated');

    await supabase
        .from('allergies')
        .delete()
        .eq('id', allergyId)
        .eq('user_id', user.id);
  }
}

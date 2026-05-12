import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import '../models/meal_feedback.dart';
import '../core/supabase_client.dart';
import './meal_api_service.dart';

/// Service for managing meal feedback persistence and retrieval
class MealFeedbackService {
  static const String _feedbackKey = 'meal_feedback_history';
  final _uuid = const Uuid();
  final MealApiService _mealApiService = MealApiService();

  /// Save meal feedback to backend and Supabase
  Future<void> saveFeedback(MealFeedback feedback) async {
    final user = supabase.auth.currentUser;
    if (user == null) {
      // Fallback to local storage if not authenticated
      return _saveFeedbackLocally(feedback);
    }

    try {
      // Submit to backend API first
      await _mealApiService.submitMealFeedback(
        mealId: feedback.mealId,
        mealType: feedback.mealType,
        date: feedback.date,
        status: feedback.status.name,
        portionConsumed: feedback.portionConsumed,
        reason: feedback.reason,
      );

      // Also save to Supabase for persistence
      await supabase.from('meal_feedback').insert({
        'user_id': user.id,
        'meal_id': feedback.mealId,
        'meal_type': feedback.mealType,
        'feedback_date': feedback.date.toIso8601String().split('T')[0],
        'status': feedback.status.name,
        'portion_consumed': feedback.portionConsumed,
        'reason': feedback.reason,
      });
    } catch (e) {
      print('Error saving feedback to backend: $e');
      // Fallback to local storage on error
      await _saveFeedbackLocally(feedback);
    }
  }

  /// Save feedback locally (fallback)
  Future<void> _saveFeedbackLocally(MealFeedback feedback) async {
    final prefs = await SharedPreferences.getInstance();
    final feedbackList = await getAllFeedback();
    feedbackList.add(feedback);

    final jsonList = feedbackList.map((f) => f.toJson()).toList();
    await prefs.setString(_feedbackKey, jsonEncode(jsonList));
  }

  /// Get all feedback history from Supabase
  Future<List<MealFeedback>> getAllFeedback() async {
    final user = supabase.auth.currentUser;
    if (user == null) {
      return _getAllFeedbackLocally();
    }

    try {
      final data = await supabase
          .from('meal_feedback')
          .select()
          .eq('user_id', user.id)
          .order('feedback_date', ascending: false);

      return data.map<MealFeedback>((item) {
        return MealFeedback(
          id: item['id'] as String,
          mealId: item['meal_id'] as String,
          mealType: item['meal_type'] as String,
          date: DateTime.parse(item['feedback_date'] as String),
          status: FeedbackStatus.values.firstWhere(
            (e) => e.name == item['status'],
            orElse: () => FeedbackStatus.eaten,
          ),
          portionConsumed: (item['portion_consumed'] as num).toDouble(),
          reason: item['reason'] as String?,
          timestamp: DateTime.parse(item['timestamp'] as String),
        );
      }).toList();
    } catch (e) {
      return _getAllFeedbackLocally();
    }
  }

  /// Get feedback locally (fallback)
  Future<List<MealFeedback>> _getAllFeedbackLocally() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_feedbackKey);

    if (jsonString == null) return [];

    final List<dynamic> jsonList = jsonDecode(jsonString);
    return jsonList
        .map((json) => MealFeedback.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  /// Get feedback for specific date
  Future<List<MealFeedback>> getFeedbackByDate(DateTime date) async {
    final allFeedback = await getAllFeedback();
    return allFeedback.where((f) {
      return f.date.year == date.year &&
          f.date.month == date.month &&
          f.date.day == date.day;
    }).toList();
  }

  /// Get feedback for specific meal type
  Future<List<MealFeedback>> getFeedbackByMealType(String mealType) async {
    final allFeedback = await getAllFeedback();
    return allFeedback.where((f) => f.mealType == mealType).toList();
  }

  /// Get feedback for specific meal ID
  Future<List<MealFeedback>> getFeedbackByMealId(String mealId) async {
    final allFeedback = await getAllFeedback();
    return allFeedback.where((f) => f.mealId == mealId).toList();
  }

  /// Get recent feedback (last N days)
  Future<List<MealFeedback>> getRecentFeedback({int days = 7}) async {
    final allFeedback = await getAllFeedback();
    final cutoffDate = DateTime.now().subtract(Duration(days: days));
    return allFeedback.where((f) => f.date.isAfter(cutoffDate)).toList();
  }

  /// Calculate skip rate for a meal type
  Future<double> calculateSkipRate(String mealType, {int days = 7}) async {
    final recentFeedback = await getRecentFeedback(days: days);
    final mealTypeFeedback = recentFeedback
        .where((f) => f.mealType == mealType)
        .toList();

    if (mealTypeFeedback.isEmpty) return 0.0;

    final skippedCount = mealTypeFeedback
        .where((f) => f.status == FeedbackStatus.skipped)
        .length;
    return skippedCount / mealTypeFeedback.length;
  }

  /// Calculate average portion consumed for a meal type
  Future<double> calculateAveragePortionConsumed(
    String mealType, {
    int days = 7,
  }) async {
    final recentFeedback = await getRecentFeedback(days: days);
    final mealTypeFeedback = recentFeedback
        .where(
          (f) => f.mealType == mealType && f.status != FeedbackStatus.skipped,
        )
        .toList();

    if (mealTypeFeedback.isEmpty) return 1.0;

    final totalPortion = mealTypeFeedback.fold<double>(
      0.0,
      (sum, f) => sum + f.portionConsumed,
    );
    return totalPortion / mealTypeFeedback.length;
  }

  /// Get most skipped meals
  Future<Map<String, int>> getMostSkippedMeals({int days = 7}) async {
    final recentFeedback = await getRecentFeedback(days: days);
    final skippedFeedback = recentFeedback
        .where((f) => f.status == FeedbackStatus.skipped)
        .toList();

    final Map<String, int> skipCounts = {};
    for (final feedback in skippedFeedback) {
      skipCounts[feedback.mealId] = (skipCounts[feedback.mealId] ?? 0) + 1;
    }

    return skipCounts;
  }

  /// Generate unique feedback ID
  String generateFeedbackId() => _uuid.v4();

  /// Clear all feedback (for testing/reset)
  Future<void> clearAllFeedback() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_feedbackKey);
  }
}

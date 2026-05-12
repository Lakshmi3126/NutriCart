/// Mocked data service for Health Insights
/// Provides realistic health analytics data structured like a real API response
class HealthInsightsMockService {
  /// Get comprehensive health insights for the user
  static Future<Map<String, dynamic>> getHealthInsights() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 900));

    return {
      'healthScore': 82,
      'weeklyChange': 3,
      'persona': 'Sunita Rao',
      'healthConditions': [
        {
          'id': 'hc_001',
          'name': 'Type 2 Diabetes',
          'status': 'insightsStatusStable',
          'adherenceScore': 84,
          'trend': 'improving',
          'icon': 'favorite',
          'color': '#43A047',
        },
        {
          'id': 'hc_002',
          'name': 'Mild Hypertension',
          'status': 'insightsStatusStable',
          'adherenceScore': 79,
          'trend': 'stable',
          'icon': 'monitor_heart',
          'color': '#4A90A4',
        },
      ],
      'nutrientBalance': {
        'calories': {
          'name': 'Calories',
          'current': 1685,
          'target': 1780,
          'percentage': 95,
          'status': 'good',
          'unit': 'kcal',
        },
        'protein': {
          'name': 'Protein',
          'current': 63,
          'target': 62,
          'percentage': 101,
          'status': 'good',
          'unit': 'g',
        },
        'fiber': {
          'name': 'Fiber',
          'current': 28,
          'target': 30,
          'percentage': 93,
          'status': 'borderline',
          'unit': 'g',
        },
        'sugar': {
          'name': 'Added Sugar',
          'current': 22,
          'target': 25,
          'percentage': 88,
          'status': 'good',
          'unit': 'g',
        },
        'sodium': {
          'name': 'Sodium',
          'current': 1560,
          'target': 1700,
          'percentage': 92,
          'status': 'good',
          'unit': 'mg',
        },
      },
      'weeklyTrends': {
        'mealAdherence': [
          {'day': 'Mon', 'value': 82},
          {'day': 'Tue', 'value': 86},
          {'day': 'Wed', 'value': 78},
          {'day': 'Thu', 'value': 90},
          {'day': 'Fri', 'value': 84},
          {'day': 'Sat', 'value': 87},
          {'day': 'Sun', 'value': 89},
        ],
        'calorieIntake': [
          {'day': 'Mon', 'value': 1680},
          {'day': 'Tue', 'value': 1715},
          {'day': 'Wed', 'value': 1665},
          {'day': 'Thu', 'value': 1730},
          {'day': 'Fri', 'value': 1695},
          {'day': 'Sat', 'value': 1750},
          {'day': 'Sun', 'value': 1675},
        ],
        'budgetUsage': [
          {'day': 'Mon', 'value': 228},
          {'day': 'Tue', 'value': 236},
          {'day': 'Wed', 'value': 222},
          {'day': 'Thu', 'value': 242},
          {'day': 'Fri', 'value': 231},
          {'day': 'Sat', 'value': 248},
          {'day': 'Sun', 'value': 219},
        ],
      },
      'insights': [
        {
          'id': 'ins_001',
          'type': 'behavior',
          'title': 'Breakfast timing improved this week',
          'description':
              'Only one delayed breakfast this week versus three last week, helping steadier glucose mornings.',
          'icon': 'schedule',
          'priority': 'high',
        },
        {
          'id': 'ins_002',
          'type': 'nutrient',
          'title': 'Lunch fiber intake is stronger',
          'description':
              'Extra vegetables and dal portions improved fiber coverage on school days.',
          'icon': 'trending_up',
          'priority': 'medium',
        },
        {
          'id': 'ins_003',
          'type': 'budget',
          'title': 'Seasonal buying lowered spend',
          'description':
              'Switching to avarekalu, beans, and local greens reduced weekly cost without nutrition compromise.',
          'icon': 'savings',
          'priority': 'low',
        },
        {
          'id': 'ins_004',
          'type': 'nutrient',
          'title': 'Sodium trend is improving',
          'description':
              'This week\'s sodium intake improved by 11% with less pickle and lower-salt chutney prep.',
          'icon': 'monitor_heart',
          'priority': 'high',
        },
      ],
      'recommendations': [
        {
          'id': 'rec_001',
          'title': 'Keep mixed-rice strategy at lunch',
          'description':
              'Continue 60:40 white-to-brown rice mix for family acceptance and better glucose response.',
          'actionable': true,
          'icon': 'restaurant',
        },
        {
          'id': 'rec_002',
          'title': 'Use low-sodium chutney base',
          'description':
              'Replace extra salt with roasted garlic, curry leaves, and lemon to manage blood pressure.',
          'actionable': true,
          'icon': 'health_and_safety',
        },
        {
          'id': 'rec_003',
          'title': 'Protein intake is on track',
          'description':
              'Current dal, curd, and legume pattern is adequate; maintain present serving sizes.',
          'actionable': false,
          'icon': 'thumb_up',
        },
        {
          'id': 'rec_004',
          'title': 'Prepare Monday breakfast on Sunday',
          'description':
              'Soak batter and pre-chop vegetables to avoid breakfast skipping on school mornings.',
          'actionable': true,
          'icon': 'event_note',
        },
      ],
    };
  }
}

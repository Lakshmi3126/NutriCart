/// Meal feedback data model for tracking user consumption patterns
class MealFeedback {
  final String id;
  final String mealId;
  final String mealType; // breakfast, lunch, dinner, snacks
  final DateTime date;
  final FeedbackStatus status; // eaten, skipped, partial
  final double portionConsumed; // 0.0 to 1.0 for partial consumption
  final String? reason; // Optional reason for skipping/partial
  final DateTime timestamp;

  MealFeedback({
    required this.id,
    required this.mealId,
    required this.mealType,
    required this.date,
    required this.status,
    required this.portionConsumed,
    this.reason,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'mealId': mealId,
    'mealType': mealType,
    'date': date.toIso8601String(),
    'status': status.name,
    'portionConsumed': portionConsumed,
    'reason': reason,
    'timestamp': timestamp.toIso8601String(),
  };

  factory MealFeedback.fromJson(Map<String, dynamic> json) => MealFeedback(
    id: json['id'] as String,
    mealId: json['mealId'] as String,
    mealType: json['mealType'] as String,
    date: DateTime.parse(json['date'] as String),
    status: FeedbackStatus.values.firstWhere(
      (e) => e.name == json['status'],
      orElse: () => FeedbackStatus.eaten,
    ),
    portionConsumed: (json['portionConsumed'] as num).toDouble(),
    reason: json['reason'] as String?,
    timestamp: DateTime.parse(json['timestamp'] as String),
  );

  MealFeedback copyWith({
    String? id,
    String? mealId,
    String? mealType,
    DateTime? date,
    FeedbackStatus? status,
    double? portionConsumed,
    String? reason,
    DateTime? timestamp,
  }) => MealFeedback(
    id: id ?? this.id,
    mealId: mealId ?? this.mealId,
    mealType: mealType ?? this.mealType,
    date: date ?? this.date,
    status: status ?? this.status,
    portionConsumed: portionConsumed ?? this.portionConsumed,
    reason: reason ?? this.reason,
    timestamp: timestamp ?? this.timestamp,
  );
}

enum FeedbackStatus { eaten, skipped, partial }

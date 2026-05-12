/// Adaptive meal plan model that adjusts based on user behavior
class AdaptiveMealPlan {
  final DateTime date;
  final Map<String, MealRecommendation>
  meals; // breakfast, lunch, dinner, snacks
  final NutrientTargets dailyTargets;
  final NutrientTargets adjustedTargets;
  final double
  adaptationScore; // 0.0 to 1.0 indicating how much plan is adapted

  AdaptiveMealPlan({
    required this.date,
    required this.meals,
    required this.dailyTargets,
    required this.adjustedTargets,
    this.adaptationScore = 0.0,
  });

  Map<String, dynamic> toJson() => {
    'date': date.toIso8601String(),
    'meals': meals.map((key, value) => MapEntry(key, value.toJson())),
    'dailyTargets': dailyTargets.toJson(),
    'adjustedTargets': adjustedTargets.toJson(),
    'adaptationScore': adaptationScore,
  };

  factory AdaptiveMealPlan.fromJson(Map<String, dynamic> json) =>
      AdaptiveMealPlan(
        date: DateTime.parse(json['date'] as String),
        meals: (json['meals'] as Map<String, dynamic>).map(
          (key, value) => MapEntry(
            key,
            MealRecommendation.fromJson(value as Map<String, dynamic>),
          ),
        ),
        dailyTargets: NutrientTargets.fromJson(
          json['dailyTargets'] as Map<String, dynamic>,
        ),
        adjustedTargets: NutrientTargets.fromJson(
          json['adjustedTargets'] as Map<String, dynamic>,
        ),
        adaptationScore: (json['adaptationScore'] as num?)?.toDouble() ?? 0.0,
      );
}

class MealRecommendation {
  final Map<String, dynamic> meal;
  final double portionMultiplier;
  final String replacementReason; // Why this meal was chosen/replaced
  final bool isReplacement;

  MealRecommendation({
    required this.meal,
    this.portionMultiplier = 1.0,
    this.replacementReason = '',
    this.isReplacement = false,
  });

  Map<String, dynamic> toJson() => {
    'meal': meal,
    'portionMultiplier': portionMultiplier,
    'replacementReason': replacementReason,
    'isReplacement': isReplacement,
  };

  factory MealRecommendation.fromJson(Map<String, dynamic> json) =>
      MealRecommendation(
        meal: json['meal'] as Map<String, dynamic>,
        portionMultiplier:
            (json['portionMultiplier'] as num?)?.toDouble() ?? 1.0,
        replacementReason: json['replacementReason'] as String? ?? '',
        isReplacement: json['isReplacement'] as bool? ?? false,
      );
}

class NutrientTargets {
  final double calories;
  final double protein;
  final double carbs;
  final double fat;
  final double fiber;

  NutrientTargets({
    required this.calories,
    required this.protein,
    required this.carbs,
    required this.fat,
    required this.fiber,
  });

  Map<String, dynamic> toJson() => {
    'calories': calories,
    'protein': protein,
    'carbs': carbs,
    'fat': fat,
    'fiber': fiber,
  };

  factory NutrientTargets.fromJson(Map<String, dynamic> json) =>
      NutrientTargets(
        calories: (json['calories'] as num).toDouble(),
        protein: (json['protein'] as num).toDouble(),
        carbs: (json['carbs'] as num).toDouble(),
        fat: (json['fat'] as num).toDouble(),
        fiber: (json['fiber'] as num).toDouble(),
      );

  NutrientTargets copyWith({
    double? calories,
    double? protein,
    double? carbs,
    double? fat,
    double? fiber,
  }) => NutrientTargets(
    calories: calories ?? this.calories,
    protein: protein ?? this.protein,
    carbs: carbs ?? this.carbs,
    fat: fat ?? this.fat,
    fiber: fiber ?? this.fiber,
  );

  NutrientTargets operator +(NutrientTargets other) => NutrientTargets(
    calories: calories + other.calories,
    protein: protein + other.protein,
    carbs: carbs + other.carbs,
    fat: fat + other.fat,
    fiber: fiber + other.fiber,
  );

  NutrientTargets operator *(double multiplier) => NutrientTargets(
    calories: calories * multiplier,
    protein: protein * multiplier,
    carbs: carbs * multiplier,
    fat: fat * multiplier,
    fiber: fiber * multiplier,
  );
}

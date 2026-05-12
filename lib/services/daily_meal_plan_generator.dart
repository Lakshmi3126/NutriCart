
import '../models/dish.dart';
import '../models/meal_plan_output.dart';
import './meal_filter_service.dart';

class DailyMealPlanGenerator {
  /// Generate daily meal plan with calorie and budget targeting
  static MealPlanOutput generateDailyMealPlan({
    required List<String> healthConditions,
    required String dietaryPreference,
    required String cuisinePreference,
    required int dailyCalorieTarget,
    required double monthlyBudget,
    bool includeSnacks = false,
  }) {
    // Calculate daily budget from monthly budget
    double dailyBudget = monthlyBudget / 30;

    // Calculate target calories per meal
    int breakfastTarget = (dailyCalorieTarget * 0.25).round();
    int lunchTarget = (dailyCalorieTarget * 0.40).round();
    int dinnerTarget = (dailyCalorieTarget * 0.35).round();
    int snackTarget = 0;

    if (includeSnacks) {
      breakfastTarget = (dailyCalorieTarget * 0.20).round();
      lunchTarget = (dailyCalorieTarget * 0.35).round();
      dinnerTarget = (dailyCalorieTarget * 0.30).round();
      snackTarget = (dailyCalorieTarget * 0.15).round();
    }

    // Calculate budget per meal
    double breakfastBudget = dailyBudget * 0.20;
    double lunchBudget = dailyBudget * 0.40;
    double dinnerBudget = dailyBudget * 0.40;
    double snackBudget = 0;

    if (includeSnacks) {
      breakfastBudget = dailyBudget * 0.15;
      lunchBudget = dailyBudget * 0.35;
      dinnerBudget = dailyBudget * 0.35;
      snackBudget = dailyBudget * 0.15;
    }

    List<SelectedMeal> selectedMeals = [];

    // Select breakfast
    Dish? breakfast = _selectMealForType(
      mealType: 'Breakfast',
      healthConditions: healthConditions,
      dietaryPreference: dietaryPreference,
      cuisinePreference: cuisinePreference,
      calorieTarget: breakfastTarget,
      maxBudget: breakfastBudget,
    );

    if (breakfast != null) {
      selectedMeals.add(_createSelectedMeal(breakfast, 'Breakfast'));
    }

    // Select lunch
    Dish? lunch = _selectMealForType(
      mealType: 'Lunch',
      healthConditions: healthConditions,
      dietaryPreference: dietaryPreference,
      cuisinePreference: cuisinePreference,
      calorieTarget: lunchTarget,
      maxBudget: lunchBudget,
    );

    if (lunch != null) {
      selectedMeals.add(_createSelectedMeal(lunch, 'Lunch'));
    }

    // Select dinner
    Dish? dinner = _selectMealForType(
      mealType: 'Dinner',
      healthConditions: healthConditions,
      dietaryPreference: dietaryPreference,
      cuisinePreference: cuisinePreference,
      calorieTarget: dinnerTarget,
      maxBudget: dinnerBudget,
    );

    if (dinner != null) {
      selectedMeals.add(_createSelectedMeal(dinner, 'Dinner'));
    }

    // Select snack if requested
    if (includeSnacks) {
      Dish? snack = _selectMealForType(
        mealType: 'Snack',
        healthConditions: healthConditions,
        dietaryPreference: dietaryPreference,
        cuisinePreference: cuisinePreference,
        calorieTarget: snackTarget,
        maxBudget: snackBudget,
      );

      if (snack != null) {
        selectedMeals.add(_createSelectedMeal(snack, 'Snack'));
      }
    }

    // Calculate totals
    int totalCalories = selectedMeals.fold(
      0,
      (sum, meal) => sum + meal.calories,
    );
    double totalCost = selectedMeals.fold(0.0, (sum, meal) => sum + meal.cost);

    // Calculate nutrient summary
    NutrientSummary nutrientSummary = _calculateNutrientSummary(selectedMeals);

    return MealPlanOutput(
      selectedMeals: selectedMeals,
      totalCalories: totalCalories,
      totalCost: totalCost,
      nutrientSummary: nutrientSummary,
      generatedDate: DateTime.now(),
      planType: 'Daily Meal Plan',
    );
  }

  /// Select best meal for a specific meal type
  static Dish? _selectMealForType({
    required String mealType,
    required List<String> healthConditions,
    required String dietaryPreference,
    required String cuisinePreference,
    required int calorieTarget,
    required double maxBudget,
  }) {
    // Get suitable dishes
    List<Dish> suitableDishes = MealFilterService.getSuitableDishes(
      mealType: mealType,
      healthConditions: healthConditions,
      dietaryPreference: dietaryPreference,
      cuisinePreference: cuisinePreference,
      maxCostPerMeal: maxBudget,
    );

    if (suitableDishes.isEmpty) {
      // Fallback: relax cuisine preference
      suitableDishes = MealFilterService.getSuitableDishes(
        mealType: mealType,
        healthConditions: healthConditions,
        dietaryPreference: dietaryPreference,
        cuisinePreference: '',
        maxCostPerMeal: maxBudget,
      );
    }

    if (suitableDishes.isEmpty) return null;

    // Score each dish based on calorie match and cost efficiency
    Dish? bestDish;
    double bestScore = -1;

    for (Dish dish in suitableDishes) {
      double calorieScore = _calculateCalorieScore(
        dish.caloriesPerServing,
        calorieTarget,
      );
      double costScore = _calculateCostScore(dish.estimatedCostInr, maxBudget);
      double nutritionScore = _calculateNutritionScore(dish, healthConditions);

      // Weighted scoring: 40% calorie match, 30% cost efficiency, 30% nutrition
      double totalScore =
          (calorieScore * 0.4) + (costScore * 0.3) + (nutritionScore * 0.3);

      if (totalScore > bestScore) {
        bestScore = totalScore;
        bestDish = dish;
      }
    }

    return bestDish;
  }

  /// Calculate calorie match score (0-100)
  static double _calculateCalorieScore(int actualCalories, int targetCalories) {
    if (targetCalories == 0) return 50.0;

    double difference =
        (actualCalories - targetCalories).abs() / targetCalories;

    if (difference <= 0.1) return 100.0; // Within 10%
    if (difference <= 0.2) return 80.0; // Within 20%
    if (difference <= 0.3) return 60.0; // Within 30%
    if (difference <= 0.5) return 40.0; // Within 50%
    return 20.0;
  }

  /// Calculate cost efficiency score (0-100)
  static double _calculateCostScore(double actualCost, double maxBudget) {
    if (maxBudget == 0) return 50.0;

    double ratio = actualCost / maxBudget;

    if (ratio <= 0.5) return 100.0; // Very affordable
    if (ratio <= 0.7) return 80.0; // Good value
    if (ratio <= 0.9) return 60.0; // Acceptable
    if (ratio <= 1.0) return 40.0; // At budget limit
    return 20.0; // Over budget
  }

  /// Calculate nutrition score based on health conditions (0-100)
  static double _calculateNutritionScore(
    Dish dish,
    List<String> healthConditions,
  ) {
    double score = 50.0; // Base score

    // Bonus for high fiber
    if (dish.fiberG >= 5.0)
      score += 15.0;
    else if (dish.fiberG >= 3.0)
      score += 10.0;

    // Bonus for high protein
    if (dish.proteinG >= 15.0)
      score += 15.0;
    else if (dish.proteinG >= 8.0)
      score += 10.0;

    // Bonus for low sodium
    if (dish.sodiumMg <= 300)
      score += 10.0;
    else if (dish.sodiumMg <= 400)
      score += 5.0;

    // Bonus for low GI
    if (dish.glycemicIndexCategory == 'low') score += 10.0;

    return score.clamp(0.0, 100.0);
  }

  /// Create SelectedMeal from Dish
  static SelectedMeal _createSelectedMeal(Dish dish, String mealType) {
    return SelectedMeal(
      mealType: mealType,
      dishName: dish.dishName,
      dishId: dish.dishId,
      calories: dish.caloriesPerServing,
      cost: dish.estimatedCostInr,
      cuisineType: dish.cuisineType,
      isVegetarian: dish.isVegetarian,
      portionSize: dish.portionSize,
      macros: MacroNutrients(
        carbsG: dish.carbsG,
        proteinG: dish.proteinG,
        fatG: dish.fatG,
        fiberG: dish.fiberG,
      ),
      micros: MicroNutrients(ironMg: dish.ironMg, sodiumMg: dish.sodiumMg),
      selectionReason:
          'Selected based on health conditions, dietary preferences, and calorie target',
    );
  }

  /// Calculate nutrient summary from selected meals
  static NutrientSummary _calculateNutrientSummary(List<SelectedMeal> meals) {
    double totalCarbs = meals.fold(
      0.0,
      (sum, meal) => sum + meal.macros.carbsG,
    );
    double totalProtein = meals.fold(
      0.0,
      (sum, meal) => sum + meal.macros.proteinG,
    );
    double totalFat = meals.fold(0.0, (sum, meal) => sum + meal.macros.fatG);
    double totalFiber = meals.fold(
      0.0,
      (sum, meal) => sum + meal.macros.fiberG,
    );
    double totalIron = meals.fold(0.0, (sum, meal) => sum + meal.micros.ironMg);
    double totalSodium = meals.fold(
      0.0,
      (sum, meal) => sum + meal.micros.sodiumMg,
    );

    // Calculate calorie distribution from macros
    double carbCalories = totalCarbs * 4;
    double proteinCalories = totalProtein * 4;
    double fatCalories = totalFat * 9;
    double totalMacroCalories = carbCalories + proteinCalories + fatCalories;

    String carbsPercentage = totalMacroCalories > 0
        ? '${((carbCalories / totalMacroCalories) * 100).toStringAsFixed(1)}%'
        : '0%';
    String proteinPercentage = totalMacroCalories > 0
        ? '${((proteinCalories / totalMacroCalories) * 100).toStringAsFixed(1)}%'
        : '0%';
    String fatPercentage = totalMacroCalories > 0
        ? '${((fatCalories / totalMacroCalories) * 100).toStringAsFixed(1)}%'
        : '0%';

    // Check if nutrient balance is good
    double carbPercent = totalMacroCalories > 0
        ? (carbCalories / totalMacroCalories) * 100
        : 0;
    double proteinPercent = totalMacroCalories > 0
        ? (proteinCalories / totalMacroCalories) * 100
        : 0;
    double fatPercent = totalMacroCalories > 0
        ? (fatCalories / totalMacroCalories) * 100
        : 0;

    bool meetsBalance = _checkNutrientBalance(
      carbPercent,
      proteinPercent,
      fatPercent,
    );

    List<String> nutritionNotes = _generateNutritionNotes(
      totalFiber: totalFiber,
      totalProtein: totalProtein,
      totalSodium: totalSodium,
      totalIron: totalIron,
      carbPercent: carbPercent,
      proteinPercent: proteinPercent,
      fatPercent: fatPercent,
    );

    return NutrientSummary(
      totalCarbsG: totalCarbs,
      totalProteinG: totalProtein,
      totalFatG: totalFat,
      totalFiberG: totalFiber,
      totalIronMg: totalIron,
      totalSodiumMg: totalSodium,
      carbsPercentage: carbsPercentage,
      proteinPercentage: proteinPercentage,
      fatPercentage: fatPercentage,
      meetsNutrientBalance: meetsBalance,
      nutritionNotes: nutritionNotes,
    );
  }

  /// Check if nutrient balance meets healthy guidelines
  static bool _checkNutrientBalance(
    double carbPercent,
    double proteinPercent,
    double fatPercent,
  ) {
    // Healthy ranges: Carbs 45-65%, Protein 10-35%, Fat 20-35%
    bool carbsOk = carbPercent >= 45 && carbPercent <= 65;
    bool proteinOk = proteinPercent >= 10 && proteinPercent <= 35;
    bool fatOk = fatPercent >= 20 && fatPercent <= 35;

    return carbsOk && proteinOk && fatOk;
  }

  /// Generate nutrition notes based on nutrient analysis
  static List<String> _generateNutritionNotes({
    required double totalFiber,
    required double totalProtein,
    required double totalSodium,
    required double totalIron,
    required double carbPercent,
    required double proteinPercent,
    required double fatPercent,
  }) {
    List<String> notes = [];

    // Fiber assessment
    if (totalFiber >= 25) {
      notes.add('Excellent fiber content supports digestive health');
    } else if (totalFiber < 15) {
      notes.add('Consider adding more fiber-rich foods');
    }

    // Protein assessment
    if (totalProtein >= 50) {
      notes.add('Good protein intake for muscle maintenance');
    } else if (totalProtein < 30) {
      notes.add('Protein intake could be increased');
    }

    // Sodium assessment
    if (totalSodium > 2000) {
      notes.add('Sodium intake is high - consider low-sodium alternatives');
    } else if (totalSodium <= 1500) {
      notes.add('Sodium levels are well-controlled');
    }

    // Iron assessment
    if (totalIron >= 8) {
      notes.add('Good iron content for blood health');
    }

    // Macro balance assessment
    if (carbPercent > 65) {
      notes.add(
        'Carbohydrate intake is high - consider balancing with protein',
      );
    } else if (carbPercent < 45) {
      notes.add('Carbohydrate intake is low - ensure adequate energy');
    }

    if (proteinPercent < 10) {
      notes.add('Protein intake is below recommended levels');
    }

    if (fatPercent > 35) {
      notes.add('Fat intake is high - consider leaner options');
    }

    if (notes.isEmpty) {
      notes.add('Nutrient balance is well-maintained');
    }

    return notes;
  }
}

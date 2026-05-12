import '../models/dish.dart';
import '../data/meal_database.dart';

class MealFilterService {
  /// Filter dishes based on health conditions
  static List<Dish> filterByHealthConditions(
    List<Dish> dishes,
    List<String> healthConditions,
  ) {
    if (healthConditions.isEmpty) return dishes;

    return dishes.where((dish) {
      for (String condition in healthConditions) {
        switch (condition.toLowerCase()) {
          case 'diabetes':
            if (!dish.suitableForDiabetes) return false;
            break;
          case 'hypertension':
            if (!dish.suitableForHypertension) return false;
            break;
          case 'pcos':
            if (!dish.suitableForPcos) return false;
            break;
          case 'anemia':
            if (!dish.suitableForAnemia) return false;
            break;
        }
      }
      return true;
    }).toList();
  }

  /// Filter dishes by dietary preference (veg/non-veg)
  static List<Dish> filterByDietaryPreference(
    List<Dish> dishes,
    String dietaryPreference,
  ) {
    if (dietaryPreference.toLowerCase() == 'veg' ||
        dietaryPreference.toLowerCase() == 'vegetarian') {
      return dishes.where((dish) => dish.isVegetarian).toList();
    } else if (dietaryPreference.toLowerCase() == 'non-veg' ||
        dietaryPreference.toLowerCase() == 'non-vegetarian') {
      return dishes.where((dish) => !dish.isVegetarian).toList();
    }
    return dishes;
  }

  /// Filter dishes by cuisine preference
  static List<Dish> filterByCuisine(
    List<Dish> dishes,
    String cuisinePreference,
  ) {
    if (cuisinePreference.toLowerCase() == 'south indian' ||
        cuisinePreference.toLowerCase() == 'south') {
      return dishes
          .where((dish) => dish.cuisineType == 'South Indian')
          .toList();
    } else if (cuisinePreference.toLowerCase() == 'north indian' ||
        cuisinePreference.toLowerCase() == 'north') {
      return dishes
          .where((dish) => dish.cuisineType == 'North Indian')
          .toList();
    }
    return dishes;
  }

  /// Filter dishes by meal type
  static List<Dish> filterByMealType(List<Dish> dishes, String mealType) {
    return dishes
        .where((dish) => dish.mealType.toLowerCase() == mealType.toLowerCase())
        .toList();
  }

  /// Filter dishes within budget constraint
  static List<Dish> filterByBudget(List<Dish> dishes, double maxCostPerMeal) {
    return dishes
        .where((dish) => dish.estimatedCostInr <= maxCostPerMeal)
        .toList();
  }

  /// Get suitable dishes for a specific meal type with all filters applied
  static List<Dish> getSuitableDishes({
    required String mealType,
    required List<String> healthConditions,
    required String dietaryPreference,
    required String cuisinePreference,
    required double maxCostPerMeal,
  }) {
    // Start with all dishes
    List<Dish> dishes = MealDatabase.getAllDishes();

    // Apply meal type filter
    dishes = filterByMealType(dishes, mealType);

    // Apply health condition filters (most critical)
    dishes = filterByHealthConditions(dishes, healthConditions);

    // Apply dietary preference filter
    dishes = filterByDietaryPreference(dishes, dietaryPreference);

    // Apply cuisine preference filter
    dishes = filterByCuisine(dishes, cuisinePreference);

    // Apply budget filter
    dishes = filterByBudget(dishes, maxCostPerMeal);

    return dishes;
  }

  /// Check if a dish is medically safe for given conditions
  static bool isMedicallySafe(Dish dish, List<String> healthConditions) {
    if (healthConditions.isEmpty) return true;

    for (String condition in healthConditions) {
      switch (condition.toLowerCase()) {
        case 'diabetes':
          if (!dish.suitableForDiabetes) return false;
          break;
        case 'hypertension':
          if (!dish.suitableForHypertension) return false;
          break;
        case 'pcos':
          if (!dish.suitableForPcos) return false;
          break;
        case 'anemia':
          if (!dish.suitableForAnemia) return false;
          break;
      }
    }
    return true;
  }

  /// Get explanation for why a dish is suitable/unsuitable
  static Map<String, String> getMedicalExplanations(
    Dish dish,
    List<String> healthConditions,
  ) {
    Map<String, String> explanations = {};

    for (String condition in healthConditions) {
      switch (condition.toLowerCase()) {
        case 'diabetes':
          explanations['diabetes'] = dish.diabetesExplanation;
          break;
        case 'hypertension':
          explanations['hypertension'] = dish.hypertensionExplanation;
          break;
        case 'pcos':
          explanations['pcos'] = dish.pcosExplanation;
          break;
        case 'anemia':
          explanations['anemia'] = dish.anemiaExplanation;
          break;
      }
    }

    return explanations;
  }
}

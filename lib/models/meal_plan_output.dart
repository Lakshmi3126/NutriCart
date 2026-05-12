class MealPlanOutput {
  final List<SelectedMeal> selectedMeals;
  final int totalCalories;
  final double totalCost;
  final NutrientSummary nutrientSummary;
  final DateTime generatedDate;
  final String planType;

  MealPlanOutput({
    required this.selectedMeals,
    required this.totalCalories,
    required this.totalCost,
    required this.nutrientSummary,
    required this.generatedDate,
    required this.planType,
  });

  Map<String, dynamic> toJson() {
    return {
      'selectedMeals': selectedMeals.map((m) => m.toJson()).toList(),
      'totalCalories': totalCalories,
      'totalCost': totalCost,
      'nutrientSummary': nutrientSummary.toJson(),
      'generatedDate': generatedDate.toIso8601String(),
      'planType': planType,
    };
  }
}

class SelectedMeal {
  final String mealType;
  final String dishName;
  final int dishId;
  final int calories;
  final double cost;
  final String cuisineType;
  final bool isVegetarian;
  final String portionSize;
  final MacroNutrients macros;
  final MicroNutrients micros;
  final String selectionReason;

  SelectedMeal({
    required this.mealType,
    required this.dishName,
    required this.dishId,
    required this.calories,
    required this.cost,
    required this.cuisineType,
    required this.isVegetarian,
    required this.portionSize,
    required this.macros,
    required this.micros,
    required this.selectionReason,
  });

  Map<String, dynamic> toJson() {
    return {
      'mealType': mealType,
      'dishName': dishName,
      'dishId': dishId,
      'calories': calories,
      'cost': cost,
      'cuisineType': cuisineType,
      'isVegetarian': isVegetarian,
      'portionSize': portionSize,
      'macros': macros.toJson(),
      'micros': micros.toJson(),
      'selectionReason': selectionReason,
    };
  }
}

class MacroNutrients {
  final double carbsG;
  final double proteinG;
  final double fatG;
  final double fiberG;

  MacroNutrients({
    required this.carbsG,
    required this.proteinG,
    required this.fatG,
    required this.fiberG,
  });

  Map<String, dynamic> toJson() {
    return {
      'carbsG': carbsG,
      'proteinG': proteinG,
      'fatG': fatG,
      'fiberG': fiberG,
    };
  }
}

class MicroNutrients {
  final double ironMg;
  final double sodiumMg;

  MicroNutrients({required this.ironMg, required this.sodiumMg});

  Map<String, dynamic> toJson() {
    return {'ironMg': ironMg, 'sodiumMg': sodiumMg};
  }
}

class NutrientSummary {
  final double totalCarbsG;
  final double totalProteinG;
  final double totalFatG;
  final double totalFiberG;
  final double totalIronMg;
  final double totalSodiumMg;
  final String carbsPercentage;
  final String proteinPercentage;
  final String fatPercentage;
  final bool meetsNutrientBalance;
  final List<String> nutritionNotes;

  NutrientSummary({
    required this.totalCarbsG,
    required this.totalProteinG,
    required this.totalFatG,
    required this.totalFiberG,
    required this.totalIronMg,
    required this.totalSodiumMg,
    required this.carbsPercentage,
    required this.proteinPercentage,
    required this.fatPercentage,
    required this.meetsNutrientBalance,
    required this.nutritionNotes,
  });

  Map<String, dynamic> toJson() {
    return {
      'totalCarbsG': totalCarbsG,
      'totalProteinG': totalProteinG,
      'totalFatG': totalFatG,
      'totalFiberG': totalFiberG,
      'totalIronMg': totalIronMg,
      'totalSodiumMg': totalSodiumMg,
      'carbsPercentage': carbsPercentage,
      'proteinPercentage': proteinPercentage,
      'fatPercentage': fatPercentage,
      'meetsNutrientBalance': meetsNutrientBalance,
      'nutritionNotes': nutritionNotes,
    };
  }
}

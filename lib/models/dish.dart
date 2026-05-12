class Dish {
  final int dishId;
  final String dishName;
  final String cuisineType;
  final bool isVegetarian;
  final String mealType;
  final int caloriesPerServing;
  final double carbsG;
  final double proteinG;
  final double fatG;
  final double fiberG;
  final double ironMg;
  final double sodiumMg;
  final double estimatedCostInr;
  final String portionSize;
  final String glycemicIndexCategory;

  // Medical safety tags
  final bool suitableForDiabetes;
  final bool suitableForHypertension;
  final bool suitableForPcos;
  final bool suitableForAnemia;
  final String diabetesExplanation;
  final String hypertensionExplanation;
  final String pcosExplanation;
  final String anemiaExplanation;

  // Recipe information
  final List<RecipeIngredient> ingredients;
  final List<CookingInstruction> instructions;
  final int prepTimeMinutes;
  final int cookTimeMinutes;
  final String healthNotes;
  final String portionGuidance;
  final String chefTips;

  Dish({
    required this.dishId,
    required this.dishName,
    required this.cuisineType,
    required this.isVegetarian,
    required this.mealType,
    required this.caloriesPerServing,
    required this.carbsG,
    required this.proteinG,
    required this.fatG,
    required this.fiberG,
    required this.ironMg,
    required this.sodiumMg,
    required this.estimatedCostInr,
    required this.portionSize,
    required this.glycemicIndexCategory,
    required this.suitableForDiabetes,
    required this.suitableForHypertension,
    required this.suitableForPcos,
    required this.suitableForAnemia,
    required this.diabetesExplanation,
    required this.hypertensionExplanation,
    required this.pcosExplanation,
    required this.anemiaExplanation,
    required this.ingredients,
    required this.instructions,
    required this.prepTimeMinutes,
    required this.cookTimeMinutes,
    required this.healthNotes,
    required this.portionGuidance,
    required this.chefTips,
  });
}

class RecipeIngredient {
  final String ingredientName;
  final double quantity;
  final String unit;
  final String category;
  final String preparationNote;

  RecipeIngredient({
    required this.ingredientName,
    required this.quantity,
    required this.unit,
    required this.category,
    required this.preparationNote,
  });
}

class CookingInstruction {
  final int stepNumber;
  final String instruction;
  final String timingNote;
  final String temperature;
  final String visualCue;

  CookingInstruction({
    required this.stepNumber,
    required this.instruction,
    required this.timingNote,
    required this.temperature,
    required this.visualCue,
  });
}

import '../models/meal_plan_output.dart';
import './daily_meal_plan_generator.dart';
import './nutrient_balancing_service.dart';
import './budget_aware_meal_service.dart';

/// Main orchestrator service for meal planning backend logic
class MealPlanningService {
  /// Generate complete daily meal plan with all features
  ///
  /// Parameters:
  /// - healthConditions: List of health conditions (diabetes, hypertension, pcos, anemia)
  /// - dietaryPreference: 'veg' or 'non-veg'
  /// - cuisinePreference: 'south indian' or 'north indian'
  /// - dailyCalorieTarget: Target calories per day
  /// - monthlyBudget: Monthly food budget in INR
  /// - includeSnacks: Whether to include snacks in the plan
  ///
  /// Returns: MealPlanOutput with selected meals, calories, cost, and nutrient summary
  static MealPlanOutput generateMealPlan({
    required List<String> healthConditions,
    required String dietaryPreference,
    required String cuisinePreference,
    required int dailyCalorieTarget,
    required double monthlyBudget,
    bool includeSnacks = false,
  }) {
    // Calculate daily budget
    double dailyBudget = monthlyBudget / 30;

    // Step 1: Generate initial meal plan
    MealPlanOutput initialPlan = DailyMealPlanGenerator.generateDailyMealPlan(
      healthConditions: healthConditions,
      dietaryPreference: dietaryPreference,
      cuisinePreference: cuisinePreference,
      dailyCalorieTarget: dailyCalorieTarget,
      monthlyBudget: monthlyBudget,
      includeSnacks: includeSnacks,
    );

    // Step 2: Apply budget-aware logic (replaces expensive meals, adjusts portions)
    MealPlanOutput budgetOptimizedPlan =
        BudgetAwareMealService.applyBudgetAwareLogic(
          originalPlan: initialPlan,
          dailyBudget: dailyBudget,
          healthConditions: healthConditions,
          dietaryPreference: dietaryPreference,
          cuisinePreference: cuisinePreference,
          dailyCalorieTarget: dailyCalorieTarget,
        );

    // Step 3: Balance nutrients and add recommendations
    MealPlanOutput balancedPlan =
        NutrientBalancingService.balanceDailyNutrients(
          budgetOptimizedPlan,
          healthConditions,
        );

    // Step 4: Validate nutritional adequacy
    ValidationResult validation =
        NutrientBalancingService.validateNutritionalAdequacy(
          balancedPlan,
          healthConditions,
        );

    // Step 5: Add validation notes to the plan
    List<String> finalNotes = List.from(
      balancedPlan.nutrientSummary.nutritionNotes,
    );

    if (!validation.isValid) {
      finalNotes.add('⚠️ CRITICAL ISSUES:');
      finalNotes.addAll(validation.issues);
    }

    if (validation.warnings.isNotEmpty) {
      finalNotes.add('⚡ RECOMMENDATIONS:');
      finalNotes.addAll(validation.warnings);
    }

    // Add budget status note
    if (balancedPlan.totalCost <= dailyBudget) {
      finalNotes.add(
        '✓ Within daily budget: ₹${balancedPlan.totalCost.toStringAsFixed(2)} / ₹${dailyBudget.toStringAsFixed(2)}',
      );
    } else {
      finalNotes.add(
        '⚠ Slightly over budget: ₹${balancedPlan.totalCost.toStringAsFixed(2)} / ₹${dailyBudget.toStringAsFixed(2)}',
      );
    }

    // Create final plan with all notes
    NutrientSummary finalSummary = NutrientSummary(
      totalCarbsG: balancedPlan.nutrientSummary.totalCarbsG,
      totalProteinG: balancedPlan.nutrientSummary.totalProteinG,
      totalFatG: balancedPlan.nutrientSummary.totalFatG,
      totalFiberG: balancedPlan.nutrientSummary.totalFiberG,
      totalIronMg: balancedPlan.nutrientSummary.totalIronMg,
      totalSodiumMg: balancedPlan.nutrientSummary.totalSodiumMg,
      carbsPercentage: balancedPlan.nutrientSummary.carbsPercentage,
      proteinPercentage: balancedPlan.nutrientSummary.proteinPercentage,
      fatPercentage: balancedPlan.nutrientSummary.fatPercentage,
      meetsNutrientBalance: balancedPlan.nutrientSummary.meetsNutrientBalance,
      nutritionNotes: finalNotes,
    );

    return MealPlanOutput(
      selectedMeals: balancedPlan.selectedMeals,
      totalCalories: balancedPlan.totalCalories,
      totalCost: balancedPlan.totalCost,
      nutrientSummary: finalSummary,
      generatedDate: balancedPlan.generatedDate,
      planType: 'Complete Budget-Aware Daily Meal Plan',
    );
  }

  /// Generate meal plan and return as formatted JSON
  static Map<String, dynamic> generateMealPlanJson({
    required List<String> healthConditions,
    required String dietaryPreference,
    required String cuisinePreference,
    required int dailyCalorieTarget,
    required double monthlyBudget,
    bool includeSnacks = false,
  }) {
    MealPlanOutput plan = generateMealPlan(
      healthConditions: healthConditions,
      dietaryPreference: dietaryPreference,
      cuisinePreference: cuisinePreference,
      dailyCalorieTarget: dailyCalorieTarget,
      monthlyBudget: monthlyBudget,
      includeSnacks: includeSnacks,
    );

    return plan.toJson();
  }

  /// Generate meal plan with detailed output string
  static String generateMealPlanReport({
    required List<String> healthConditions,
    required String dietaryPreference,
    required String cuisinePreference,
    required int dailyCalorieTarget,
    required double monthlyBudget,
    bool includeSnacks = false,
  }) {
    MealPlanOutput plan = generateMealPlan(
      healthConditions: healthConditions,
      dietaryPreference: dietaryPreference,
      cuisinePreference: cuisinePreference,
      dailyCalorieTarget: dailyCalorieTarget,
      monthlyBudget: monthlyBudget,
      includeSnacks: includeSnacks,
    );

    StringBuffer report = StringBuffer();

    report.writeln('═══════════════════════════════════════════════════════');
    report.writeln('           NUTRICART DAILY MEAL PLAN');
    report.writeln('═══════════════════════════════════════════════════════');
    report.writeln();
    report.writeln('Generated: ${plan.generatedDate.toString().split('.')[0]}');
    report.writeln('Health Conditions: ${healthConditions.join(", ")}');
    report.writeln('Dietary Preference: $dietaryPreference');
    report.writeln('Cuisine Preference: $cuisinePreference');
    report.writeln('Daily Calorie Target: $dailyCalorieTarget kcal');
    report.writeln('Monthly Budget: ₹${monthlyBudget.toStringAsFixed(2)}');
    report.writeln();
    report.writeln('───────────────────────────────────────────────────────');
    report.writeln('                  SELECTED MEALS');
    report.writeln('───────────────────────────────────────────────────────');
    report.writeln();

    for (var meal in plan.selectedMeals) {
      report.writeln('🍽️  ${meal.mealType.toUpperCase()}');
      report.writeln('   Dish: ${meal.dishName}');
      report.writeln('   Cuisine: ${meal.cuisineType}');
      report.writeln(
        '   Type: ${meal.isVegetarian ? "Vegetarian" : "Non-Vegetarian"}',
      );
      report.writeln('   Calories: ${meal.calories} kcal');
      report.writeln('   Cost: ₹${meal.cost.toStringAsFixed(2)}');
      report.writeln('   Portion: ${meal.portionSize}');
      report.writeln(
        '   Macros: Carbs ${meal.macros.carbsG}g | Protein ${meal.macros.proteinG}g | Fat ${meal.macros.fatG}g | Fiber ${meal.macros.fiberG}g',
      );
      report.writeln(
        '   Micros: Iron ${meal.micros.ironMg}mg | Sodium ${meal.micros.sodiumMg}mg',
      );
      report.writeln();
    }

    report.writeln('───────────────────────────────────────────────────────');
    report.writeln('                  DAILY TOTALS');
    report.writeln('───────────────────────────────────────────────────────');
    report.writeln();
    report.writeln('Total Calories: ${plan.totalCalories} kcal');
    report.writeln('Total Cost: ₹${plan.totalCost.toStringAsFixed(2)}');
    report.writeln('Daily Budget: ₹${(monthlyBudget / 30).toStringAsFixed(2)}');
    report.writeln(
      'Budget Status: ${plan.totalCost <= (monthlyBudget / 30) ? "✓ Within Budget" : "⚠ Over Budget"}',
    );
    report.writeln();
    report.writeln('───────────────────────────────────────────────────────');
    report.writeln('                NUTRIENT SUMMARY');
    report.writeln('───────────────────────────────────────────────────────');
    report.writeln();
    report.writeln('Macronutrients:');
    report.writeln(
      '  • Carbohydrates: ${plan.nutrientSummary.totalCarbsG.toStringAsFixed(1)}g (${plan.nutrientSummary.carbsPercentage})',
    );
    report.writeln(
      '  • Protein: ${plan.nutrientSummary.totalProteinG.toStringAsFixed(1)}g (${plan.nutrientSummary.proteinPercentage})',
    );
    report.writeln(
      '  • Fat: ${plan.nutrientSummary.totalFatG.toStringAsFixed(1)}g (${plan.nutrientSummary.fatPercentage})',
    );
    report.writeln(
      '  • Fiber: ${plan.nutrientSummary.totalFiberG.toStringAsFixed(1)}g',
    );
    report.writeln();
    report.writeln('Micronutrients:');
    report.writeln(
      '  • Iron: ${plan.nutrientSummary.totalIronMg.toStringAsFixed(1)}mg',
    );
    report.writeln(
      '  • Sodium: ${plan.nutrientSummary.totalSodiumMg.toStringAsFixed(1)}mg',
    );
    report.writeln();
    report.writeln(
      'Nutrient Balance: ${plan.nutrientSummary.meetsNutrientBalance ? "✓ Balanced" : "⚠ Needs Adjustment"}',
    );
    report.writeln();

    if (plan.nutrientSummary.nutritionNotes.isNotEmpty) {
      report.writeln('───────────────────────────────────────────────────────');
      report.writeln('              NUTRITION INSIGHTS');
      report.writeln('───────────────────────────────────────────────────────');
      report.writeln();
      for (var note in plan.nutrientSummary.nutritionNotes) {
        report.writeln('• $note');
      }
      report.writeln();
    }

    report.writeln('═══════════════════════════════════════════════════════');

    return report.toString();
  }

  /// Calculate optimal macro targets for given conditions
  static MacroTargets getOptimalMacroTargets(
    int dailyCalories,
    List<String> healthConditions,
  ) {
    return NutrientBalancingService.calculateOptimalTargets(
      dailyCalories,
      healthConditions,
    );
  }
}

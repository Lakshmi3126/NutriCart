import '../models/meal_plan_output.dart';

class NutrientBalancingService {
  /// Balance nutrients across daily meal plan
  static MealPlanOutput balanceDailyNutrients(
    MealPlanOutput initialPlan,
    List<String> healthConditions,
  ) {
    // Check if rebalancing is needed
    if (initialPlan.nutrientSummary.meetsNutrientBalance) {
      return initialPlan;
    }

    // Analyze current nutrient distribution
    NutrientAnalysis analysis = _analyzeNutrients(initialPlan);

    // Generate rebalancing recommendations
    List<String> updatedNotes = List.from(
      initialPlan.nutrientSummary.nutritionNotes,
    );
    updatedNotes.addAll(
      _generateRebalancingRecommendations(analysis, healthConditions),
    );

    // Create updated nutrient summary with recommendations
    NutrientSummary updatedSummary = NutrientSummary(
      totalCarbsG: initialPlan.nutrientSummary.totalCarbsG,
      totalProteinG: initialPlan.nutrientSummary.totalProteinG,
      totalFatG: initialPlan.nutrientSummary.totalFatG,
      totalFiberG: initialPlan.nutrientSummary.totalFiberG,
      totalIronMg: initialPlan.nutrientSummary.totalIronMg,
      totalSodiumMg: initialPlan.nutrientSummary.totalSodiumMg,
      carbsPercentage: initialPlan.nutrientSummary.carbsPercentage,
      proteinPercentage: initialPlan.nutrientSummary.proteinPercentage,
      fatPercentage: initialPlan.nutrientSummary.fatPercentage,
      meetsNutrientBalance: _checkBalanceWithTolerance(analysis),
      nutritionNotes: updatedNotes,
    );

    return MealPlanOutput(
      selectedMeals: initialPlan.selectedMeals,
      totalCalories: initialPlan.totalCalories,
      totalCost: initialPlan.totalCost,
      nutrientSummary: updatedSummary,
      generatedDate: initialPlan.generatedDate,
      planType: initialPlan.planType,
    );
  }

  /// Analyze nutrient distribution
  static NutrientAnalysis _analyzeNutrients(MealPlanOutput plan) {
    double totalCarbs = plan.nutrientSummary.totalCarbsG;
    double totalProtein = plan.nutrientSummary.totalProteinG;
    double totalFat = plan.nutrientSummary.totalFatG;

    double carbCalories = totalCarbs * 4;
    double proteinCalories = totalProtein * 4;
    double fatCalories = totalFat * 9;
    double totalMacroCalories = carbCalories + proteinCalories + fatCalories;

    double carbPercent = totalMacroCalories > 0
        ? (carbCalories / totalMacroCalories) * 100
        : 0;
    double proteinPercent = totalMacroCalories > 0
        ? (proteinCalories / totalMacroCalories) * 100
        : 0;
    double fatPercent = totalMacroCalories > 0
        ? (fatCalories / totalMacroCalories) * 100
        : 0;

    return NutrientAnalysis(
      carbPercent: carbPercent,
      proteinPercent: proteinPercent,
      fatPercent: fatPercent,
      totalFiber: plan.nutrientSummary.totalFiberG,
      totalIron: plan.nutrientSummary.totalIronMg,
      totalSodium: plan.nutrientSummary.totalSodiumMg,
      carbsDeficit: _calculateDeficit(carbPercent, 45, 65),
      proteinDeficit: _calculateDeficit(proteinPercent, 10, 35),
      fatDeficit: _calculateDeficit(fatPercent, 20, 35),
    );
  }

  /// Calculate deficit or excess from target range
  static double _calculateDeficit(
    double actual,
    double minTarget,
    double maxTarget,
  ) {
    if (actual < minTarget) {
      return minTarget - actual; // Positive = deficit
    } else if (actual > maxTarget) {
      return maxTarget - actual; // Negative = excess
    }
    return 0; // Within range
  }

  /// Check balance with tolerance
  static bool _checkBalanceWithTolerance(NutrientAnalysis analysis) {
    // Allow 5% tolerance outside ideal ranges
    bool carbsOk = analysis.carbPercent >= 40 && analysis.carbPercent <= 70;
    bool proteinOk =
        analysis.proteinPercent >= 8 && analysis.proteinPercent <= 40;
    bool fatOk = analysis.fatPercent >= 15 && analysis.fatPercent <= 40;

    return carbsOk && proteinOk && fatOk;
  }

  /// Generate rebalancing recommendations
  static List<String> _generateRebalancingRecommendations(
    NutrientAnalysis analysis,
    List<String> healthConditions,
  ) {
    List<String> recommendations = [];

    // Carbohydrate recommendations
    if (analysis.carbsDeficit > 5) {
      recommendations.add(
        'Add complex carbohydrates like whole grains or fruits',
      );
    } else if (analysis.carbsDeficit < -5) {
      recommendations.add(
        'Reduce refined carbohydrates, increase protein and vegetables',
      );
    }

    // Protein recommendations
    if (analysis.proteinDeficit > 5) {
      recommendations.add(
        'Increase protein intake with lentils, paneer, or lean meats',
      );
    } else if (analysis.proteinDeficit < -5) {
      recommendations.add('Protein intake is high - ensure adequate hydration');
    }

    // Fat recommendations
    if (analysis.fatDeficit > 5) {
      recommendations.add(
        'Add healthy fats like nuts, seeds, or ghee in moderation',
      );
    } else if (analysis.fatDeficit < -5) {
      recommendations.add(
        'Reduce oil and butter usage, choose lean cooking methods',
      );
    }

    // Fiber recommendations
    if (analysis.totalFiber < 20) {
      recommendations.add(
        'Increase fiber with vegetables, whole grains, and lentils',
      );
    }

    // Sodium recommendations for hypertension
    if (healthConditions.contains('hypertension') ||
        healthConditions.contains('Hypertension')) {
      if (analysis.totalSodium > 1500) {
        recommendations.add(
          'Reduce salt and pickles, use herbs and spices for flavor',
        );
      }
    }

    // Iron recommendations for anemia
    if (healthConditions.contains('anemia') ||
        healthConditions.contains('Anemia')) {
      if (analysis.totalIron < 10) {
        recommendations.add(
          'Include iron-rich foods like spinach, lentils, and lean meats',
        );
      }
    }

    return recommendations;
  }

  /// Calculate optimal macronutrient targets based on health conditions
  static MacroTargets calculateOptimalTargets(
    int dailyCalories,
    List<String> healthConditions,
  ) {
    // Default healthy ranges
    double carbMin = 45.0;
    double carbMax = 65.0;
    double proteinMin = 10.0;
    double proteinMax = 35.0;
    double fatMin = 20.0;
    double fatMax = 35.0;

    // Adjust for diabetes
    if (healthConditions.contains('diabetes') ||
        healthConditions.contains('Diabetes')) {
      carbMin = 40.0;
      carbMax = 50.0;
      proteinMin = 20.0;
      proteinMax = 30.0;
    }

    // Adjust for PCOS
    if (healthConditions.contains('pcos') ||
        healthConditions.contains('PCOS')) {
      carbMin = 35.0;
      carbMax = 45.0;
      proteinMin = 25.0;
      proteinMax = 35.0;
    }

    // Calculate gram targets
    double carbCaloriesMin = dailyCalories * (carbMin / 100);
    double carbCaloriesMax = dailyCalories * (carbMax / 100);
    double proteinCaloriesMin = dailyCalories * (proteinMin / 100);
    double proteinCaloriesMax = dailyCalories * (proteinMax / 100);
    double fatCaloriesMin = dailyCalories * (fatMin / 100);
    double fatCaloriesMax = dailyCalories * (fatMax / 100);

    return MacroTargets(
      carbsGMin: carbCaloriesMin / 4,
      carbsGMax: carbCaloriesMax / 4,
      proteinGMin: proteinCaloriesMin / 4,
      proteinGMax: proteinCaloriesMax / 4,
      fatGMin: fatCaloriesMin / 9,
      fatGMax: fatCaloriesMax / 9,
    );
  }

  /// Validate meal plan meets minimum nutritional requirements
  static ValidationResult validateNutritionalAdequacy(
    MealPlanOutput plan,
    List<String> healthConditions,
  ) {
    List<String> issues = [];
    List<String> warnings = [];

    // Check minimum protein (at least 0.8g per kg body weight, assume 60kg)
    if (plan.nutrientSummary.totalProteinG < 48) {
      issues.add('Protein intake below minimum requirement (48g)');
    } else if (plan.nutrientSummary.totalProteinG < 60) {
      warnings.add('Protein intake is on the lower side');
    }

    // Check minimum fiber
    if (plan.nutrientSummary.totalFiberG < 15) {
      issues.add('Fiber intake below minimum requirement (15g)');
    } else if (plan.nutrientSummary.totalFiberG < 20) {
      warnings.add('Fiber intake could be improved');
    }

    // Check sodium for hypertension
    if (healthConditions.contains('hypertension') ||
        healthConditions.contains('Hypertension')) {
      if (plan.nutrientSummary.totalSodiumMg > 2000) {
        issues.add('Sodium intake too high for hypertension (>2000mg)');
      } else if (plan.nutrientSummary.totalSodiumMg > 1500) {
        warnings.add('Sodium intake approaching upper limit for hypertension');
      }
    }

    // Check iron for anemia
    if (healthConditions.contains('anemia') ||
        healthConditions.contains('Anemia')) {
      if (plan.nutrientSummary.totalIronMg < 8) {
        warnings.add(
          'Iron intake below recommended level for anemia management',
        );
      }
    }

    // Check calorie adequacy (minimum 1200 for women, 1500 for men)
    if (plan.totalCalories < 1200) {
      issues.add('Total calorie intake too low for healthy metabolism');
    }

    bool isValid = issues.isEmpty;

    return ValidationResult(
      isValid: isValid,
      issues: issues,
      warnings: warnings,
    );
  }
}

class NutrientAnalysis {
  final double carbPercent;
  final double proteinPercent;
  final double fatPercent;
  final double totalFiber;
  final double totalIron;
  final double totalSodium;
  final double carbsDeficit;
  final double proteinDeficit;
  final double fatDeficit;

  NutrientAnalysis({
    required this.carbPercent,
    required this.proteinPercent,
    required this.fatPercent,
    required this.totalFiber,
    required this.totalIron,
    required this.totalSodium,
    required this.carbsDeficit,
    required this.proteinDeficit,
    required this.fatDeficit,
  });
}

class MacroTargets {
  final double carbsGMin;
  final double carbsGMax;
  final double proteinGMin;
  final double proteinGMax;
  final double fatGMin;
  final double fatGMax;

  MacroTargets({
    required this.carbsGMin,
    required this.carbsGMax,
    required this.proteinGMin,
    required this.proteinGMax,
    required this.fatGMin,
    required this.fatGMax,
  });
}

class ValidationResult {
  final bool isValid;
  final List<String> issues;
  final List<String> warnings;

  ValidationResult({
    required this.isValid,
    required this.issues,
    required this.warnings,
  });
}

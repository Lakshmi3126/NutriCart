// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'NutriCart';

  @override
  String dashboardGreeting(String userName) {
    return 'Hello, $userName 👋';
  }

  @override
  String get dashboardHighlightTitle => 'Great Progress Today!';

  @override
  String get dashboardHighlightSubtitle => 'Meals adjusted to fit your budget';

  @override
  String get dashboardQuickActionsTitle => 'Quick Actions';

  @override
  String get dashboardQuickActionMealPlanTitle => 'Meal Plan';

  @override
  String get dashboardQuickActionMealPlanSubtitle => 'View today\'s meals';

  @override
  String get dashboardQuickActionGroceryTitle => 'Grocery';

  @override
  String get dashboardQuickActionGrocerySubtitle => 'Shopping list';

  @override
  String get dashboardQuickActionBudgetTitle => 'Budget Tracker';

  @override
  String get dashboardQuickActionBudgetSubtitle => 'Monitor your spending';

  @override
  String get dashboardQuickActionPantryTitle => 'Pantry Management';

  @override
  String get dashboardQuickActionPantrySubtitle => 'Track your ingredients';

  @override
  String get dashboardQuickActionReengineeringTitle => 'Meal Re-engineering';

  @override
  String get dashboardQuickActionReengineeringSubtitle =>
      'View intelligent meal updates';

  @override
  String get dashboardQuickActionInsightsTitle => 'Health Insights';

  @override
  String get dashboardQuickActionInsightsSubtitle =>
      'Track your health progress';

  @override
  String get dashboardWhyTheseMealsTitle => 'Why These Meals?';

  @override
  String get dashboardPantryAlertsTitle => 'Pantry Alerts';

  @override
  String get dashboardOverviewTitle => 'Today\'s Overview';

  @override
  String get timeAM => 'AM';

  @override
  String get timePM => 'PM';

  @override
  String get seasonalSectionTitle => 'Seasonal Picks Near You 🌾';

  @override
  String get seasonalSectionSubtitle =>
      'Based on Bangalore markets in February';

  @override
  String get seasonalButtonAddToGrocery => 'Add to Grocery List';

  @override
  String get seasonalSnackAddedToGrocery => 'Added to grocery list';

  @override
  String get groceryTitle => 'Grocery List';

  @override
  String get grocerySearchHint => 'Search ingredients...';

  @override
  String get groceryEmptyTitle => 'No Items Found';

  @override
  String get groceryEmptyMessageDefault =>
      'Your grocery list is empty. Add items from meal plans.';

  @override
  String get groceryEmptyMessageFiltered => 'No ingredients match your search.';

  @override
  String get groceryEmptyPrimary => 'Browse Meals';

  @override
  String get groceryEmptyClearSearch => 'Clear Search';

  @override
  String get groceryFabAddItem => 'Add Item';

  @override
  String get grocerySnackAddedToPantry => 'Added to pantry';

  @override
  String get grocerySnackRemovedFromList => 'Removed from list';

  @override
  String get grocerySnackOpeningWhatsApp => 'Opening WhatsApp...';

  @override
  String get grocerySnackOpeningSms => 'Opening SMS...';

  @override
  String get grocerySnackCopiedList => 'List copied to clipboard';

  @override
  String get groceryShareTitle => 'Share Grocery List';

  @override
  String get groceryShoppingProgressTitle => 'Shopping Progress';

  @override
  String groceryShoppingProgressLabel(int purchased, int total) {
    return '$purchased/$total items';
  }

  @override
  String get deliverySectionTitle => 'Delivery Integration';

  @override
  String get deliverySectionSubtitle =>
      'Quick delivery options based on your cart';

  @override
  String get deliveryBigBasketTitle => 'BigBasket';

  @override
  String get deliveryBigBasketSubtitle => 'Full range of groceries';

  @override
  String get deliveryBigBasketFee => 'Fee: ₹30 (Free above ₹500)';

  @override
  String get deliveryBigBasketEta => 'ETA: 4-6 hours';

  @override
  String get deliveryBlinkitTitle => 'Blinkit';

  @override
  String get deliveryBlinkitSubtitle => 'Instant delivery';

  @override
  String get deliveryBlinkitFee => 'Fee: ₹25 (Free above ₹199)';

  @override
  String get deliveryBlinkitEta => 'ETA: 15-20 mins';

  @override
  String get deliveryDMartTitle => 'DMart Ready';

  @override
  String get deliveryDMartSubtitle => 'Value shopping';

  @override
  String get deliveryDMartFee => 'Pickup: Free | Delivery: ₹49';

  @override
  String get deliveryDMartEta => 'ETA: Next Day';

  @override
  String get deliveryAvailableForCart => 'Available for your cart size';

  @override
  String get deliveryMinOrderNotMet => 'Minimum order amount not met';

  @override
  String get deliveryUnavailable => 'Currently unavailable in your area';

  @override
  String deliverySelectedLabel(String provider) {
    return 'Selected Delivery: $provider';
  }

  @override
  String get deliveryChipSelected => 'Selected';

  @override
  String get deliveryChipSelect => 'Select';

  @override
  String get profileSetupTitle => 'Profile Setup';

  @override
  String profileStepOfTotal(int current, int total) {
    return 'Step $current of $total';
  }

  @override
  String profileStepPercent(int percent) {
    return '$percent%';
  }

  @override
  String get profileContinue => 'Continue';

  @override
  String get profileCompleteSetup => 'Complete Setup';

  @override
  String get languageSelectorTitle => 'App Language';

  @override
  String get languageSelectorSubtitle =>
      'Choose the language for your NutriCart experience';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageKannada => 'ಕನ್ನಡ';

  @override
  String get languageHindi => 'हिन्दी';

  @override
  String dashboardMealCompletedCount(int completed, int total) {
    return '$completed of $total meals';
  }

  @override
  String get dashboardCalorieConsumed => 'Consumed';

  @override
  String get dashboardCalorieRemaining => 'Remaining';

  @override
  String dashboardCalorieValue(int value) {
    return '$value kcal';
  }

  @override
  String get dashboardUrgencyHigh => 'High';

  @override
  String get dashboardUrgencyMedium => 'Medium';

  @override
  String get dashboardUrgencyLow => 'Low';

  @override
  String get dashboardWeeklyProgressTitle => 'Weekly Progress';

  @override
  String get dashboardWeeklyProgressSubtitle => 'Nutrition adherence tracking';

  @override
  String get dashboardWeeklyProgressSemantics =>
      'Weekly nutrition adherence bar chart showing daily compliance percentages';

  @override
  String get dashboardLegendExcellent => 'Excellent';

  @override
  String get dashboardLegendGood => 'Good';

  @override
  String get dashboardLegendNeedsImprovement => 'Needs Improvement';

  @override
  String get dashboardLoading => 'Loading...';

  @override
  String get dashboardOffline => 'Offline';

  @override
  String get groceryCategoryVegetables => 'Vegetables';

  @override
  String get groceryCategoryGrains => 'Grains';

  @override
  String get groceryCategorySpices => 'Spices';

  @override
  String get groceryCategoryDairy => 'Dairy';

  @override
  String get groceryBudgetSummaryTitle => 'Budget Summary';

  @override
  String get groceryWeeklyEstimate => 'Weekly Estimate';

  @override
  String get groceryMonthlyBudget => 'Monthly Budget';

  @override
  String get grocerySpent => 'Spent';

  @override
  String get groceryRemaining => 'Remaining';

  @override
  String get groceryCurrency => '₹';

  @override
  String get groceryBudgetFriendlyTitle => 'Budget-Friendly Alternatives';

  @override
  String groceryBudgetExceedsMessage(String amount) {
    return 'Your current list exceeds budget by $amount. Consider these alternatives:';
  }

  @override
  String grocerySaveAmount(String amount) {
    return 'Save $amount';
  }

  @override
  String groceryTotal(String amount) {
    return 'Total: $amount';
  }

  @override
  String groceryShareGeneratedBy(String appName, String date) {
    return 'Generated by $appName on $date';
  }

  @override
  String get profilePersonalDetails => 'Personal Details';

  @override
  String get profileHealthConditions => 'Health Conditions';

  @override
  String get profileDietaryPreferences => 'Dietary Preferences';

  @override
  String get profileAllergies => 'Allergies';

  @override
  String get profileBudget => 'Budget';

  @override
  String get profileBudgetTitle => 'Monthly Food Budget';

  @override
  String get profileAge => 'Age';

  @override
  String get profileWeight => 'Weight';

  @override
  String get profileGender => 'Gender';

  @override
  String get profileGenderMale => 'Male';

  @override
  String get profileGenderFemale => 'Female';

  @override
  String get profileHealthDiabetes => 'Diabetes';

  @override
  String get profileHealthPCOS => 'PCOS';

  @override
  String get profileHealthHypertension => 'Hypertension';

  @override
  String get profileHbA1c => 'HbA1c Level';

  @override
  String get profileDietVegetarian => 'Vegetarian';

  @override
  String get profileDietVegan => 'Vegan';

  @override
  String get profileMonthlyBudgetLabel => 'Enter Monthly Budget';

  @override
  String profileUnitKg(double value) {
    return '$value kg';
  }

  @override
  String profileUnitYears(int value) {
    return '$value years';
  }

  @override
  String get dashboardModalMarkComplete => 'Mark Complete';

  @override
  String get dashboardModalSkipMeal => 'Skip Meal';

  @override
  String get dashboardModalRequestAlternative => 'Request Alternative';

  @override
  String profileUnitDays(int value) {
    return '$value days';
  }

  @override
  String get groceryBudgetOverview => 'Budget Overview';

  @override
  String groceryUsedPercent(int percent) {
    return '$percent% Used';
  }

  @override
  String get groceryAvgDay => 'Avg/Day';

  @override
  String get groceryDaysLeftLabel => 'Days Left';

  @override
  String get mockRecentMeal1Name => 'Brown Rice with Dal Tadka';

  @override
  String get mockRecentMeal1Explanation =>
      'High in protein and fiber, helps manage blood sugar levels. Dal provides essential amino acids for PCOS management.';

  @override
  String get mockRecentMeal1Timestamp => '2 hours ago';

  @override
  String get mockRecentMeal2Name => 'Oats Upma';

  @override
  String get mockRecentMeal2Explanation =>
      'Low glycemic index breakfast keeps you full longer and prevents sugar spikes. Rich in beta-glucan for heart health.';

  @override
  String get mockRecentMeal2Timestamp => '5 hours ago';

  @override
  String get mockSeasonalPick1Name => 'Winter Citrus';

  @override
  String get mockSeasonalPick1Type => 'Fruit';

  @override
  String get mockSeasonalPick1Tag => 'Winter citrus';

  @override
  String get mockSeasonalPick1Descriptor => 'Seasonal in Feb around Bangalore';

  @override
  String get mockSeasonalPick2Name => 'Fresh Spinach';

  @override
  String get mockSeasonalPick2Type => 'Vegetable';

  @override
  String get mockSeasonalPick2Tag => 'Winter leafy green';

  @override
  String get mockSeasonalPick2Descriptor => 'Tender bunches in Feb';

  @override
  String get seasonalFruit => 'Fruit';

  @override
  String get seasonalVegetable => 'Vegetable';

  @override
  String get seasonalTagPeakSeason => 'Peak season';

  @override
  String get seasonalDescriptorPeakFeb => 'Peak availability in late Feb';

  @override
  String get seasonalTagLocallyAbundant => 'Locally abundant';

  @override
  String get seasonalDescriptorCityMarkets => 'Steady supply in city markets';

  @override
  String get groceryWeeklyBudget => 'Weekly Budget';

  @override
  String get groceryOverBudget => 'Over Budget';

  @override
  String get groceryEstimated => 'estimated';

  @override
  String get grocerySaveMore => 'Save More';

  @override
  String groceryPurchasedStatus(int count, int total) {
    return '$count/$total purchased';
  }

  @override
  String get groceryEditQuantity => 'Edit Quantity';

  @override
  String get groceryFindAlternatives => 'Find Alternatives';

  @override
  String get groceryAddNotes => 'Add Notes';

  @override
  String get groceryPantry => 'Pantry';

  @override
  String get groceryRemove => 'Remove';

  @override
  String groceryAlternativesTitle(String name) {
    return 'Alternatives for $name';
  }

  @override
  String get groceryNoAlternatives => 'No alternatives available';

  @override
  String grocerySwitchedTo(String name) {
    return 'Switched to $name';
  }

  @override
  String get groceryClose => 'Close';

  @override
  String get groceryCategoryProduce => 'Produce';

  @override
  String get groceryCategoryMeat => 'Meat';

  @override
  String get groceryCategoryBakery => 'Bakery';

  @override
  String get groceryCategoryFrozen => 'Frozen';

  @override
  String get groceryCategoryBeverages => 'Beverages';

  @override
  String get mockGroceryOnions => 'Onions';

  @override
  String get mockGroceryTomatoes => 'Tomatoes';

  @override
  String get mockGroceryBasmatiRice => 'Basmati Rice';

  @override
  String get mockGroceryWholeWheatFlour => 'Whole Wheat Flour';

  @override
  String get mockGroceryTurmericPowder => 'Turmeric Powder';

  @override
  String get mockGroceryCuminSeeds => 'Cumin Seeds';

  @override
  String get mockGroceryGaramMasala => 'Garam Masala';

  @override
  String get mockGroceryMilk => 'Milk';

  @override
  String get mockGroceryYogurt => 'Yogurt';

  @override
  String get mockGroceryPaneer => 'Paneer';

  @override
  String get profilePersonalSubtitle =>
      'Help us personalize your meal plans with basic information';

  @override
  String get profileAgeLabel => 'Age *';

  @override
  String get profileAgeHint => 'Enter your age';

  @override
  String get profileAgeRequired => 'Age is required';

  @override
  String get profileAgeInvalid => 'Please enter a valid age (18-100)';

  @override
  String get profileGenderLabel => 'Gender *';

  @override
  String get profileGenderOther => 'Other';

  @override
  String get profileWeightLabel => 'Weight (kg) *';

  @override
  String get profileWeightHint => 'Enter your weight';

  @override
  String get profileWeightRequired => 'Weight is required';

  @override
  String get profileWeightInvalid => 'Please enter a valid weight (30-200 kg)';

  @override
  String get profileWhyNeedInfo => 'Why do we need this information?';

  @override
  String get profileUsageTitle => 'Personal Information Usage';

  @override
  String get profileUsageAge =>
      'Age helps us calculate your daily caloric needs and nutritional requirements';

  @override
  String get profileUsageGender =>
      'Gender influences metabolic rate and specific nutrient needs';

  @override
  String get profileUsageWeight =>
      'Weight is essential for portion control and personalized meal planning';

  @override
  String get profileUsageSecurity =>
      'All data is encrypted and used only for your meal recommendations';

  @override
  String get profileHealthSubtitle =>
      'Select any health conditions you manage (optional)';

  @override
  String get profileHealthDiabetesDesc => 'Type 1 or Type 2 Diabetes';

  @override
  String get profileHealthPCOSDesc => 'Polycystic Ovary Syndrome';

  @override
  String get profileHealthHypertensionDesc => 'High Blood Pressure';

  @override
  String get profileHealthAnemia => 'Anemia';

  @override
  String get profileHealthAnemiaDesc => 'Iron Deficiency';

  @override
  String get profileHealthThyroid => 'Thyroid';

  @override
  String get profileHealthThyroidDesc => 'Thyroid Disorders';

  @override
  String get profileHealthHeart => 'Heart Disease';

  @override
  String get profileHealthHeartDesc => 'Cardiovascular Conditions';

  @override
  String get profileHbA1cLabel => 'HbA1c Level (Optional)';

  @override
  String get profileHbA1cHint => 'Enter your HbA1c level (e.g., 6.5)';

  @override
  String get profileHbA1cInfo =>
      'This helps us provide more accurate meal recommendations for diabetes management';

  @override
  String get profileSafetyTitle => 'Medical Nutrition Safety';

  @override
  String get profileSafetyCondition =>
      'Health conditions affect your nutritional requirements and food restrictions';

  @override
  String get profileSafetyCompliance =>
      'We ensure meal plans comply with medical nutrition guidelines';

  @override
  String get profileSafetyPrevention =>
      'Prevents suggesting foods that may worsen your condition';

  @override
  String get profileSafetyBalance =>
      'Helps balance nutrients specific to your health needs';

  @override
  String get profileSafetyGuidelines =>
      'All recommendations follow Indian dietary guidelines for lifestyle diseases';

  @override
  String get profileDietSubtitle =>
      'Select your dietary preferences (at least one required)';

  @override
  String get profileDietVeg => 'Vegetarian';

  @override
  String get profileDietVegDesc => 'No meat, fish, or poultry';

  @override
  String get profileDietVeganDesc => 'No animal products';

  @override
  String get profileDietJain => 'Jain';

  @override
  String get profileDietJainDesc => 'No root vegetables';

  @override
  String get profileDietEgg => 'Eggetarian';

  @override
  String get profileDietEggDesc => 'Vegetarian with eggs';

  @override
  String get profileDietNonVeg => 'Non-Vegetarian';

  @override
  String get profileDietNonVegDesc => 'Includes all food types';

  @override
  String get profileDietPescatarian => 'Pescatarian';

  @override
  String get profileDietPescatarianDesc => 'Vegetarian with fish';

  @override
  String get profileDietMultipleInfo =>
      'You can select multiple preferences. For example, Vegetarian + Jain or Eggetarian + Pescatarian.';

  @override
  String get profileDietImportanceTitle => 'Dietary Preference Importance';

  @override
  String get profileDietImportanceRespect =>
      'Ensures all meal suggestions respect your dietary choices';

  @override
  String get profileDietImportanceFilter =>
      'Filters out ingredients that don\'t match your preferences';

  @override
  String get profileDietImportanceCultural =>
      'Provides culturally appropriate Indian meal options';

  @override
  String get profileDietImportanceBalance =>
      'Helps maintain nutritional balance within your dietary framework';

  @override
  String get profileDietImportanceReligious =>
      'Supports religious and ethical food choices';

  @override
  String get profileBudgetSubtitle =>
      'Set your monthly food budget for smart meal planning';

  @override
  String get profileBudgetAmountLabel => 'Enter Budget Amount *';

  @override
  String get profileBudgetAmountHint => 'Enter your monthly food budget';

  @override
  String get profileBudgetAmountRequired => 'Budget is required';

  @override
  String get profileBudgetAmountMin => 'Minimum budget is ₹1,000';

  @override
  String get profileBudgetAmountMax => 'Maximum budget is ₹1,00,000';

  @override
  String get profileBudgetQuickSelect => 'Quick Select';

  @override
  String get profileBudgetBreakdownTitle => 'Budget Breakdown';

  @override
  String get profileBudgetDaily => 'Daily Budget';

  @override
  String get profileBudgetWeekly => 'Weekly Budget';

  @override
  String get profileBudgetPerMeal => 'Per Meal (approx.)';

  @override
  String get profileBudgetSavingsInfo =>
      'We\'ll suggest budget-friendly ingredient substitutions and help you track spending throughout the month.';

  @override
  String get profileBudgetAwareTitle => 'Budget-Aware Planning';

  @override
  String get profileBudgetAwareSuggest =>
      'Suggests meals that fit within your monthly budget';

  @override
  String get profileBudgetAwareCost =>
      'Provides cost-effective ingredient alternatives';

  @override
  String get profileBudgetAwareTrack =>
      'Helps track grocery spending throughout the month';

  @override
  String get profileBudgetAwareOptimize =>
      'Optimizes meal plans for maximum nutrition at minimum cost';

  @override
  String get profileBudgetAwarePrevent => 'Prevents overspending on groceries';

  @override
  String get profileAllergyTitle => 'Allergies & Intolerances';

  @override
  String get profileAllergySubtitle =>
      'Select any food allergies or intolerances (optional)';

  @override
  String get profileAllergySearchHint => 'Search or add custom allergy';

  @override
  String get profileAllergySelected => 'Selected Allergies';

  @override
  String get profileAllergyCommon => 'Common Allergies';

  @override
  String get profileAllergyWarning =>
      'All meal plans will automatically exclude ingredients you\'re allergic to. Please consult your doctor for severe allergies.';

  @override
  String get profileAllergySafetyTitle => 'Allergy Safety';

  @override
  String get profileAllergySafetyPrevents =>
      'Prevents suggesting meals with allergens that could harm you';

  @override
  String get profileAllergySafetyFilters =>
      'Automatically filters out unsafe ingredients from all recommendations';

  @override
  String get profileAllergySafetySubstitutions =>
      'Provides safe ingredient substitutions in meal plans';

  @override
  String get profileAllergySafetyExclude =>
      'Ensures grocery lists exclude allergenic items';

  @override
  String get profileAllergySafetyCritical =>
      'Critical for your health and safety';

  @override
  String get allergyPeanuts => 'Peanuts';

  @override
  String get allergyTreeNuts => 'Tree Nuts';

  @override
  String get allergyMilk => 'Milk';

  @override
  String get allergyEggs => 'Eggs';

  @override
  String get allergyWheat => 'Wheat';

  @override
  String get allergySoy => 'Soy';

  @override
  String get allergyFish => 'Fish';

  @override
  String get allergyShellfish => 'Shellfish';

  @override
  String get allergySesame => 'Sesame';

  @override
  String get allergyMustard => 'Mustard';

  @override
  String get allergyGluten => 'Gluten';

  @override
  String get allergyLactose => 'Lactose';

  @override
  String get allergyCorn => 'Corn';

  @override
  String get allergyGarlic => 'Garlic';

  @override
  String get allergyOnion => 'Onion';

  @override
  String get allergyTomato => 'Tomato';

  @override
  String get allergyCitrus => 'Citrus Fruits';

  @override
  String get allergyStrawberries => 'Strawberries';

  @override
  String get allergyChocolate => 'Chocolate';

  @override
  String get allergyCaffeine => 'Caffeine';

  @override
  String get mockGroceryGinger => 'Ginger';

  @override
  String get mockGroceryGreenChillies => 'Green Chillies';

  @override
  String get mockGroceryCorianderLeaves => 'Coriander Leaves';

  @override
  String get mockGroceryReasonFreq => 'Frequently purchased';

  @override
  String mockGroceryReasonOften(String item) {
    return 'Often bought with $item';
  }

  @override
  String get mockGroceryReasonPlan => 'Complements your meal plan';

  @override
  String get loadingGeneral => 'Loading...';

  @override
  String groceryExceedsBudgetInfo(String amount) {
    return 'Your current list exceeds budget by $amount. Consider these alternatives:';
  }

  @override
  String grocerySubstitutionPrompt(String item1, String item2) {
    return 'Switch $item1 to $item2?';
  }

  @override
  String get groceryImpactMinimal => 'Impact on taste is minimal';

  @override
  String get groceryCategoryPantry => 'Pantry Staples';

  @override
  String get groceryItemBrownRice => 'Brown Rice';

  @override
  String get groceryItemMoongDal => 'Moong Dal';

  @override
  String get groceryItemSpinach => 'Spinach';

  @override
  String get groceryItemCarrots => 'Carrots';

  @override
  String get groceryBudgetFriendlyAlts => 'Budget-Friendly Alternatives';

  @override
  String get mealPlanTitle => 'Daily Meal Plan';

  @override
  String get mealPlanNoPlan => 'No meal plan available';

  @override
  String get mealPlanBreakfast => 'Breakfast';

  @override
  String get mealPlanLunch => 'Lunch';

  @override
  String get mealPlanDinner => 'Dinner';

  @override
  String get mealPlanSnacks => 'Snacks';

  @override
  String get mealPlanToday => 'Today';

  @override
  String get mealPlanPrevDay => 'Previous day';

  @override
  String get mealPlanNextDay => 'Next day';

  @override
  String get mealPlanWhyMeal => 'Why this meal?';

  @override
  String get mealPlanCookingSteps => 'Cooking Steps';

  @override
  String get mealPlanListenInstructions => 'Listen to instructions';

  @override
  String get mealPlanIngredients => 'Ingredients';

  @override
  String mealPlanAddCount(int count) {
    return 'Add ($count)';
  }

  @override
  String mealPlanCanSubstitute(String item) {
    return 'Can substitute: $item';
  }

  @override
  String get mealPlanLongPressSelect =>
      'Long press any ingredient to select for grocery list';

  @override
  String get mealPlanPrepTime => 'Prep Time';

  @override
  String get mealPlanServings => 'Servings';

  @override
  String get mealPlanCalories => 'Calories';

  @override
  String mealPlanKcalValue(String value) {
    return '$value kcal';
  }

  @override
  String get mealPlanFeedbackTitle => 'Meal Feedback';

  @override
  String get mealPlanEaten => 'Eaten';

  @override
  String get mealPlanPartial => 'Partial';

  @override
  String get mealPlanSkipped => 'Skipped';

  @override
  String get mealPlanAdaptFeedback => 'Plan will adapt based on your feedback';

  @override
  String mealPlanKcal(String value) {
    return '$value kcal';
  }

  @override
  String mealPlanRupee(String value) {
    return '₹$value';
  }

  @override
  String get mealPlanBudgetWithin => 'Within budget - Great job!';

  @override
  String mealPlanBudgetExceeded(String amount) {
    return 'Budget exceeded by ₹$amount';
  }

  @override
  String get mealPlanSummaryTitle => 'Daily Summary';

  @override
  String get mealPlanTotalCalories => 'Total Calories';

  @override
  String get mealPlanTotalCost => 'Total Cost';

  @override
  String get mealPlanAISelectedHeader =>
      'Our AI selected these meals based on:';

  @override
  String get mealPlanWhyToday => 'Why today\'s meals';

  @override
  String get mealPlanReason1 =>
      'High-protein breakfast supports your PCOS management and keeps you full longer';

  @override
  String get mealPlanReason2 =>
      'Lunch includes low-GI foods suitable for diabetes control with balanced nutrients';

  @override
  String get mealPlanReason3 =>
      'Dinner is light yet nutritious, promoting better sleep and digestion';

  @override
  String get mealPlanReason4 =>
      'All meals stay within your daily budget while meeting nutritional goals';

  @override
  String get mealPlanOatsUpma => 'Oats Upma with Vegetables';

  @override
  String get mealPlanMoongDalCheela => 'Moong Dal Cheela with Mint Chutney';

  @override
  String get mealPlanRagiDosa => 'Ragi Dosa with Sambar';

  @override
  String get mealPlanBrownRiceDal => 'Brown Rice with Dal Tadka and Salad';

  @override
  String get mealPlanQuinoaPulao => 'Quinoa Pulao with Raita';

  @override
  String get mealPlanGrilledChicken => 'Grilled Chicken with Multigrain Roti';

  @override
  String get mealPlanPalakPaneer => 'Palak Paneer with Roti';

  @override
  String get mealPlanVegKhichdi => 'Vegetable Khichdi with Curd';

  @override
  String get mealPlanGrilledFish => 'Grilled Fish with Steamed Vegetables';

  @override
  String get mealPlanMixedNuts => 'Mixed Nuts and Seeds';

  @override
  String get mealPlanFruitSalad => 'Fruit Salad with Yogurt';

  @override
  String get mealPlanRoastedChickpeas => 'Roasted Chickpeas';

  @override
  String get mealPlanDiabetesSafe => 'Diabetes-safe';

  @override
  String get mealPlanPCOSFriendly => 'PCOS-friendly';

  @override
  String get mealPlanHeartHealthy => 'Heart-healthy';

  @override
  String get mealPlanIronRich => 'Iron-rich';

  @override
  String get mealPlanHighProtein => 'High-protein';

  @override
  String get mealPlanVitaminRich => 'Vitamin-rich';

  @override
  String get mealPlanHighFiber => 'High-fiber';

  @override
  String get mealPlanOatsUpmaSummary =>
      'Low glycemic index breakfast that keeps you full and prevents sugar spikes.';

  @override
  String get mealPlanOatsUpmaReason1 => 'High fiber from oats and vegetables';

  @override
  String get mealPlanOatsUpmaReason2 => 'Slow glucose absorption';

  @override
  String get mealPlanOatsUpmaReason3 => 'Rich in essential minerals';

  @override
  String get mealPlanBrownRiceSummary =>
      'Balanced meal providing complex carbs and plant-based protein.';

  @override
  String get mealPlanBrownRiceReason1 => 'Protein-rich dal for satiety';

  @override
  String get mealPlanBrownRiceReason2 => 'Fiber from brown rice and salad';

  @override
  String get mealPlanBrownRiceReason3 => 'Complete amino acid profile';

  @override
  String get mealPlanRoastedMakhanaSummary =>
      'Light, anti-inflammatory snack rich in antioxidants.';

  @override
  String get mealPlanRoastedMakhanaReason1 => 'Antioxidants from green tea';

  @override
  String get mealPlanRoastedMakhanaReason2 => 'Low calorie density';

  @override
  String get mealPlanRoastedMakhanaReason3 =>
      'Manganese and protein from makhana';

  @override
  String get mealPlanPalakPaneerSummary =>
      'Protein and iron-rich dinner that supports muscle repair and hormonal health.';

  @override
  String get mealPlanPalakPaneerReason1 => 'Iron from spinach';

  @override
  String get mealPlanPalakPaneerReason2 => 'Protein from paneer';

  @override
  String get mealPlanPalakPaneerReason3 => 'Probiotics from curd';

  @override
  String get mockIngredientOats => 'Oats';

  @override
  String get mockIngredientMustardSeeds => 'Mustard seeds';

  @override
  String get mockIngredientCurryLeaves => 'Curry leaves';

  @override
  String get mockIngredientGreenChili => 'Green chili';

  @override
  String get mockIngredientPhoolMakhana => 'Phool Makhana (Fox nuts)';

  @override
  String get mockIngredientGreenTeaBag => 'Green tea bag';

  @override
  String get mockIngredientBlackSalt => 'Black salt & Pepper';

  @override
  String get mockIngredientGhee => 'Ghee/Olive oil';

  @override
  String get mockIngredientCucumber => 'Cucumber';

  @override
  String get mockIngredientPalakPuree => 'Palak (Spinach) puree';

  @override
  String get mockIngredientPaneerCubes => 'Paneer cubes';

  @override
  String get mockInstructionDryRoast =>
      'Dry roast oats for 2-3 minutes until lightly golden.';

  @override
  String get mockInstructionTadka =>
      'Heat oil, add mustard seeds, curry leaves, and green chilies.';

  @override
  String get mockInstructionSauteVeg =>
      'Add onions and vegetables, sauté until tender.';

  @override
  String get mockInstructionBoilWater =>
      'Add water and salt, bring to boil. Stir in roasted oats.';

  @override
  String get mockInstructionCookOats =>
      'Cook until water is absorbed and oats are soft.';

  @override
  String get mockInstructionCookBrownRice =>
      'Cook brown rice as per instructions.';

  @override
  String get mockInstructionPressureCookDal =>
      'Pressure cook dal with turmeric and salt.';

  @override
  String get mockInstructionPerformTadka =>
      'Perform tadka with cumin and garlic in a little ghee/oil.';

  @override
  String get mockInstructionPrepareSalad =>
      'Prepare fresh salad with chopped cucumber and tomatoes.';

  @override
  String get mockInstructionRoastMakhana =>
      'Heat ghee in a pan and roast makhana until crunchy.';

  @override
  String get mockInstructionSeasonMakhana =>
      'Season with black salt and pepper while hot.';

  @override
  String get mockInstructionBrewTea =>
      'Brew green tea in hot water for 2-3 minutes.';

  @override
  String get mockInstructionPreparePalakPaneer =>
      'Prepare palak paneer gravy with spices and paneer.';

  @override
  String get mockInstructionMakeRotis =>
      'Make fresh Rotis on a flat griddle (tawa).';

  @override
  String get mockInstructionMixRaita =>
      'Mix grated cucumber in whisked curd for raita.';

  @override
  String get mockBenefitInsulin =>
      'Slow energy release prevents insulin spikes.';

  @override
  String get mockBenefitSatiety => 'High fiber content promotes satiety.';

  @override
  String get mockBenefitDigestion => 'High fiber aids in smooth digestion.';

  @override
  String get mockBenefitHormonal => 'Nutrients support PCOS management.';

  @override
  String get mockBenefitOxidative => 'Green tea helps reduce oxidative stress.';

  @override
  String get mockBenefitMindful =>
      'Crunchy texture satisfies cravings with low calories.';

  @override
  String get mockBenefitIron => 'Spinach is a rich source of plant-based iron.';

  @override
  String get mockBenefitGutHealth =>
      'Raita provides probiotics for better digestion.';

  @override
  String get mockConditionDigestion => 'Digestion';

  @override
  String get mockConditionHormonal => 'Hormonal Balance';

  @override
  String get mockConditionInflammation => 'Inflammation';

  @override
  String get mockConditionMindful => 'Mindful Snacking';

  @override
  String get mockConditionIron => 'Iron Deficiency';

  @override
  String get mockConditionGutHealth => 'Gut Health';

  @override
  String get mealPlanOatsUpmaExpl =>
      'High fiber content helps regulate blood sugar levels';

  @override
  String get mealPlanMoongDalExpl =>
      'Protein-rich moong dal supports hormonal balance';

  @override
  String get mealPlanRagiDosaExpl =>
      'Ragi provides calcium and iron for overall wellness';

  @override
  String get mealPlanBrownRiceExpl =>
      'Brown rice has low glycemic index, perfect for blood sugar control';

  @override
  String get mealPlanQuinoaExpl =>
      'Quinoa is a complete protein source supporting metabolic health';

  @override
  String get mealPlanGrilledChickenExpl =>
      'Lean protein supports muscle health and keeps you satisfied';

  @override
  String get mealPlanPalakPaneerExpl =>
      'Spinach provides iron and calcium for bone health';

  @override
  String get mealPlanVegKhichdiExpl =>
      'Easy to digest, balanced meal perfect for dinner';

  @override
  String get mealPlanGrilledFishExpl =>
      'Omega-3 fatty acids support cardiovascular health';

  @override
  String get mealPlanMixedNutsExpl =>
      'Healthy fats and protein for sustained energy';

  @override
  String get mealPlanFruitSaladExpl =>
      'Fresh fruits provide antioxidants and natural sweetness';

  @override
  String get mealPlanRoastedChickpeasExpl =>
      'Fiber-rich snack that keeps you full between meals';

  @override
  String get insightsTitle => 'Health Insights';

  @override
  String get insightsRefreshTooltip => 'Refresh insights';

  @override
  String get insightsYourHealthScore => 'Your Health Score';

  @override
  String insightsWeeklyChange(String value) {
    return '$value points this week';
  }

  @override
  String get insightsHealthConditions => 'Health Conditions';

  @override
  String get insightsNutrientBalance => 'Nutrient Balance';

  @override
  String get insightsWeeklyTrends => 'Weekly Trends';

  @override
  String get insightsPersonalizedInsights => 'Personalized Insights';

  @override
  String get insightsRecommendations => 'Recommendations';

  @override
  String get insightsDietAdherence => 'Diet Adherence';

  @override
  String get insightsNutrientTracking => 'Daily Nutrient Tracking';

  @override
  String get insightsStatusWithinRange => 'Within Range';

  @override
  String get insightsStatusBorderline => 'Borderline';

  @override
  String get insightsStatusNeedsImprovement => 'Needs Improvement';

  @override
  String get insightsStatusStable => 'Stable';

  @override
  String get insightsStatusImproving => 'Improving';

  @override
  String get insightsStatusNeedsAttention => 'Needs Attention';

  @override
  String get insightsTrendImproving => 'Improving';

  @override
  String get insightsTrendDeclining => 'Declining';

  @override
  String get insights7DayTrends => '7-Day Trends';

  @override
  String get insightsTabAdherence => 'Adherence';

  @override
  String get insightsTabCalories => 'Calories';

  @override
  String get insightsTabBudget => 'Budget';

  @override
  String get insightsNoData => 'No data available';

  @override
  String get insightsDefaultTitle => 'Insight';

  @override
  String get insightsActionable => 'Actionable';

  @override
  String get insightsDefaultRecommendation => 'Recommendation';

  @override
  String get mockInsightConsistentTimingTitle => 'Consistent Meal Timing';

  @override
  String get mockInsightConsistentTimingDesc =>
      'You\'ve maintained regular meal times for 6 days. This helps stabilize blood sugar levels.';

  @override
  String get mockInsightFiberLowTitle => 'Fiber Intake Below Target';

  @override
  String get mockInsightFiberLowDesc =>
      'Your fiber intake is 73% of target. Consider adding more vegetables and whole grains.';

  @override
  String get mockInsightBudgetOptTitle => 'Budget Optimization';

  @override
  String get mockInsightBudgetOptDesc =>
      'You\'re staying within budget while meeting nutritional goals. Great balance!';

  @override
  String get mockInsightSugarHighTitle => 'Sugar Intake High';

  @override
  String get mockInsightSugarHighDesc =>
      'Daily sugar intake is 29% above target. Try reducing sweetened beverages and desserts.';

  @override
  String get mockRecFiberIncreaseTitle => 'Increase Fiber Intake';

  @override
  String get mockRecFiberIncreaseDesc =>
      'Add 1 cup of mixed vegetables to lunch and dinner. Try switching white rice to brown rice.';

  @override
  String get mockRecSugarReduceTitle => 'Reduce Added Sugar';

  @override
  String get mockRecSugarReduceDesc =>
      'Replace sweetened beverages with herbal tea or infused water. Choose fresh fruits over fruit juices.';

  @override
  String get mockRecProteinMaintainTitle => 'Maintain Current Protein Levels';

  @override
  String get mockRecProteinMaintainDesc =>
      'Your protein intake is excellent. Continue including dal, paneer, and eggs in your meals.';

  @override
  String get mockRecHydrateTitle => 'Stay Hydrated';

  @override
  String get mockRecHydrateDesc =>
      'Aim for 8-10 glasses of water daily to support metabolism and nutrient absorption.';

  @override
  String get adaptivePlanActive => 'Adaptive Plan Active';

  @override
  String get adaptivePersonalized => 'Personalized';

  @override
  String get adaptiveAdjustedDesc =>
      'Your plan has been automatically adjusted based on your eating patterns:';

  @override
  String get adaptivePortionsOptimized =>
      'Portions optimized for your consumption habits';

  @override
  String get adaptiveMealsReplaced =>
      'Meals replaced based on your preferences';

  @override
  String get adaptiveNutrientsRebalanced =>
      'Nutrients rebalanced for optimal health';

  @override
  String get mockConditionDiabetes => 'Type 2 Diabetes';

  @override
  String get mockConditionPCOS => 'PCOS';

  @override
  String get mockConditionHypertension => 'Hypertension';

  @override
  String get mealPlanProtein => 'Protein';

  @override
  String get mealPlanFiber => 'Fiber';

  @override
  String get mealPlanSugar => 'Sugar';

  @override
  String get mealPlanSodium => 'Sodium';

  @override
  String get pantryTitle => 'Pantry Management';

  @override
  String get pantryRefreshTooltip => 'Refresh pantry';

  @override
  String get pantrySearchHint => 'Search ingredients...';

  @override
  String get pantryTabInventory => 'Inventory';

  @override
  String get pantryTabSuggestions => 'Meal Suggestions';

  @override
  String get pantryFabAddItem => 'Add Item';

  @override
  String get pantryEmptyNoItems => 'No Items in Pantry';

  @override
  String get pantryEmptyNoResults => 'No Results Found';

  @override
  String get pantryEmptyMessageNoItems =>
      'Start adding ingredients to track your pantry inventory';

  @override
  String get pantryEmptyMessageNoResults =>
      'Try searching with different keywords';

  @override
  String get pantrySummaryTotal => 'Total Items';

  @override
  String get pantrySummaryFresh => 'Fresh';

  @override
  String get pantrySummaryExpiring => 'Expiring';

  @override
  String get pantrySummaryExpired => 'Expired';

  @override
  String get pantrySuggestionsTitle => 'Smart Meal Suggestions';

  @override
  String get pantrySuggestionsSubtitle =>
      'Based on your available pantry stock';

  @override
  String get pantryEmptyNoSuggestions => 'No Meal Suggestions';

  @override
  String get pantryEmptyMessageNoSuggestions =>
      'Add more ingredients to get personalized meal suggestions';

  @override
  String pantrySnackAddedToList(String itemName) {
    return '$itemName added to grocery list';
  }

  @override
  String pantrySnackMarkedUsed(String itemName) {
    return '$itemName marked as used';
  }

  @override
  String pantrySnackAddedToPantry(String itemName) {
    return '$itemName added to pantry';
  }

  @override
  String get pantryDialogAddTitle => 'Add Pantry Item';

  @override
  String get pantryDialogItemNameLabel => 'Item Name *';

  @override
  String get pantryDialogItemNameHint => 'e.g., Tomatoes';

  @override
  String get pantryDialogCategoryLabel => 'Category *';

  @override
  String get pantryDialogQuantityLabel => 'Quantity *';

  @override
  String get pantryDialogQuantityHint => '0.0';

  @override
  String get pantryDialogUnitLabel => 'Unit *';

  @override
  String get pantryDialogExpiryDateLabel => 'Expiry Date *';

  @override
  String get pantryDialogErrorFields => 'Please fill all required fields';

  @override
  String get pantryDialogCancel => 'Cancel';

  @override
  String get pantryDialogConfirmAdd => 'Add Item';

  @override
  String get pantryCategoryVegetables => 'Vegetables';

  @override
  String get pantryCategoryGrains => 'Grains';

  @override
  String get pantryCategorySpices => 'Spices';

  @override
  String get pantryCategoryDairy => 'Dairy';

  @override
  String get pantryCategoryProteins => 'Proteins';

  @override
  String get pantryCategoryOther => 'Other';

  @override
  String get unitKg => 'kg';

  @override
  String get unitG => 'g';

  @override
  String get unitL => 'L';

  @override
  String get unitMl => 'ml';

  @override
  String get unitPcs => 'pcs';

  @override
  String get pantryStatusFresh => 'Fresh';

  @override
  String get pantryStatusExpiringSoon => 'Expiring Soon';

  @override
  String get pantryStatusExpired => 'Expired';

  @override
  String get pantryStatusUnknown => 'Unknown';

  @override
  String pantryMealCal(String value) {
    return '$value cal';
  }

  @override
  String pantryMealAvailablePercent(int value) {
    return '$value% available';
  }

  @override
  String get pantryMealRequiredIngredients => 'Required Ingredients';

  @override
  String get pantryMealInPantry => 'In Pantry';

  @override
  String get pantryMealMissingIngredients => 'Missing Ingredients';

  @override
  String pantryMealEstimatedCost(String value) {
    return 'Estimated cost: ₹$value';
  }

  @override
  String get pantryMealReadyToCook =>
      'All ingredients available! Ready to cook.';

  @override
  String get pantryMealAddedMissingToGrocery =>
      'Missing ingredients added to grocery list';

  @override
  String get pantryMealStartCooking => 'Start Cooking';

  @override
  String get pantryMealAddMissingItems => 'Add Missing Items to Grocery';

  @override
  String pantryMealMissingLabel(String value) {
    return 'Missing: $value';
  }

  @override
  String get pantryMealAllAvailable => 'All ingredients available!';

  @override
  String get pantryMealTapToView => 'Tap to view details';

  @override
  String get pantryDetailsStock => 'Current Stock';

  @override
  String get pantryDetailsDaysLeft => 'Days Left';

  @override
  String pantryDetailsDaysRange(int value) {
    return '$value days';
  }

  @override
  String get pantryDetailsPurchaseDate => 'Purchase Date';

  @override
  String get pantryDetailsExpiryDate => 'Expiry Date';

  @override
  String get pantryDetailsStockLevel => 'Stock Level';

  @override
  String get pantryDetailsNoUsage => 'No usage recorded yet';

  @override
  String get pantryDetailsUsageHistory => 'Usage History';

  @override
  String pantryDetailsMarkUsedTitle(String itemName) {
    return 'Mark $itemName as Used';
  }

  @override
  String get pantryDetailsSelectPortion => 'Select portion used:';

  @override
  String get pantryDetailsConfirm => 'Confirm';

  @override
  String get pantryDetailsAddToList => 'Add to List';

  @override
  String get pantryDetailsMarkUsed => 'Mark Used';

  @override
  String pantryDetailsExpiresLabel(String date, int days) {
    return 'Expires: $date ($days days)';
  }

  @override
  String get mockIngredientCapsicum => 'Capsicum';

  @override
  String get mockIngredientMixedVeg => 'Mixed Vegetables';

  @override
  String get mockIngredientDalia => 'Dalia (Broken Wheat)';

  @override
  String get mockMealVegPulao => 'Vegetable Pulao';

  @override
  String get mockMealPaneerTikka => 'Paneer Tikka';

  @override
  String get mockMealDaliaKhichdi => 'Dalia Khichdi';

  @override
  String get mockIngredientOnions => 'Onions';

  @override
  String get mockIngredientTomatoes => 'Tomatoes';

  @override
  String get mockIngredientSpinach => 'Spinach';

  @override
  String get mockIngredientCarrots => 'Carrots';

  @override
  String get mockIngredientBasmatiRice => 'Basmati Rice';

  @override
  String get mockIngredientWheatFlour => 'Whole Wheat Flour';

  @override
  String get mockIngredientMoongDal => 'Moong Dal';

  @override
  String get mockIngredientTurmeric => 'Turmeric Powder';

  @override
  String get mockIngredientCumin => 'Cumin Seeds';

  @override
  String get mockIngredientGaramMasala => 'Garam Masala';

  @override
  String get mockIngredientMilk => 'Milk';

  @override
  String get mockIngredientYogurt => 'Yogurt';

  @override
  String get mockIngredientPaneer => 'Paneer';

  @override
  String get mockIngredientChicken => 'Chicken Breast';

  @override
  String get mockIngredientEggs => 'Eggs';

  @override
  String get mockIngredientGreenPeas => 'Green Peas';

  @override
  String get mockIngredientCream => 'Cream';

  @override
  String get mockIngredientButter => 'Butter';

  @override
  String get mockIngredientCoconutMilk => 'Coconut Milk';

  @override
  String get mockIngredientGarlic => 'Garlic';

  @override
  String get mockMealDalTadka => 'Dal Tadka';

  @override
  String get mockMealPaneerButterMasala => 'Paneer Butter Masala';

  @override
  String get mockMealEggCurry => 'Egg Curry';

  @override
  String get mealPlanRoastedMakhana => 'Roasted Makhana with Green Tea';

  @override
  String get mealPlanRotiPalakPaneer =>
      'Roti with Palak Paneer & Cucumber Raita';

  @override
  String get mockMealIdliSambar => 'Idli with Sambar';

  @override
  String get mockMealDosaChutney => 'Dosa with Coconut Chutney';

  @override
  String get mockMealVegetableUpma => 'Vegetable Upma';

  @override
  String get mockMealLemonRice => 'Lemon Rice';

  @override
  String get mockMealCurdRice => 'Curd Rice';

  @override
  String get mockMealRagiMudde => 'Ragi Mudde with Saaru';

  @override
  String get mockMealRotiDalTadka => 'Roti with Dal Tadka';

  @override
  String get mockMealRajmaChawal => 'Rajma Chawal';

  @override
  String get mockMealVegetableKhichdi => 'Vegetable Khichdi';

  @override
  String get mockMealCholeRice => 'Chole with Rice';

  @override
  String get mockMealPaneerBhurji => 'Paneer Bhurji with Roti';
}

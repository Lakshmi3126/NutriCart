import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_kn.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('hi'),
    Locale('kn'),
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'NutriCart'**
  String get appName;

  /// No description provided for @dashboardGreeting.
  ///
  /// In en, this message translates to:
  /// **'Hello, {userName} 👋'**
  String dashboardGreeting(String userName);

  /// No description provided for @dashboardHighlightTitle.
  ///
  /// In en, this message translates to:
  /// **'Great Progress Today!'**
  String get dashboardHighlightTitle;

  /// No description provided for @dashboardHighlightSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Meals adjusted to fit your budget'**
  String get dashboardHighlightSubtitle;

  /// No description provided for @dashboardQuickActionsTitle.
  ///
  /// In en, this message translates to:
  /// **'Quick Actions'**
  String get dashboardQuickActionsTitle;

  /// No description provided for @dashboardQuickActionMealPlanTitle.
  ///
  /// In en, this message translates to:
  /// **'Meal Plan'**
  String get dashboardQuickActionMealPlanTitle;

  /// No description provided for @dashboardQuickActionMealPlanSubtitle.
  ///
  /// In en, this message translates to:
  /// **'View today\'s meals'**
  String get dashboardQuickActionMealPlanSubtitle;

  /// No description provided for @dashboardQuickActionGroceryTitle.
  ///
  /// In en, this message translates to:
  /// **'Grocery'**
  String get dashboardQuickActionGroceryTitle;

  /// No description provided for @dashboardQuickActionGrocerySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Shopping list'**
  String get dashboardQuickActionGrocerySubtitle;

  /// No description provided for @dashboardQuickActionBudgetTitle.
  ///
  /// In en, this message translates to:
  /// **'Budget Tracker'**
  String get dashboardQuickActionBudgetTitle;

  /// No description provided for @dashboardQuickActionBudgetSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Monitor your spending'**
  String get dashboardQuickActionBudgetSubtitle;

  /// No description provided for @dashboardQuickActionPantryTitle.
  ///
  /// In en, this message translates to:
  /// **'Pantry Management'**
  String get dashboardQuickActionPantryTitle;

  /// No description provided for @dashboardQuickActionPantrySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Track your ingredients'**
  String get dashboardQuickActionPantrySubtitle;

  /// No description provided for @dashboardQuickActionReengineeringTitle.
  ///
  /// In en, this message translates to:
  /// **'Meal Re-engineering'**
  String get dashboardQuickActionReengineeringTitle;

  /// No description provided for @dashboardQuickActionReengineeringSubtitle.
  ///
  /// In en, this message translates to:
  /// **'View intelligent meal updates'**
  String get dashboardQuickActionReengineeringSubtitle;

  /// No description provided for @dashboardQuickActionInsightsTitle.
  ///
  /// In en, this message translates to:
  /// **'Health Insights'**
  String get dashboardQuickActionInsightsTitle;

  /// No description provided for @dashboardQuickActionInsightsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Track your health progress'**
  String get dashboardQuickActionInsightsSubtitle;

  /// No description provided for @dashboardWhyTheseMealsTitle.
  ///
  /// In en, this message translates to:
  /// **'Why These Meals?'**
  String get dashboardWhyTheseMealsTitle;

  /// No description provided for @dashboardPantryAlertsTitle.
  ///
  /// In en, this message translates to:
  /// **'Pantry Alerts'**
  String get dashboardPantryAlertsTitle;

  /// No description provided for @dashboardOverviewTitle.
  ///
  /// In en, this message translates to:
  /// **'Today\'s Overview'**
  String get dashboardOverviewTitle;

  /// No description provided for @timeAM.
  ///
  /// In en, this message translates to:
  /// **'AM'**
  String get timeAM;

  /// No description provided for @timePM.
  ///
  /// In en, this message translates to:
  /// **'PM'**
  String get timePM;

  /// No description provided for @seasonalSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Seasonal Picks Near You 🌾'**
  String get seasonalSectionTitle;

  /// No description provided for @seasonalSectionSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Based on Bangalore markets in February'**
  String get seasonalSectionSubtitle;

  /// No description provided for @seasonalButtonAddToGrocery.
  ///
  /// In en, this message translates to:
  /// **'Add to Grocery List'**
  String get seasonalButtonAddToGrocery;

  /// No description provided for @seasonalSnackAddedToGrocery.
  ///
  /// In en, this message translates to:
  /// **'Added to grocery list'**
  String get seasonalSnackAddedToGrocery;

  /// No description provided for @groceryTitle.
  ///
  /// In en, this message translates to:
  /// **'Grocery List'**
  String get groceryTitle;

  /// No description provided for @grocerySearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search ingredients...'**
  String get grocerySearchHint;

  /// No description provided for @groceryEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No Items Found'**
  String get groceryEmptyTitle;

  /// No description provided for @groceryEmptyMessageDefault.
  ///
  /// In en, this message translates to:
  /// **'Your grocery list is empty. Add items from meal plans.'**
  String get groceryEmptyMessageDefault;

  /// No description provided for @groceryEmptyMessageFiltered.
  ///
  /// In en, this message translates to:
  /// **'No ingredients match your search.'**
  String get groceryEmptyMessageFiltered;

  /// No description provided for @groceryEmptyPrimary.
  ///
  /// In en, this message translates to:
  /// **'Browse Meals'**
  String get groceryEmptyPrimary;

  /// No description provided for @groceryEmptyClearSearch.
  ///
  /// In en, this message translates to:
  /// **'Clear Search'**
  String get groceryEmptyClearSearch;

  /// No description provided for @groceryFabAddItem.
  ///
  /// In en, this message translates to:
  /// **'Add Item'**
  String get groceryFabAddItem;

  /// No description provided for @grocerySnackAddedToPantry.
  ///
  /// In en, this message translates to:
  /// **'Added to pantry'**
  String get grocerySnackAddedToPantry;

  /// No description provided for @grocerySnackRemovedFromList.
  ///
  /// In en, this message translates to:
  /// **'Removed from list'**
  String get grocerySnackRemovedFromList;

  /// No description provided for @grocerySnackOpeningWhatsApp.
  ///
  /// In en, this message translates to:
  /// **'Opening WhatsApp...'**
  String get grocerySnackOpeningWhatsApp;

  /// No description provided for @grocerySnackOpeningSms.
  ///
  /// In en, this message translates to:
  /// **'Opening SMS...'**
  String get grocerySnackOpeningSms;

  /// No description provided for @grocerySnackCopiedList.
  ///
  /// In en, this message translates to:
  /// **'List copied to clipboard'**
  String get grocerySnackCopiedList;

  /// No description provided for @groceryShareTitle.
  ///
  /// In en, this message translates to:
  /// **'Share Grocery List'**
  String get groceryShareTitle;

  /// No description provided for @groceryShoppingProgressTitle.
  ///
  /// In en, this message translates to:
  /// **'Shopping Progress'**
  String get groceryShoppingProgressTitle;

  /// No description provided for @groceryShoppingProgressLabel.
  ///
  /// In en, this message translates to:
  /// **'{purchased}/{total} items'**
  String groceryShoppingProgressLabel(int purchased, int total);

  /// No description provided for @deliverySectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Delivery Integration'**
  String get deliverySectionTitle;

  /// No description provided for @deliverySectionSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Quick delivery options based on your cart'**
  String get deliverySectionSubtitle;

  /// No description provided for @deliveryBigBasketTitle.
  ///
  /// In en, this message translates to:
  /// **'BigBasket'**
  String get deliveryBigBasketTitle;

  /// No description provided for @deliveryBigBasketSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Full range of groceries'**
  String get deliveryBigBasketSubtitle;

  /// No description provided for @deliveryBigBasketFee.
  ///
  /// In en, this message translates to:
  /// **'Fee: ₹30 (Free above ₹500)'**
  String get deliveryBigBasketFee;

  /// No description provided for @deliveryBigBasketEta.
  ///
  /// In en, this message translates to:
  /// **'ETA: 4-6 hours'**
  String get deliveryBigBasketEta;

  /// No description provided for @deliveryBlinkitTitle.
  ///
  /// In en, this message translates to:
  /// **'Blinkit'**
  String get deliveryBlinkitTitle;

  /// No description provided for @deliveryBlinkitSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Instant delivery'**
  String get deliveryBlinkitSubtitle;

  /// No description provided for @deliveryBlinkitFee.
  ///
  /// In en, this message translates to:
  /// **'Fee: ₹25 (Free above ₹199)'**
  String get deliveryBlinkitFee;

  /// No description provided for @deliveryBlinkitEta.
  ///
  /// In en, this message translates to:
  /// **'ETA: 15-20 mins'**
  String get deliveryBlinkitEta;

  /// No description provided for @deliveryDMartTitle.
  ///
  /// In en, this message translates to:
  /// **'DMart Ready'**
  String get deliveryDMartTitle;

  /// No description provided for @deliveryDMartSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Value shopping'**
  String get deliveryDMartSubtitle;

  /// No description provided for @deliveryDMartFee.
  ///
  /// In en, this message translates to:
  /// **'Pickup: Free | Delivery: ₹49'**
  String get deliveryDMartFee;

  /// No description provided for @deliveryDMartEta.
  ///
  /// In en, this message translates to:
  /// **'ETA: Next Day'**
  String get deliveryDMartEta;

  /// No description provided for @deliveryAvailableForCart.
  ///
  /// In en, this message translates to:
  /// **'Available for your cart size'**
  String get deliveryAvailableForCart;

  /// No description provided for @deliveryMinOrderNotMet.
  ///
  /// In en, this message translates to:
  /// **'Minimum order amount not met'**
  String get deliveryMinOrderNotMet;

  /// No description provided for @deliveryUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Currently unavailable in your area'**
  String get deliveryUnavailable;

  /// No description provided for @deliverySelectedLabel.
  ///
  /// In en, this message translates to:
  /// **'Selected Delivery: {provider}'**
  String deliverySelectedLabel(String provider);

  /// No description provided for @deliveryChipSelected.
  ///
  /// In en, this message translates to:
  /// **'Selected'**
  String get deliveryChipSelected;

  /// No description provided for @deliveryChipSelect.
  ///
  /// In en, this message translates to:
  /// **'Select'**
  String get deliveryChipSelect;

  /// No description provided for @profileSetupTitle.
  ///
  /// In en, this message translates to:
  /// **'Profile Setup'**
  String get profileSetupTitle;

  /// No description provided for @profileStepOfTotal.
  ///
  /// In en, this message translates to:
  /// **'Step {current} of {total}'**
  String profileStepOfTotal(int current, int total);

  /// No description provided for @profileStepPercent.
  ///
  /// In en, this message translates to:
  /// **'{percent}%'**
  String profileStepPercent(int percent);

  /// No description provided for @profileContinue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get profileContinue;

  /// No description provided for @profileCompleteSetup.
  ///
  /// In en, this message translates to:
  /// **'Complete Setup'**
  String get profileCompleteSetup;

  /// No description provided for @languageSelectorTitle.
  ///
  /// In en, this message translates to:
  /// **'App Language'**
  String get languageSelectorTitle;

  /// No description provided for @languageSelectorSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Choose the language for your NutriCart experience'**
  String get languageSelectorSubtitle;

  /// No description provided for @languageEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageEnglish;

  /// No description provided for @languageKannada.
  ///
  /// In en, this message translates to:
  /// **'ಕನ್ನಡ'**
  String get languageKannada;

  /// No description provided for @languageHindi.
  ///
  /// In en, this message translates to:
  /// **'हिन्दी'**
  String get languageHindi;

  /// No description provided for @dashboardMealCompletedCount.
  ///
  /// In en, this message translates to:
  /// **'{completed} of {total} meals'**
  String dashboardMealCompletedCount(int completed, int total);

  /// No description provided for @dashboardCalorieConsumed.
  ///
  /// In en, this message translates to:
  /// **'Consumed'**
  String get dashboardCalorieConsumed;

  /// No description provided for @dashboardCalorieRemaining.
  ///
  /// In en, this message translates to:
  /// **'Remaining'**
  String get dashboardCalorieRemaining;

  /// No description provided for @dashboardCalorieValue.
  ///
  /// In en, this message translates to:
  /// **'{value} kcal'**
  String dashboardCalorieValue(int value);

  /// No description provided for @dashboardUrgencyHigh.
  ///
  /// In en, this message translates to:
  /// **'High'**
  String get dashboardUrgencyHigh;

  /// No description provided for @dashboardUrgencyMedium.
  ///
  /// In en, this message translates to:
  /// **'Medium'**
  String get dashboardUrgencyMedium;

  /// No description provided for @dashboardUrgencyLow.
  ///
  /// In en, this message translates to:
  /// **'Low'**
  String get dashboardUrgencyLow;

  /// No description provided for @dashboardWeeklyProgressTitle.
  ///
  /// In en, this message translates to:
  /// **'Weekly Progress'**
  String get dashboardWeeklyProgressTitle;

  /// No description provided for @dashboardWeeklyProgressSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Nutrition adherence tracking'**
  String get dashboardWeeklyProgressSubtitle;

  /// No description provided for @dashboardWeeklyProgressSemantics.
  ///
  /// In en, this message translates to:
  /// **'Weekly nutrition adherence bar chart showing daily compliance percentages'**
  String get dashboardWeeklyProgressSemantics;

  /// No description provided for @dashboardLegendExcellent.
  ///
  /// In en, this message translates to:
  /// **'Excellent'**
  String get dashboardLegendExcellent;

  /// No description provided for @dashboardLegendGood.
  ///
  /// In en, this message translates to:
  /// **'Good'**
  String get dashboardLegendGood;

  /// No description provided for @dashboardLegendNeedsImprovement.
  ///
  /// In en, this message translates to:
  /// **'Needs Improvement'**
  String get dashboardLegendNeedsImprovement;

  /// No description provided for @dashboardLoading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get dashboardLoading;

  /// No description provided for @dashboardOffline.
  ///
  /// In en, this message translates to:
  /// **'Offline'**
  String get dashboardOffline;

  /// No description provided for @groceryCategoryVegetables.
  ///
  /// In en, this message translates to:
  /// **'Vegetables'**
  String get groceryCategoryVegetables;

  /// No description provided for @groceryCategoryGrains.
  ///
  /// In en, this message translates to:
  /// **'Grains'**
  String get groceryCategoryGrains;

  /// No description provided for @groceryCategorySpices.
  ///
  /// In en, this message translates to:
  /// **'Spices'**
  String get groceryCategorySpices;

  /// No description provided for @groceryCategoryDairy.
  ///
  /// In en, this message translates to:
  /// **'Dairy'**
  String get groceryCategoryDairy;

  /// No description provided for @groceryBudgetSummaryTitle.
  ///
  /// In en, this message translates to:
  /// **'Budget Summary'**
  String get groceryBudgetSummaryTitle;

  /// No description provided for @groceryWeeklyEstimate.
  ///
  /// In en, this message translates to:
  /// **'Weekly Estimate'**
  String get groceryWeeklyEstimate;

  /// No description provided for @groceryMonthlyBudget.
  ///
  /// In en, this message translates to:
  /// **'Monthly Budget'**
  String get groceryMonthlyBudget;

  /// No description provided for @grocerySpent.
  ///
  /// In en, this message translates to:
  /// **'Spent'**
  String get grocerySpent;

  /// No description provided for @groceryRemaining.
  ///
  /// In en, this message translates to:
  /// **'Remaining'**
  String get groceryRemaining;

  /// No description provided for @groceryCurrency.
  ///
  /// In en, this message translates to:
  /// **'₹'**
  String get groceryCurrency;

  /// No description provided for @groceryBudgetFriendlyTitle.
  ///
  /// In en, this message translates to:
  /// **'Budget-Friendly Alternatives'**
  String get groceryBudgetFriendlyTitle;

  /// No description provided for @groceryBudgetExceedsMessage.
  ///
  /// In en, this message translates to:
  /// **'Your current list exceeds budget by {amount}. Consider these alternatives:'**
  String groceryBudgetExceedsMessage(String amount);

  /// No description provided for @grocerySaveAmount.
  ///
  /// In en, this message translates to:
  /// **'Save {amount}'**
  String grocerySaveAmount(String amount);

  /// No description provided for @groceryTotal.
  ///
  /// In en, this message translates to:
  /// **'Total: {amount}'**
  String groceryTotal(String amount);

  /// No description provided for @groceryShareGeneratedBy.
  ///
  /// In en, this message translates to:
  /// **'Generated by {appName} on {date}'**
  String groceryShareGeneratedBy(String appName, String date);

  /// No description provided for @profilePersonalDetails.
  ///
  /// In en, this message translates to:
  /// **'Personal Details'**
  String get profilePersonalDetails;

  /// No description provided for @profileHealthConditions.
  ///
  /// In en, this message translates to:
  /// **'Health Conditions'**
  String get profileHealthConditions;

  /// No description provided for @profileDietaryPreferences.
  ///
  /// In en, this message translates to:
  /// **'Dietary Preferences'**
  String get profileDietaryPreferences;

  /// No description provided for @profileAllergies.
  ///
  /// In en, this message translates to:
  /// **'Allergies'**
  String get profileAllergies;

  /// No description provided for @profileBudget.
  ///
  /// In en, this message translates to:
  /// **'Budget'**
  String get profileBudget;

  /// No description provided for @profileBudgetTitle.
  ///
  /// In en, this message translates to:
  /// **'Monthly Food Budget'**
  String get profileBudgetTitle;

  /// No description provided for @profileAge.
  ///
  /// In en, this message translates to:
  /// **'Age'**
  String get profileAge;

  /// No description provided for @profileWeight.
  ///
  /// In en, this message translates to:
  /// **'Weight'**
  String get profileWeight;

  /// No description provided for @profileGender.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get profileGender;

  /// No description provided for @profileGenderMale.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get profileGenderMale;

  /// No description provided for @profileGenderFemale.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get profileGenderFemale;

  /// No description provided for @profileHealthDiabetes.
  ///
  /// In en, this message translates to:
  /// **'Diabetes'**
  String get profileHealthDiabetes;

  /// No description provided for @profileHealthPCOS.
  ///
  /// In en, this message translates to:
  /// **'PCOS'**
  String get profileHealthPCOS;

  /// No description provided for @profileHealthHypertension.
  ///
  /// In en, this message translates to:
  /// **'Hypertension'**
  String get profileHealthHypertension;

  /// No description provided for @profileHbA1c.
  ///
  /// In en, this message translates to:
  /// **'HbA1c Level'**
  String get profileHbA1c;

  /// No description provided for @profileDietVegetarian.
  ///
  /// In en, this message translates to:
  /// **'Vegetarian'**
  String get profileDietVegetarian;

  /// No description provided for @profileDietVegan.
  ///
  /// In en, this message translates to:
  /// **'Vegan'**
  String get profileDietVegan;

  /// No description provided for @profileMonthlyBudgetLabel.
  ///
  /// In en, this message translates to:
  /// **'Enter Monthly Budget'**
  String get profileMonthlyBudgetLabel;

  /// No description provided for @profileUnitKg.
  ///
  /// In en, this message translates to:
  /// **'{value} kg'**
  String profileUnitKg(double value);

  /// No description provided for @profileUnitYears.
  ///
  /// In en, this message translates to:
  /// **'{value} years'**
  String profileUnitYears(int value);

  /// No description provided for @dashboardModalMarkComplete.
  ///
  /// In en, this message translates to:
  /// **'Mark Complete'**
  String get dashboardModalMarkComplete;

  /// No description provided for @dashboardModalSkipMeal.
  ///
  /// In en, this message translates to:
  /// **'Skip Meal'**
  String get dashboardModalSkipMeal;

  /// No description provided for @dashboardModalRequestAlternative.
  ///
  /// In en, this message translates to:
  /// **'Request Alternative'**
  String get dashboardModalRequestAlternative;

  /// No description provided for @profileUnitDays.
  ///
  /// In en, this message translates to:
  /// **'{value} days'**
  String profileUnitDays(int value);

  /// No description provided for @groceryBudgetOverview.
  ///
  /// In en, this message translates to:
  /// **'Budget Overview'**
  String get groceryBudgetOverview;

  /// No description provided for @groceryUsedPercent.
  ///
  /// In en, this message translates to:
  /// **'{percent}% Used'**
  String groceryUsedPercent(int percent);

  /// No description provided for @groceryAvgDay.
  ///
  /// In en, this message translates to:
  /// **'Avg/Day'**
  String get groceryAvgDay;

  /// No description provided for @groceryDaysLeftLabel.
  ///
  /// In en, this message translates to:
  /// **'Days Left'**
  String get groceryDaysLeftLabel;

  /// No description provided for @mockRecentMeal1Name.
  ///
  /// In en, this message translates to:
  /// **'Brown Rice with Dal Tadka'**
  String get mockRecentMeal1Name;

  /// No description provided for @mockRecentMeal1Explanation.
  ///
  /// In en, this message translates to:
  /// **'High in protein and fiber, helps manage blood sugar levels. Dal provides essential amino acids for PCOS management.'**
  String get mockRecentMeal1Explanation;

  /// No description provided for @mockRecentMeal1Timestamp.
  ///
  /// In en, this message translates to:
  /// **'2 hours ago'**
  String get mockRecentMeal1Timestamp;

  /// No description provided for @mockRecentMeal2Name.
  ///
  /// In en, this message translates to:
  /// **'Oats Upma'**
  String get mockRecentMeal2Name;

  /// No description provided for @mockRecentMeal2Explanation.
  ///
  /// In en, this message translates to:
  /// **'Low glycemic index breakfast keeps you full longer and prevents sugar spikes. Rich in beta-glucan for heart health.'**
  String get mockRecentMeal2Explanation;

  /// No description provided for @mockRecentMeal2Timestamp.
  ///
  /// In en, this message translates to:
  /// **'5 hours ago'**
  String get mockRecentMeal2Timestamp;

  /// No description provided for @mockSeasonalPick1Name.
  ///
  /// In en, this message translates to:
  /// **'Winter Citrus'**
  String get mockSeasonalPick1Name;

  /// No description provided for @mockSeasonalPick1Type.
  ///
  /// In en, this message translates to:
  /// **'Fruit'**
  String get mockSeasonalPick1Type;

  /// No description provided for @mockSeasonalPick1Tag.
  ///
  /// In en, this message translates to:
  /// **'Winter citrus'**
  String get mockSeasonalPick1Tag;

  /// No description provided for @mockSeasonalPick1Descriptor.
  ///
  /// In en, this message translates to:
  /// **'Seasonal in Feb around Bangalore'**
  String get mockSeasonalPick1Descriptor;

  /// No description provided for @mockSeasonalPick2Name.
  ///
  /// In en, this message translates to:
  /// **'Fresh Spinach'**
  String get mockSeasonalPick2Name;

  /// No description provided for @mockSeasonalPick2Type.
  ///
  /// In en, this message translates to:
  /// **'Vegetable'**
  String get mockSeasonalPick2Type;

  /// No description provided for @mockSeasonalPick2Tag.
  ///
  /// In en, this message translates to:
  /// **'Winter leafy green'**
  String get mockSeasonalPick2Tag;

  /// No description provided for @mockSeasonalPick2Descriptor.
  ///
  /// In en, this message translates to:
  /// **'Tender bunches in Feb'**
  String get mockSeasonalPick2Descriptor;

  /// No description provided for @seasonalFruit.
  ///
  /// In en, this message translates to:
  /// **'Fruit'**
  String get seasonalFruit;

  /// No description provided for @seasonalVegetable.
  ///
  /// In en, this message translates to:
  /// **'Vegetable'**
  String get seasonalVegetable;

  /// No description provided for @seasonalTagPeakSeason.
  ///
  /// In en, this message translates to:
  /// **'Peak season'**
  String get seasonalTagPeakSeason;

  /// No description provided for @seasonalDescriptorPeakFeb.
  ///
  /// In en, this message translates to:
  /// **'Peak availability in late Feb'**
  String get seasonalDescriptorPeakFeb;

  /// No description provided for @seasonalTagLocallyAbundant.
  ///
  /// In en, this message translates to:
  /// **'Locally abundant'**
  String get seasonalTagLocallyAbundant;

  /// No description provided for @seasonalDescriptorCityMarkets.
  ///
  /// In en, this message translates to:
  /// **'Steady supply in city markets'**
  String get seasonalDescriptorCityMarkets;

  /// No description provided for @groceryWeeklyBudget.
  ///
  /// In en, this message translates to:
  /// **'Weekly Budget'**
  String get groceryWeeklyBudget;

  /// No description provided for @groceryOverBudget.
  ///
  /// In en, this message translates to:
  /// **'Over Budget'**
  String get groceryOverBudget;

  /// No description provided for @groceryEstimated.
  ///
  /// In en, this message translates to:
  /// **'estimated'**
  String get groceryEstimated;

  /// No description provided for @grocerySaveMore.
  ///
  /// In en, this message translates to:
  /// **'Save More'**
  String get grocerySaveMore;

  /// No description provided for @groceryPurchasedStatus.
  ///
  /// In en, this message translates to:
  /// **'{count}/{total} purchased'**
  String groceryPurchasedStatus(int count, int total);

  /// No description provided for @groceryEditQuantity.
  ///
  /// In en, this message translates to:
  /// **'Edit Quantity'**
  String get groceryEditQuantity;

  /// No description provided for @groceryFindAlternatives.
  ///
  /// In en, this message translates to:
  /// **'Find Alternatives'**
  String get groceryFindAlternatives;

  /// No description provided for @groceryAddNotes.
  ///
  /// In en, this message translates to:
  /// **'Add Notes'**
  String get groceryAddNotes;

  /// No description provided for @groceryPantry.
  ///
  /// In en, this message translates to:
  /// **'Pantry'**
  String get groceryPantry;

  /// No description provided for @groceryRemove.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get groceryRemove;

  /// No description provided for @groceryAlternativesTitle.
  ///
  /// In en, this message translates to:
  /// **'Alternatives for {name}'**
  String groceryAlternativesTitle(String name);

  /// No description provided for @groceryNoAlternatives.
  ///
  /// In en, this message translates to:
  /// **'No alternatives available'**
  String get groceryNoAlternatives;

  /// No description provided for @grocerySwitchedTo.
  ///
  /// In en, this message translates to:
  /// **'Switched to {name}'**
  String grocerySwitchedTo(String name);

  /// No description provided for @groceryClose.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get groceryClose;

  /// No description provided for @groceryCategoryProduce.
  ///
  /// In en, this message translates to:
  /// **'Produce'**
  String get groceryCategoryProduce;

  /// No description provided for @groceryCategoryMeat.
  ///
  /// In en, this message translates to:
  /// **'Meat'**
  String get groceryCategoryMeat;

  /// No description provided for @groceryCategoryBakery.
  ///
  /// In en, this message translates to:
  /// **'Bakery'**
  String get groceryCategoryBakery;

  /// No description provided for @groceryCategoryFrozen.
  ///
  /// In en, this message translates to:
  /// **'Frozen'**
  String get groceryCategoryFrozen;

  /// No description provided for @groceryCategoryBeverages.
  ///
  /// In en, this message translates to:
  /// **'Beverages'**
  String get groceryCategoryBeverages;

  /// No description provided for @mockGroceryOnions.
  ///
  /// In en, this message translates to:
  /// **'Onions'**
  String get mockGroceryOnions;

  /// No description provided for @mockGroceryTomatoes.
  ///
  /// In en, this message translates to:
  /// **'Tomatoes'**
  String get mockGroceryTomatoes;

  /// No description provided for @mockGroceryBasmatiRice.
  ///
  /// In en, this message translates to:
  /// **'Basmati Rice'**
  String get mockGroceryBasmatiRice;

  /// No description provided for @mockGroceryWholeWheatFlour.
  ///
  /// In en, this message translates to:
  /// **'Whole Wheat Flour'**
  String get mockGroceryWholeWheatFlour;

  /// No description provided for @mockGroceryTurmericPowder.
  ///
  /// In en, this message translates to:
  /// **'Turmeric Powder'**
  String get mockGroceryTurmericPowder;

  /// No description provided for @mockGroceryCuminSeeds.
  ///
  /// In en, this message translates to:
  /// **'Cumin Seeds'**
  String get mockGroceryCuminSeeds;

  /// No description provided for @mockGroceryGaramMasala.
  ///
  /// In en, this message translates to:
  /// **'Garam Masala'**
  String get mockGroceryGaramMasala;

  /// No description provided for @mockGroceryMilk.
  ///
  /// In en, this message translates to:
  /// **'Milk'**
  String get mockGroceryMilk;

  /// No description provided for @mockGroceryYogurt.
  ///
  /// In en, this message translates to:
  /// **'Yogurt'**
  String get mockGroceryYogurt;

  /// No description provided for @mockGroceryPaneer.
  ///
  /// In en, this message translates to:
  /// **'Paneer'**
  String get mockGroceryPaneer;

  /// No description provided for @profilePersonalSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Help us personalize your meal plans with basic information'**
  String get profilePersonalSubtitle;

  /// No description provided for @profileAgeLabel.
  ///
  /// In en, this message translates to:
  /// **'Age *'**
  String get profileAgeLabel;

  /// No description provided for @profileAgeHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your age'**
  String get profileAgeHint;

  /// No description provided for @profileAgeRequired.
  ///
  /// In en, this message translates to:
  /// **'Age is required'**
  String get profileAgeRequired;

  /// No description provided for @profileAgeInvalid.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid age (18-100)'**
  String get profileAgeInvalid;

  /// No description provided for @profileGenderLabel.
  ///
  /// In en, this message translates to:
  /// **'Gender *'**
  String get profileGenderLabel;

  /// No description provided for @profileGenderOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get profileGenderOther;

  /// No description provided for @profileWeightLabel.
  ///
  /// In en, this message translates to:
  /// **'Weight (kg) *'**
  String get profileWeightLabel;

  /// No description provided for @profileWeightHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your weight'**
  String get profileWeightHint;

  /// No description provided for @profileWeightRequired.
  ///
  /// In en, this message translates to:
  /// **'Weight is required'**
  String get profileWeightRequired;

  /// No description provided for @profileWeightInvalid.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid weight (30-200 kg)'**
  String get profileWeightInvalid;

  /// No description provided for @profileWhyNeedInfo.
  ///
  /// In en, this message translates to:
  /// **'Why do we need this information?'**
  String get profileWhyNeedInfo;

  /// No description provided for @profileUsageTitle.
  ///
  /// In en, this message translates to:
  /// **'Personal Information Usage'**
  String get profileUsageTitle;

  /// No description provided for @profileUsageAge.
  ///
  /// In en, this message translates to:
  /// **'Age helps us calculate your daily caloric needs and nutritional requirements'**
  String get profileUsageAge;

  /// No description provided for @profileUsageGender.
  ///
  /// In en, this message translates to:
  /// **'Gender influences metabolic rate and specific nutrient needs'**
  String get profileUsageGender;

  /// No description provided for @profileUsageWeight.
  ///
  /// In en, this message translates to:
  /// **'Weight is essential for portion control and personalized meal planning'**
  String get profileUsageWeight;

  /// No description provided for @profileUsageSecurity.
  ///
  /// In en, this message translates to:
  /// **'All data is encrypted and used only for your meal recommendations'**
  String get profileUsageSecurity;

  /// No description provided for @profileHealthSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Select any health conditions you manage (optional)'**
  String get profileHealthSubtitle;

  /// No description provided for @profileHealthDiabetesDesc.
  ///
  /// In en, this message translates to:
  /// **'Type 1 or Type 2 Diabetes'**
  String get profileHealthDiabetesDesc;

  /// No description provided for @profileHealthPCOSDesc.
  ///
  /// In en, this message translates to:
  /// **'Polycystic Ovary Syndrome'**
  String get profileHealthPCOSDesc;

  /// No description provided for @profileHealthHypertensionDesc.
  ///
  /// In en, this message translates to:
  /// **'High Blood Pressure'**
  String get profileHealthHypertensionDesc;

  /// No description provided for @profileHealthAnemia.
  ///
  /// In en, this message translates to:
  /// **'Anemia'**
  String get profileHealthAnemia;

  /// No description provided for @profileHealthAnemiaDesc.
  ///
  /// In en, this message translates to:
  /// **'Iron Deficiency'**
  String get profileHealthAnemiaDesc;

  /// No description provided for @profileHealthThyroid.
  ///
  /// In en, this message translates to:
  /// **'Thyroid'**
  String get profileHealthThyroid;

  /// No description provided for @profileHealthThyroidDesc.
  ///
  /// In en, this message translates to:
  /// **'Thyroid Disorders'**
  String get profileHealthThyroidDesc;

  /// No description provided for @profileHealthHeart.
  ///
  /// In en, this message translates to:
  /// **'Heart Disease'**
  String get profileHealthHeart;

  /// No description provided for @profileHealthHeartDesc.
  ///
  /// In en, this message translates to:
  /// **'Cardiovascular Conditions'**
  String get profileHealthHeartDesc;

  /// No description provided for @profileHbA1cLabel.
  ///
  /// In en, this message translates to:
  /// **'HbA1c Level (Optional)'**
  String get profileHbA1cLabel;

  /// No description provided for @profileHbA1cHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your HbA1c level (e.g., 6.5)'**
  String get profileHbA1cHint;

  /// No description provided for @profileHbA1cInfo.
  ///
  /// In en, this message translates to:
  /// **'This helps us provide more accurate meal recommendations for diabetes management'**
  String get profileHbA1cInfo;

  /// No description provided for @profileSafetyTitle.
  ///
  /// In en, this message translates to:
  /// **'Medical Nutrition Safety'**
  String get profileSafetyTitle;

  /// No description provided for @profileSafetyCondition.
  ///
  /// In en, this message translates to:
  /// **'Health conditions affect your nutritional requirements and food restrictions'**
  String get profileSafetyCondition;

  /// No description provided for @profileSafetyCompliance.
  ///
  /// In en, this message translates to:
  /// **'We ensure meal plans comply with medical nutrition guidelines'**
  String get profileSafetyCompliance;

  /// No description provided for @profileSafetyPrevention.
  ///
  /// In en, this message translates to:
  /// **'Prevents suggesting foods that may worsen your condition'**
  String get profileSafetyPrevention;

  /// No description provided for @profileSafetyBalance.
  ///
  /// In en, this message translates to:
  /// **'Helps balance nutrients specific to your health needs'**
  String get profileSafetyBalance;

  /// No description provided for @profileSafetyGuidelines.
  ///
  /// In en, this message translates to:
  /// **'All recommendations follow Indian dietary guidelines for lifestyle diseases'**
  String get profileSafetyGuidelines;

  /// No description provided for @profileDietSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Select your dietary preferences (at least one required)'**
  String get profileDietSubtitle;

  /// No description provided for @profileDietVeg.
  ///
  /// In en, this message translates to:
  /// **'Vegetarian'**
  String get profileDietVeg;

  /// No description provided for @profileDietVegDesc.
  ///
  /// In en, this message translates to:
  /// **'No meat, fish, or poultry'**
  String get profileDietVegDesc;

  /// No description provided for @profileDietVeganDesc.
  ///
  /// In en, this message translates to:
  /// **'No animal products'**
  String get profileDietVeganDesc;

  /// No description provided for @profileDietJain.
  ///
  /// In en, this message translates to:
  /// **'Jain'**
  String get profileDietJain;

  /// No description provided for @profileDietJainDesc.
  ///
  /// In en, this message translates to:
  /// **'No root vegetables'**
  String get profileDietJainDesc;

  /// No description provided for @profileDietEgg.
  ///
  /// In en, this message translates to:
  /// **'Eggetarian'**
  String get profileDietEgg;

  /// No description provided for @profileDietEggDesc.
  ///
  /// In en, this message translates to:
  /// **'Vegetarian with eggs'**
  String get profileDietEggDesc;

  /// No description provided for @profileDietNonVeg.
  ///
  /// In en, this message translates to:
  /// **'Non-Vegetarian'**
  String get profileDietNonVeg;

  /// No description provided for @profileDietNonVegDesc.
  ///
  /// In en, this message translates to:
  /// **'Includes all food types'**
  String get profileDietNonVegDesc;

  /// No description provided for @profileDietPescatarian.
  ///
  /// In en, this message translates to:
  /// **'Pescatarian'**
  String get profileDietPescatarian;

  /// No description provided for @profileDietPescatarianDesc.
  ///
  /// In en, this message translates to:
  /// **'Vegetarian with fish'**
  String get profileDietPescatarianDesc;

  /// No description provided for @profileDietMultipleInfo.
  ///
  /// In en, this message translates to:
  /// **'You can select multiple preferences. For example, Vegetarian + Jain or Eggetarian + Pescatarian.'**
  String get profileDietMultipleInfo;

  /// No description provided for @profileDietImportanceTitle.
  ///
  /// In en, this message translates to:
  /// **'Dietary Preference Importance'**
  String get profileDietImportanceTitle;

  /// No description provided for @profileDietImportanceRespect.
  ///
  /// In en, this message translates to:
  /// **'Ensures all meal suggestions respect your dietary choices'**
  String get profileDietImportanceRespect;

  /// No description provided for @profileDietImportanceFilter.
  ///
  /// In en, this message translates to:
  /// **'Filters out ingredients that don\'t match your preferences'**
  String get profileDietImportanceFilter;

  /// No description provided for @profileDietImportanceCultural.
  ///
  /// In en, this message translates to:
  /// **'Provides culturally appropriate Indian meal options'**
  String get profileDietImportanceCultural;

  /// No description provided for @profileDietImportanceBalance.
  ///
  /// In en, this message translates to:
  /// **'Helps maintain nutritional balance within your dietary framework'**
  String get profileDietImportanceBalance;

  /// No description provided for @profileDietImportanceReligious.
  ///
  /// In en, this message translates to:
  /// **'Supports religious and ethical food choices'**
  String get profileDietImportanceReligious;

  /// No description provided for @profileBudgetSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Set your monthly food budget for smart meal planning'**
  String get profileBudgetSubtitle;

  /// No description provided for @profileBudgetAmountLabel.
  ///
  /// In en, this message translates to:
  /// **'Enter Budget Amount *'**
  String get profileBudgetAmountLabel;

  /// No description provided for @profileBudgetAmountHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your monthly food budget'**
  String get profileBudgetAmountHint;

  /// No description provided for @profileBudgetAmountRequired.
  ///
  /// In en, this message translates to:
  /// **'Budget is required'**
  String get profileBudgetAmountRequired;

  /// No description provided for @profileBudgetAmountMin.
  ///
  /// In en, this message translates to:
  /// **'Minimum budget is ₹1,000'**
  String get profileBudgetAmountMin;

  /// No description provided for @profileBudgetAmountMax.
  ///
  /// In en, this message translates to:
  /// **'Maximum budget is ₹1,00,000'**
  String get profileBudgetAmountMax;

  /// No description provided for @profileBudgetQuickSelect.
  ///
  /// In en, this message translates to:
  /// **'Quick Select'**
  String get profileBudgetQuickSelect;

  /// No description provided for @profileBudgetBreakdownTitle.
  ///
  /// In en, this message translates to:
  /// **'Budget Breakdown'**
  String get profileBudgetBreakdownTitle;

  /// No description provided for @profileBudgetDaily.
  ///
  /// In en, this message translates to:
  /// **'Daily Budget'**
  String get profileBudgetDaily;

  /// No description provided for @profileBudgetWeekly.
  ///
  /// In en, this message translates to:
  /// **'Weekly Budget'**
  String get profileBudgetWeekly;

  /// No description provided for @profileBudgetPerMeal.
  ///
  /// In en, this message translates to:
  /// **'Per Meal (approx.)'**
  String get profileBudgetPerMeal;

  /// No description provided for @profileBudgetSavingsInfo.
  ///
  /// In en, this message translates to:
  /// **'We\'ll suggest budget-friendly ingredient substitutions and help you track spending throughout the month.'**
  String get profileBudgetSavingsInfo;

  /// No description provided for @profileBudgetAwareTitle.
  ///
  /// In en, this message translates to:
  /// **'Budget-Aware Planning'**
  String get profileBudgetAwareTitle;

  /// No description provided for @profileBudgetAwareSuggest.
  ///
  /// In en, this message translates to:
  /// **'Suggests meals that fit within your monthly budget'**
  String get profileBudgetAwareSuggest;

  /// No description provided for @profileBudgetAwareCost.
  ///
  /// In en, this message translates to:
  /// **'Provides cost-effective ingredient alternatives'**
  String get profileBudgetAwareCost;

  /// No description provided for @profileBudgetAwareTrack.
  ///
  /// In en, this message translates to:
  /// **'Helps track grocery spending throughout the month'**
  String get profileBudgetAwareTrack;

  /// No description provided for @profileBudgetAwareOptimize.
  ///
  /// In en, this message translates to:
  /// **'Optimizes meal plans for maximum nutrition at minimum cost'**
  String get profileBudgetAwareOptimize;

  /// No description provided for @profileBudgetAwarePrevent.
  ///
  /// In en, this message translates to:
  /// **'Prevents overspending on groceries'**
  String get profileBudgetAwarePrevent;

  /// No description provided for @profileAllergyTitle.
  ///
  /// In en, this message translates to:
  /// **'Allergies & Intolerances'**
  String get profileAllergyTitle;

  /// No description provided for @profileAllergySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Select any food allergies or intolerances (optional)'**
  String get profileAllergySubtitle;

  /// No description provided for @profileAllergySearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search or add custom allergy'**
  String get profileAllergySearchHint;

  /// No description provided for @profileAllergySelected.
  ///
  /// In en, this message translates to:
  /// **'Selected Allergies'**
  String get profileAllergySelected;

  /// No description provided for @profileAllergyCommon.
  ///
  /// In en, this message translates to:
  /// **'Common Allergies'**
  String get profileAllergyCommon;

  /// No description provided for @profileAllergyWarning.
  ///
  /// In en, this message translates to:
  /// **'All meal plans will automatically exclude ingredients you\'re allergic to. Please consult your doctor for severe allergies.'**
  String get profileAllergyWarning;

  /// No description provided for @profileAllergySafetyTitle.
  ///
  /// In en, this message translates to:
  /// **'Allergy Safety'**
  String get profileAllergySafetyTitle;

  /// No description provided for @profileAllergySafetyPrevents.
  ///
  /// In en, this message translates to:
  /// **'Prevents suggesting meals with allergens that could harm you'**
  String get profileAllergySafetyPrevents;

  /// No description provided for @profileAllergySafetyFilters.
  ///
  /// In en, this message translates to:
  /// **'Automatically filters out unsafe ingredients from all recommendations'**
  String get profileAllergySafetyFilters;

  /// No description provided for @profileAllergySafetySubstitutions.
  ///
  /// In en, this message translates to:
  /// **'Provides safe ingredient substitutions in meal plans'**
  String get profileAllergySafetySubstitutions;

  /// No description provided for @profileAllergySafetyExclude.
  ///
  /// In en, this message translates to:
  /// **'Ensures grocery lists exclude allergenic items'**
  String get profileAllergySafetyExclude;

  /// No description provided for @profileAllergySafetyCritical.
  ///
  /// In en, this message translates to:
  /// **'Critical for your health and safety'**
  String get profileAllergySafetyCritical;

  /// No description provided for @allergyPeanuts.
  ///
  /// In en, this message translates to:
  /// **'Peanuts'**
  String get allergyPeanuts;

  /// No description provided for @allergyTreeNuts.
  ///
  /// In en, this message translates to:
  /// **'Tree Nuts'**
  String get allergyTreeNuts;

  /// No description provided for @allergyMilk.
  ///
  /// In en, this message translates to:
  /// **'Milk'**
  String get allergyMilk;

  /// No description provided for @allergyEggs.
  ///
  /// In en, this message translates to:
  /// **'Eggs'**
  String get allergyEggs;

  /// No description provided for @allergyWheat.
  ///
  /// In en, this message translates to:
  /// **'Wheat'**
  String get allergyWheat;

  /// No description provided for @allergySoy.
  ///
  /// In en, this message translates to:
  /// **'Soy'**
  String get allergySoy;

  /// No description provided for @allergyFish.
  ///
  /// In en, this message translates to:
  /// **'Fish'**
  String get allergyFish;

  /// No description provided for @allergyShellfish.
  ///
  /// In en, this message translates to:
  /// **'Shellfish'**
  String get allergyShellfish;

  /// No description provided for @allergySesame.
  ///
  /// In en, this message translates to:
  /// **'Sesame'**
  String get allergySesame;

  /// No description provided for @allergyMustard.
  ///
  /// In en, this message translates to:
  /// **'Mustard'**
  String get allergyMustard;

  /// No description provided for @allergyGluten.
  ///
  /// In en, this message translates to:
  /// **'Gluten'**
  String get allergyGluten;

  /// No description provided for @allergyLactose.
  ///
  /// In en, this message translates to:
  /// **'Lactose'**
  String get allergyLactose;

  /// No description provided for @allergyCorn.
  ///
  /// In en, this message translates to:
  /// **'Corn'**
  String get allergyCorn;

  /// No description provided for @allergyGarlic.
  ///
  /// In en, this message translates to:
  /// **'Garlic'**
  String get allergyGarlic;

  /// No description provided for @allergyOnion.
  ///
  /// In en, this message translates to:
  /// **'Onion'**
  String get allergyOnion;

  /// No description provided for @allergyTomato.
  ///
  /// In en, this message translates to:
  /// **'Tomato'**
  String get allergyTomato;

  /// No description provided for @allergyCitrus.
  ///
  /// In en, this message translates to:
  /// **'Citrus Fruits'**
  String get allergyCitrus;

  /// No description provided for @allergyStrawberries.
  ///
  /// In en, this message translates to:
  /// **'Strawberries'**
  String get allergyStrawberries;

  /// No description provided for @allergyChocolate.
  ///
  /// In en, this message translates to:
  /// **'Chocolate'**
  String get allergyChocolate;

  /// No description provided for @allergyCaffeine.
  ///
  /// In en, this message translates to:
  /// **'Caffeine'**
  String get allergyCaffeine;

  /// No description provided for @mockGroceryGinger.
  ///
  /// In en, this message translates to:
  /// **'Ginger'**
  String get mockGroceryGinger;

  /// No description provided for @mockGroceryGreenChillies.
  ///
  /// In en, this message translates to:
  /// **'Green Chillies'**
  String get mockGroceryGreenChillies;

  /// No description provided for @mockGroceryCorianderLeaves.
  ///
  /// In en, this message translates to:
  /// **'Coriander Leaves'**
  String get mockGroceryCorianderLeaves;

  /// No description provided for @mockGroceryReasonFreq.
  ///
  /// In en, this message translates to:
  /// **'Frequently purchased'**
  String get mockGroceryReasonFreq;

  /// No description provided for @mockGroceryReasonOften.
  ///
  /// In en, this message translates to:
  /// **'Often bought with {item}'**
  String mockGroceryReasonOften(String item);

  /// No description provided for @mockGroceryReasonPlan.
  ///
  /// In en, this message translates to:
  /// **'Complements your meal plan'**
  String get mockGroceryReasonPlan;

  /// No description provided for @loadingGeneral.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loadingGeneral;

  /// No description provided for @groceryExceedsBudgetInfo.
  ///
  /// In en, this message translates to:
  /// **'Your current list exceeds budget by {amount}. Consider these alternatives:'**
  String groceryExceedsBudgetInfo(String amount);

  /// No description provided for @grocerySubstitutionPrompt.
  ///
  /// In en, this message translates to:
  /// **'Switch {item1} to {item2}?'**
  String grocerySubstitutionPrompt(String item1, String item2);

  /// No description provided for @groceryImpactMinimal.
  ///
  /// In en, this message translates to:
  /// **'Impact on taste is minimal'**
  String get groceryImpactMinimal;

  /// No description provided for @groceryCategoryPantry.
  ///
  /// In en, this message translates to:
  /// **'Pantry Staples'**
  String get groceryCategoryPantry;

  /// No description provided for @groceryItemBrownRice.
  ///
  /// In en, this message translates to:
  /// **'Brown Rice'**
  String get groceryItemBrownRice;

  /// No description provided for @groceryItemMoongDal.
  ///
  /// In en, this message translates to:
  /// **'Moong Dal'**
  String get groceryItemMoongDal;

  /// No description provided for @groceryItemSpinach.
  ///
  /// In en, this message translates to:
  /// **'Spinach'**
  String get groceryItemSpinach;

  /// No description provided for @groceryItemCarrots.
  ///
  /// In en, this message translates to:
  /// **'Carrots'**
  String get groceryItemCarrots;

  /// No description provided for @groceryBudgetFriendlyAlts.
  ///
  /// In en, this message translates to:
  /// **'Budget-Friendly Alternatives'**
  String get groceryBudgetFriendlyAlts;

  /// No description provided for @mealPlanTitle.
  ///
  /// In en, this message translates to:
  /// **'Daily Meal Plan'**
  String get mealPlanTitle;

  /// No description provided for @mealPlanNoPlan.
  ///
  /// In en, this message translates to:
  /// **'No meal plan available'**
  String get mealPlanNoPlan;

  /// No description provided for @mealPlanBreakfast.
  ///
  /// In en, this message translates to:
  /// **'Breakfast'**
  String get mealPlanBreakfast;

  /// No description provided for @mealPlanLunch.
  ///
  /// In en, this message translates to:
  /// **'Lunch'**
  String get mealPlanLunch;

  /// No description provided for @mealPlanDinner.
  ///
  /// In en, this message translates to:
  /// **'Dinner'**
  String get mealPlanDinner;

  /// No description provided for @mealPlanSnacks.
  ///
  /// In en, this message translates to:
  /// **'Snacks'**
  String get mealPlanSnacks;

  /// No description provided for @mealPlanToday.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get mealPlanToday;

  /// No description provided for @mealPlanPrevDay.
  ///
  /// In en, this message translates to:
  /// **'Previous day'**
  String get mealPlanPrevDay;

  /// No description provided for @mealPlanNextDay.
  ///
  /// In en, this message translates to:
  /// **'Next day'**
  String get mealPlanNextDay;

  /// No description provided for @mealPlanWhyMeal.
  ///
  /// In en, this message translates to:
  /// **'Why this meal?'**
  String get mealPlanWhyMeal;

  /// No description provided for @mealPlanCookingSteps.
  ///
  /// In en, this message translates to:
  /// **'Cooking Steps'**
  String get mealPlanCookingSteps;

  /// No description provided for @mealPlanListenInstructions.
  ///
  /// In en, this message translates to:
  /// **'Listen to instructions'**
  String get mealPlanListenInstructions;

  /// No description provided for @mealPlanIngredients.
  ///
  /// In en, this message translates to:
  /// **'Ingredients'**
  String get mealPlanIngredients;

  /// No description provided for @mealPlanAddCount.
  ///
  /// In en, this message translates to:
  /// **'Add ({count})'**
  String mealPlanAddCount(int count);

  /// No description provided for @mealPlanCanSubstitute.
  ///
  /// In en, this message translates to:
  /// **'Can substitute: {item}'**
  String mealPlanCanSubstitute(String item);

  /// No description provided for @mealPlanLongPressSelect.
  ///
  /// In en, this message translates to:
  /// **'Long press any ingredient to select for grocery list'**
  String get mealPlanLongPressSelect;

  /// No description provided for @mealPlanPrepTime.
  ///
  /// In en, this message translates to:
  /// **'Prep Time'**
  String get mealPlanPrepTime;

  /// No description provided for @mealPlanServings.
  ///
  /// In en, this message translates to:
  /// **'Servings'**
  String get mealPlanServings;

  /// No description provided for @mealPlanCalories.
  ///
  /// In en, this message translates to:
  /// **'Calories'**
  String get mealPlanCalories;

  /// No description provided for @mealPlanKcalValue.
  ///
  /// In en, this message translates to:
  /// **'{value} kcal'**
  String mealPlanKcalValue(String value);

  /// No description provided for @mealPlanFeedbackTitle.
  ///
  /// In en, this message translates to:
  /// **'Meal Feedback'**
  String get mealPlanFeedbackTitle;

  /// No description provided for @mealPlanEaten.
  ///
  /// In en, this message translates to:
  /// **'Eaten'**
  String get mealPlanEaten;

  /// No description provided for @mealPlanPartial.
  ///
  /// In en, this message translates to:
  /// **'Partial'**
  String get mealPlanPartial;

  /// No description provided for @mealPlanSkipped.
  ///
  /// In en, this message translates to:
  /// **'Skipped'**
  String get mealPlanSkipped;

  /// No description provided for @mealPlanAdaptFeedback.
  ///
  /// In en, this message translates to:
  /// **'Plan will adapt based on your feedback'**
  String get mealPlanAdaptFeedback;

  /// No description provided for @mealPlanKcal.
  ///
  /// In en, this message translates to:
  /// **'{value} kcal'**
  String mealPlanKcal(String value);

  /// No description provided for @mealPlanRupee.
  ///
  /// In en, this message translates to:
  /// **'₹{value}'**
  String mealPlanRupee(String value);

  /// No description provided for @mealPlanBudgetWithin.
  ///
  /// In en, this message translates to:
  /// **'Within budget - Great job!'**
  String get mealPlanBudgetWithin;

  /// No description provided for @mealPlanBudgetExceeded.
  ///
  /// In en, this message translates to:
  /// **'Budget exceeded by ₹{amount}'**
  String mealPlanBudgetExceeded(String amount);

  /// No description provided for @mealPlanSummaryTitle.
  ///
  /// In en, this message translates to:
  /// **'Daily Summary'**
  String get mealPlanSummaryTitle;

  /// No description provided for @mealPlanTotalCalories.
  ///
  /// In en, this message translates to:
  /// **'Total Calories'**
  String get mealPlanTotalCalories;

  /// No description provided for @mealPlanTotalCost.
  ///
  /// In en, this message translates to:
  /// **'Total Cost'**
  String get mealPlanTotalCost;

  /// No description provided for @mealPlanAISelectedHeader.
  ///
  /// In en, this message translates to:
  /// **'Our AI selected these meals based on:'**
  String get mealPlanAISelectedHeader;

  /// No description provided for @mealPlanWhyToday.
  ///
  /// In en, this message translates to:
  /// **'Why today\'s meals'**
  String get mealPlanWhyToday;

  /// No description provided for @mealPlanReason1.
  ///
  /// In en, this message translates to:
  /// **'High-protein breakfast supports your PCOS management and keeps you full longer'**
  String get mealPlanReason1;

  /// No description provided for @mealPlanReason2.
  ///
  /// In en, this message translates to:
  /// **'Lunch includes low-GI foods suitable for diabetes control with balanced nutrients'**
  String get mealPlanReason2;

  /// No description provided for @mealPlanReason3.
  ///
  /// In en, this message translates to:
  /// **'Dinner is light yet nutritious, promoting better sleep and digestion'**
  String get mealPlanReason3;

  /// No description provided for @mealPlanReason4.
  ///
  /// In en, this message translates to:
  /// **'All meals stay within your daily budget while meeting nutritional goals'**
  String get mealPlanReason4;

  /// No description provided for @mealPlanOatsUpma.
  ///
  /// In en, this message translates to:
  /// **'Oats Upma with Vegetables'**
  String get mealPlanOatsUpma;

  /// No description provided for @mealPlanMoongDalCheela.
  ///
  /// In en, this message translates to:
  /// **'Moong Dal Cheela with Mint Chutney'**
  String get mealPlanMoongDalCheela;

  /// No description provided for @mealPlanRagiDosa.
  ///
  /// In en, this message translates to:
  /// **'Ragi Dosa with Sambar'**
  String get mealPlanRagiDosa;

  /// No description provided for @mealPlanBrownRiceDal.
  ///
  /// In en, this message translates to:
  /// **'Brown Rice with Dal Tadka and Salad'**
  String get mealPlanBrownRiceDal;

  /// No description provided for @mealPlanQuinoaPulao.
  ///
  /// In en, this message translates to:
  /// **'Quinoa Pulao with Raita'**
  String get mealPlanQuinoaPulao;

  /// No description provided for @mealPlanGrilledChicken.
  ///
  /// In en, this message translates to:
  /// **'Grilled Chicken with Multigrain Roti'**
  String get mealPlanGrilledChicken;

  /// No description provided for @mealPlanPalakPaneer.
  ///
  /// In en, this message translates to:
  /// **'Palak Paneer with Roti'**
  String get mealPlanPalakPaneer;

  /// No description provided for @mealPlanVegKhichdi.
  ///
  /// In en, this message translates to:
  /// **'Vegetable Khichdi with Curd'**
  String get mealPlanVegKhichdi;

  /// No description provided for @mealPlanGrilledFish.
  ///
  /// In en, this message translates to:
  /// **'Grilled Fish with Steamed Vegetables'**
  String get mealPlanGrilledFish;

  /// No description provided for @mealPlanMixedNuts.
  ///
  /// In en, this message translates to:
  /// **'Mixed Nuts and Seeds'**
  String get mealPlanMixedNuts;

  /// No description provided for @mealPlanFruitSalad.
  ///
  /// In en, this message translates to:
  /// **'Fruit Salad with Yogurt'**
  String get mealPlanFruitSalad;

  /// No description provided for @mealPlanRoastedChickpeas.
  ///
  /// In en, this message translates to:
  /// **'Roasted Chickpeas'**
  String get mealPlanRoastedChickpeas;

  /// No description provided for @mealPlanDiabetesSafe.
  ///
  /// In en, this message translates to:
  /// **'Diabetes-safe'**
  String get mealPlanDiabetesSafe;

  /// No description provided for @mealPlanPCOSFriendly.
  ///
  /// In en, this message translates to:
  /// **'PCOS-friendly'**
  String get mealPlanPCOSFriendly;

  /// No description provided for @mealPlanHeartHealthy.
  ///
  /// In en, this message translates to:
  /// **'Heart-healthy'**
  String get mealPlanHeartHealthy;

  /// No description provided for @mealPlanIronRich.
  ///
  /// In en, this message translates to:
  /// **'Iron-rich'**
  String get mealPlanIronRich;

  /// No description provided for @mealPlanHighProtein.
  ///
  /// In en, this message translates to:
  /// **'High-protein'**
  String get mealPlanHighProtein;

  /// No description provided for @mealPlanVitaminRich.
  ///
  /// In en, this message translates to:
  /// **'Vitamin-rich'**
  String get mealPlanVitaminRich;

  /// No description provided for @mealPlanHighFiber.
  ///
  /// In en, this message translates to:
  /// **'High-fiber'**
  String get mealPlanHighFiber;

  /// No description provided for @mealPlanOatsUpmaSummary.
  ///
  /// In en, this message translates to:
  /// **'Low glycemic index breakfast that keeps you full and prevents sugar spikes.'**
  String get mealPlanOatsUpmaSummary;

  /// No description provided for @mealPlanOatsUpmaReason1.
  ///
  /// In en, this message translates to:
  /// **'High fiber from oats and vegetables'**
  String get mealPlanOatsUpmaReason1;

  /// No description provided for @mealPlanOatsUpmaReason2.
  ///
  /// In en, this message translates to:
  /// **'Slow glucose absorption'**
  String get mealPlanOatsUpmaReason2;

  /// No description provided for @mealPlanOatsUpmaReason3.
  ///
  /// In en, this message translates to:
  /// **'Rich in essential minerals'**
  String get mealPlanOatsUpmaReason3;

  /// No description provided for @mealPlanBrownRiceSummary.
  ///
  /// In en, this message translates to:
  /// **'Balanced meal providing complex carbs and plant-based protein.'**
  String get mealPlanBrownRiceSummary;

  /// No description provided for @mealPlanBrownRiceReason1.
  ///
  /// In en, this message translates to:
  /// **'Protein-rich dal for satiety'**
  String get mealPlanBrownRiceReason1;

  /// No description provided for @mealPlanBrownRiceReason2.
  ///
  /// In en, this message translates to:
  /// **'Fiber from brown rice and salad'**
  String get mealPlanBrownRiceReason2;

  /// No description provided for @mealPlanBrownRiceReason3.
  ///
  /// In en, this message translates to:
  /// **'Complete amino acid profile'**
  String get mealPlanBrownRiceReason3;

  /// No description provided for @mealPlanRoastedMakhanaSummary.
  ///
  /// In en, this message translates to:
  /// **'Light, anti-inflammatory snack rich in antioxidants.'**
  String get mealPlanRoastedMakhanaSummary;

  /// No description provided for @mealPlanRoastedMakhanaReason1.
  ///
  /// In en, this message translates to:
  /// **'Antioxidants from green tea'**
  String get mealPlanRoastedMakhanaReason1;

  /// No description provided for @mealPlanRoastedMakhanaReason2.
  ///
  /// In en, this message translates to:
  /// **'Low calorie density'**
  String get mealPlanRoastedMakhanaReason2;

  /// No description provided for @mealPlanRoastedMakhanaReason3.
  ///
  /// In en, this message translates to:
  /// **'Manganese and protein from makhana'**
  String get mealPlanRoastedMakhanaReason3;

  /// No description provided for @mealPlanPalakPaneerSummary.
  ///
  /// In en, this message translates to:
  /// **'Protein and iron-rich dinner that supports muscle repair and hormonal health.'**
  String get mealPlanPalakPaneerSummary;

  /// No description provided for @mealPlanPalakPaneerReason1.
  ///
  /// In en, this message translates to:
  /// **'Iron from spinach'**
  String get mealPlanPalakPaneerReason1;

  /// No description provided for @mealPlanPalakPaneerReason2.
  ///
  /// In en, this message translates to:
  /// **'Protein from paneer'**
  String get mealPlanPalakPaneerReason2;

  /// No description provided for @mealPlanPalakPaneerReason3.
  ///
  /// In en, this message translates to:
  /// **'Probiotics from curd'**
  String get mealPlanPalakPaneerReason3;

  /// No description provided for @mockIngredientOats.
  ///
  /// In en, this message translates to:
  /// **'Oats'**
  String get mockIngredientOats;

  /// No description provided for @mockIngredientMustardSeeds.
  ///
  /// In en, this message translates to:
  /// **'Mustard seeds'**
  String get mockIngredientMustardSeeds;

  /// No description provided for @mockIngredientCurryLeaves.
  ///
  /// In en, this message translates to:
  /// **'Curry leaves'**
  String get mockIngredientCurryLeaves;

  /// No description provided for @mockIngredientGreenChili.
  ///
  /// In en, this message translates to:
  /// **'Green chili'**
  String get mockIngredientGreenChili;

  /// No description provided for @mockIngredientPhoolMakhana.
  ///
  /// In en, this message translates to:
  /// **'Phool Makhana (Fox nuts)'**
  String get mockIngredientPhoolMakhana;

  /// No description provided for @mockIngredientGreenTeaBag.
  ///
  /// In en, this message translates to:
  /// **'Green tea bag'**
  String get mockIngredientGreenTeaBag;

  /// No description provided for @mockIngredientBlackSalt.
  ///
  /// In en, this message translates to:
  /// **'Black salt & Pepper'**
  String get mockIngredientBlackSalt;

  /// No description provided for @mockIngredientGhee.
  ///
  /// In en, this message translates to:
  /// **'Ghee/Olive oil'**
  String get mockIngredientGhee;

  /// No description provided for @mockIngredientCucumber.
  ///
  /// In en, this message translates to:
  /// **'Cucumber'**
  String get mockIngredientCucumber;

  /// No description provided for @mockIngredientPalakPuree.
  ///
  /// In en, this message translates to:
  /// **'Palak (Spinach) puree'**
  String get mockIngredientPalakPuree;

  /// No description provided for @mockIngredientPaneerCubes.
  ///
  /// In en, this message translates to:
  /// **'Paneer cubes'**
  String get mockIngredientPaneerCubes;

  /// No description provided for @mockInstructionDryRoast.
  ///
  /// In en, this message translates to:
  /// **'Dry roast oats for 2-3 minutes until lightly golden.'**
  String get mockInstructionDryRoast;

  /// No description provided for @mockInstructionTadka.
  ///
  /// In en, this message translates to:
  /// **'Heat oil, add mustard seeds, curry leaves, and green chilies.'**
  String get mockInstructionTadka;

  /// No description provided for @mockInstructionSauteVeg.
  ///
  /// In en, this message translates to:
  /// **'Add onions and vegetables, sauté until tender.'**
  String get mockInstructionSauteVeg;

  /// No description provided for @mockInstructionBoilWater.
  ///
  /// In en, this message translates to:
  /// **'Add water and salt, bring to boil. Stir in roasted oats.'**
  String get mockInstructionBoilWater;

  /// No description provided for @mockInstructionCookOats.
  ///
  /// In en, this message translates to:
  /// **'Cook until water is absorbed and oats are soft.'**
  String get mockInstructionCookOats;

  /// No description provided for @mockInstructionCookBrownRice.
  ///
  /// In en, this message translates to:
  /// **'Cook brown rice as per instructions.'**
  String get mockInstructionCookBrownRice;

  /// No description provided for @mockInstructionPressureCookDal.
  ///
  /// In en, this message translates to:
  /// **'Pressure cook dal with turmeric and salt.'**
  String get mockInstructionPressureCookDal;

  /// No description provided for @mockInstructionPerformTadka.
  ///
  /// In en, this message translates to:
  /// **'Perform tadka with cumin and garlic in a little ghee/oil.'**
  String get mockInstructionPerformTadka;

  /// No description provided for @mockInstructionPrepareSalad.
  ///
  /// In en, this message translates to:
  /// **'Prepare fresh salad with chopped cucumber and tomatoes.'**
  String get mockInstructionPrepareSalad;

  /// No description provided for @mockInstructionRoastMakhana.
  ///
  /// In en, this message translates to:
  /// **'Heat ghee in a pan and roast makhana until crunchy.'**
  String get mockInstructionRoastMakhana;

  /// No description provided for @mockInstructionSeasonMakhana.
  ///
  /// In en, this message translates to:
  /// **'Season with black salt and pepper while hot.'**
  String get mockInstructionSeasonMakhana;

  /// No description provided for @mockInstructionBrewTea.
  ///
  /// In en, this message translates to:
  /// **'Brew green tea in hot water for 2-3 minutes.'**
  String get mockInstructionBrewTea;

  /// No description provided for @mockInstructionPreparePalakPaneer.
  ///
  /// In en, this message translates to:
  /// **'Prepare palak paneer gravy with spices and paneer.'**
  String get mockInstructionPreparePalakPaneer;

  /// No description provided for @mockInstructionMakeRotis.
  ///
  /// In en, this message translates to:
  /// **'Make fresh Rotis on a flat griddle (tawa).'**
  String get mockInstructionMakeRotis;

  /// No description provided for @mockInstructionMixRaita.
  ///
  /// In en, this message translates to:
  /// **'Mix grated cucumber in whisked curd for raita.'**
  String get mockInstructionMixRaita;

  /// No description provided for @mockBenefitInsulin.
  ///
  /// In en, this message translates to:
  /// **'Slow energy release prevents insulin spikes.'**
  String get mockBenefitInsulin;

  /// No description provided for @mockBenefitSatiety.
  ///
  /// In en, this message translates to:
  /// **'High fiber content promotes satiety.'**
  String get mockBenefitSatiety;

  /// No description provided for @mockBenefitDigestion.
  ///
  /// In en, this message translates to:
  /// **'High fiber aids in smooth digestion.'**
  String get mockBenefitDigestion;

  /// No description provided for @mockBenefitHormonal.
  ///
  /// In en, this message translates to:
  /// **'Nutrients support PCOS management.'**
  String get mockBenefitHormonal;

  /// No description provided for @mockBenefitOxidative.
  ///
  /// In en, this message translates to:
  /// **'Green tea helps reduce oxidative stress.'**
  String get mockBenefitOxidative;

  /// No description provided for @mockBenefitMindful.
  ///
  /// In en, this message translates to:
  /// **'Crunchy texture satisfies cravings with low calories.'**
  String get mockBenefitMindful;

  /// No description provided for @mockBenefitIron.
  ///
  /// In en, this message translates to:
  /// **'Spinach is a rich source of plant-based iron.'**
  String get mockBenefitIron;

  /// No description provided for @mockBenefitGutHealth.
  ///
  /// In en, this message translates to:
  /// **'Raita provides probiotics for better digestion.'**
  String get mockBenefitGutHealth;

  /// No description provided for @mockConditionDigestion.
  ///
  /// In en, this message translates to:
  /// **'Digestion'**
  String get mockConditionDigestion;

  /// No description provided for @mockConditionHormonal.
  ///
  /// In en, this message translates to:
  /// **'Hormonal Balance'**
  String get mockConditionHormonal;

  /// No description provided for @mockConditionInflammation.
  ///
  /// In en, this message translates to:
  /// **'Inflammation'**
  String get mockConditionInflammation;

  /// No description provided for @mockConditionMindful.
  ///
  /// In en, this message translates to:
  /// **'Mindful Snacking'**
  String get mockConditionMindful;

  /// No description provided for @mockConditionIron.
  ///
  /// In en, this message translates to:
  /// **'Iron Deficiency'**
  String get mockConditionIron;

  /// No description provided for @mockConditionGutHealth.
  ///
  /// In en, this message translates to:
  /// **'Gut Health'**
  String get mockConditionGutHealth;

  /// No description provided for @mealPlanOatsUpmaExpl.
  ///
  /// In en, this message translates to:
  /// **'High fiber content helps regulate blood sugar levels'**
  String get mealPlanOatsUpmaExpl;

  /// No description provided for @mealPlanMoongDalExpl.
  ///
  /// In en, this message translates to:
  /// **'Protein-rich moong dal supports hormonal balance'**
  String get mealPlanMoongDalExpl;

  /// No description provided for @mealPlanRagiDosaExpl.
  ///
  /// In en, this message translates to:
  /// **'Ragi provides calcium and iron for overall wellness'**
  String get mealPlanRagiDosaExpl;

  /// No description provided for @mealPlanBrownRiceExpl.
  ///
  /// In en, this message translates to:
  /// **'Brown rice has low glycemic index, perfect for blood sugar control'**
  String get mealPlanBrownRiceExpl;

  /// No description provided for @mealPlanQuinoaExpl.
  ///
  /// In en, this message translates to:
  /// **'Quinoa is a complete protein source supporting metabolic health'**
  String get mealPlanQuinoaExpl;

  /// No description provided for @mealPlanGrilledChickenExpl.
  ///
  /// In en, this message translates to:
  /// **'Lean protein supports muscle health and keeps you satisfied'**
  String get mealPlanGrilledChickenExpl;

  /// No description provided for @mealPlanPalakPaneerExpl.
  ///
  /// In en, this message translates to:
  /// **'Spinach provides iron and calcium for bone health'**
  String get mealPlanPalakPaneerExpl;

  /// No description provided for @mealPlanVegKhichdiExpl.
  ///
  /// In en, this message translates to:
  /// **'Easy to digest, balanced meal perfect for dinner'**
  String get mealPlanVegKhichdiExpl;

  /// No description provided for @mealPlanGrilledFishExpl.
  ///
  /// In en, this message translates to:
  /// **'Omega-3 fatty acids support cardiovascular health'**
  String get mealPlanGrilledFishExpl;

  /// No description provided for @mealPlanMixedNutsExpl.
  ///
  /// In en, this message translates to:
  /// **'Healthy fats and protein for sustained energy'**
  String get mealPlanMixedNutsExpl;

  /// No description provided for @mealPlanFruitSaladExpl.
  ///
  /// In en, this message translates to:
  /// **'Fresh fruits provide antioxidants and natural sweetness'**
  String get mealPlanFruitSaladExpl;

  /// No description provided for @mealPlanRoastedChickpeasExpl.
  ///
  /// In en, this message translates to:
  /// **'Fiber-rich snack that keeps you full between meals'**
  String get mealPlanRoastedChickpeasExpl;

  /// No description provided for @insightsTitle.
  ///
  /// In en, this message translates to:
  /// **'Health Insights'**
  String get insightsTitle;

  /// No description provided for @insightsRefreshTooltip.
  ///
  /// In en, this message translates to:
  /// **'Refresh insights'**
  String get insightsRefreshTooltip;

  /// No description provided for @insightsYourHealthScore.
  ///
  /// In en, this message translates to:
  /// **'Your Health Score'**
  String get insightsYourHealthScore;

  /// No description provided for @insightsWeeklyChange.
  ///
  /// In en, this message translates to:
  /// **'{value} points this week'**
  String insightsWeeklyChange(String value);

  /// No description provided for @insightsHealthConditions.
  ///
  /// In en, this message translates to:
  /// **'Health Conditions'**
  String get insightsHealthConditions;

  /// No description provided for @insightsNutrientBalance.
  ///
  /// In en, this message translates to:
  /// **'Nutrient Balance'**
  String get insightsNutrientBalance;

  /// No description provided for @insightsWeeklyTrends.
  ///
  /// In en, this message translates to:
  /// **'Weekly Trends'**
  String get insightsWeeklyTrends;

  /// No description provided for @insightsPersonalizedInsights.
  ///
  /// In en, this message translates to:
  /// **'Personalized Insights'**
  String get insightsPersonalizedInsights;

  /// No description provided for @insightsRecommendations.
  ///
  /// In en, this message translates to:
  /// **'Recommendations'**
  String get insightsRecommendations;

  /// No description provided for @insightsDietAdherence.
  ///
  /// In en, this message translates to:
  /// **'Diet Adherence'**
  String get insightsDietAdherence;

  /// No description provided for @insightsNutrientTracking.
  ///
  /// In en, this message translates to:
  /// **'Daily Nutrient Tracking'**
  String get insightsNutrientTracking;

  /// No description provided for @insightsStatusWithinRange.
  ///
  /// In en, this message translates to:
  /// **'Within Range'**
  String get insightsStatusWithinRange;

  /// No description provided for @insightsStatusBorderline.
  ///
  /// In en, this message translates to:
  /// **'Borderline'**
  String get insightsStatusBorderline;

  /// No description provided for @insightsStatusNeedsImprovement.
  ///
  /// In en, this message translates to:
  /// **'Needs Improvement'**
  String get insightsStatusNeedsImprovement;

  /// No description provided for @insightsStatusStable.
  ///
  /// In en, this message translates to:
  /// **'Stable'**
  String get insightsStatusStable;

  /// No description provided for @insightsStatusImproving.
  ///
  /// In en, this message translates to:
  /// **'Improving'**
  String get insightsStatusImproving;

  /// No description provided for @insightsStatusNeedsAttention.
  ///
  /// In en, this message translates to:
  /// **'Needs Attention'**
  String get insightsStatusNeedsAttention;

  /// No description provided for @insightsTrendImproving.
  ///
  /// In en, this message translates to:
  /// **'Improving'**
  String get insightsTrendImproving;

  /// No description provided for @insightsTrendDeclining.
  ///
  /// In en, this message translates to:
  /// **'Declining'**
  String get insightsTrendDeclining;

  /// No description provided for @insights7DayTrends.
  ///
  /// In en, this message translates to:
  /// **'7-Day Trends'**
  String get insights7DayTrends;

  /// No description provided for @insightsTabAdherence.
  ///
  /// In en, this message translates to:
  /// **'Adherence'**
  String get insightsTabAdherence;

  /// No description provided for @insightsTabCalories.
  ///
  /// In en, this message translates to:
  /// **'Calories'**
  String get insightsTabCalories;

  /// No description provided for @insightsTabBudget.
  ///
  /// In en, this message translates to:
  /// **'Budget'**
  String get insightsTabBudget;

  /// No description provided for @insightsNoData.
  ///
  /// In en, this message translates to:
  /// **'No data available'**
  String get insightsNoData;

  /// No description provided for @insightsDefaultTitle.
  ///
  /// In en, this message translates to:
  /// **'Insight'**
  String get insightsDefaultTitle;

  /// No description provided for @insightsActionable.
  ///
  /// In en, this message translates to:
  /// **'Actionable'**
  String get insightsActionable;

  /// No description provided for @insightsDefaultRecommendation.
  ///
  /// In en, this message translates to:
  /// **'Recommendation'**
  String get insightsDefaultRecommendation;

  /// No description provided for @mockInsightConsistentTimingTitle.
  ///
  /// In en, this message translates to:
  /// **'Consistent Meal Timing'**
  String get mockInsightConsistentTimingTitle;

  /// No description provided for @mockInsightConsistentTimingDesc.
  ///
  /// In en, this message translates to:
  /// **'You\'ve maintained regular meal times for 6 days. This helps stabilize blood sugar levels.'**
  String get mockInsightConsistentTimingDesc;

  /// No description provided for @mockInsightFiberLowTitle.
  ///
  /// In en, this message translates to:
  /// **'Fiber Intake Below Target'**
  String get mockInsightFiberLowTitle;

  /// No description provided for @mockInsightFiberLowDesc.
  ///
  /// In en, this message translates to:
  /// **'Your fiber intake is 73% of target. Consider adding more vegetables and whole grains.'**
  String get mockInsightFiberLowDesc;

  /// No description provided for @mockInsightBudgetOptTitle.
  ///
  /// In en, this message translates to:
  /// **'Budget Optimization'**
  String get mockInsightBudgetOptTitle;

  /// No description provided for @mockInsightBudgetOptDesc.
  ///
  /// In en, this message translates to:
  /// **'You\'re staying within budget while meeting nutritional goals. Great balance!'**
  String get mockInsightBudgetOptDesc;

  /// No description provided for @mockInsightSugarHighTitle.
  ///
  /// In en, this message translates to:
  /// **'Sugar Intake High'**
  String get mockInsightSugarHighTitle;

  /// No description provided for @mockInsightSugarHighDesc.
  ///
  /// In en, this message translates to:
  /// **'Daily sugar intake is 29% above target. Try reducing sweetened beverages and desserts.'**
  String get mockInsightSugarHighDesc;

  /// No description provided for @mockRecFiberIncreaseTitle.
  ///
  /// In en, this message translates to:
  /// **'Increase Fiber Intake'**
  String get mockRecFiberIncreaseTitle;

  /// No description provided for @mockRecFiberIncreaseDesc.
  ///
  /// In en, this message translates to:
  /// **'Add 1 cup of mixed vegetables to lunch and dinner. Try switching white rice to brown rice.'**
  String get mockRecFiberIncreaseDesc;

  /// No description provided for @mockRecSugarReduceTitle.
  ///
  /// In en, this message translates to:
  /// **'Reduce Added Sugar'**
  String get mockRecSugarReduceTitle;

  /// No description provided for @mockRecSugarReduceDesc.
  ///
  /// In en, this message translates to:
  /// **'Replace sweetened beverages with herbal tea or infused water. Choose fresh fruits over fruit juices.'**
  String get mockRecSugarReduceDesc;

  /// No description provided for @mockRecProteinMaintainTitle.
  ///
  /// In en, this message translates to:
  /// **'Maintain Current Protein Levels'**
  String get mockRecProteinMaintainTitle;

  /// No description provided for @mockRecProteinMaintainDesc.
  ///
  /// In en, this message translates to:
  /// **'Your protein intake is excellent. Continue including dal, paneer, and eggs in your meals.'**
  String get mockRecProteinMaintainDesc;

  /// No description provided for @mockRecHydrateTitle.
  ///
  /// In en, this message translates to:
  /// **'Stay Hydrated'**
  String get mockRecHydrateTitle;

  /// No description provided for @mockRecHydrateDesc.
  ///
  /// In en, this message translates to:
  /// **'Aim for 8-10 glasses of water daily to support metabolism and nutrient absorption.'**
  String get mockRecHydrateDesc;

  /// No description provided for @adaptivePlanActive.
  ///
  /// In en, this message translates to:
  /// **'Adaptive Plan Active'**
  String get adaptivePlanActive;

  /// No description provided for @adaptivePersonalized.
  ///
  /// In en, this message translates to:
  /// **'Personalized'**
  String get adaptivePersonalized;

  /// No description provided for @adaptiveAdjustedDesc.
  ///
  /// In en, this message translates to:
  /// **'Your plan has been automatically adjusted based on your eating patterns:'**
  String get adaptiveAdjustedDesc;

  /// No description provided for @adaptivePortionsOptimized.
  ///
  /// In en, this message translates to:
  /// **'Portions optimized for your consumption habits'**
  String get adaptivePortionsOptimized;

  /// No description provided for @adaptiveMealsReplaced.
  ///
  /// In en, this message translates to:
  /// **'Meals replaced based on your preferences'**
  String get adaptiveMealsReplaced;

  /// No description provided for @adaptiveNutrientsRebalanced.
  ///
  /// In en, this message translates to:
  /// **'Nutrients rebalanced for optimal health'**
  String get adaptiveNutrientsRebalanced;

  /// No description provided for @mockConditionDiabetes.
  ///
  /// In en, this message translates to:
  /// **'Type 2 Diabetes'**
  String get mockConditionDiabetes;

  /// No description provided for @mockConditionPCOS.
  ///
  /// In en, this message translates to:
  /// **'PCOS'**
  String get mockConditionPCOS;

  /// No description provided for @mockConditionHypertension.
  ///
  /// In en, this message translates to:
  /// **'Hypertension'**
  String get mockConditionHypertension;

  /// No description provided for @mealPlanProtein.
  ///
  /// In en, this message translates to:
  /// **'Protein'**
  String get mealPlanProtein;

  /// No description provided for @mealPlanFiber.
  ///
  /// In en, this message translates to:
  /// **'Fiber'**
  String get mealPlanFiber;

  /// No description provided for @mealPlanSugar.
  ///
  /// In en, this message translates to:
  /// **'Sugar'**
  String get mealPlanSugar;

  /// No description provided for @mealPlanSodium.
  ///
  /// In en, this message translates to:
  /// **'Sodium'**
  String get mealPlanSodium;

  /// No description provided for @pantryTitle.
  ///
  /// In en, this message translates to:
  /// **'Pantry Management'**
  String get pantryTitle;

  /// No description provided for @pantryRefreshTooltip.
  ///
  /// In en, this message translates to:
  /// **'Refresh pantry'**
  String get pantryRefreshTooltip;

  /// No description provided for @pantrySearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search ingredients...'**
  String get pantrySearchHint;

  /// No description provided for @pantryTabInventory.
  ///
  /// In en, this message translates to:
  /// **'Inventory'**
  String get pantryTabInventory;

  /// No description provided for @pantryTabSuggestions.
  ///
  /// In en, this message translates to:
  /// **'Meal Suggestions'**
  String get pantryTabSuggestions;

  /// No description provided for @pantryFabAddItem.
  ///
  /// In en, this message translates to:
  /// **'Add Item'**
  String get pantryFabAddItem;

  /// No description provided for @pantryEmptyNoItems.
  ///
  /// In en, this message translates to:
  /// **'No Items in Pantry'**
  String get pantryEmptyNoItems;

  /// No description provided for @pantryEmptyNoResults.
  ///
  /// In en, this message translates to:
  /// **'No Results Found'**
  String get pantryEmptyNoResults;

  /// No description provided for @pantryEmptyMessageNoItems.
  ///
  /// In en, this message translates to:
  /// **'Start adding ingredients to track your pantry inventory'**
  String get pantryEmptyMessageNoItems;

  /// No description provided for @pantryEmptyMessageNoResults.
  ///
  /// In en, this message translates to:
  /// **'Try searching with different keywords'**
  String get pantryEmptyMessageNoResults;

  /// No description provided for @pantrySummaryTotal.
  ///
  /// In en, this message translates to:
  /// **'Total Items'**
  String get pantrySummaryTotal;

  /// No description provided for @pantrySummaryFresh.
  ///
  /// In en, this message translates to:
  /// **'Fresh'**
  String get pantrySummaryFresh;

  /// No description provided for @pantrySummaryExpiring.
  ///
  /// In en, this message translates to:
  /// **'Expiring'**
  String get pantrySummaryExpiring;

  /// No description provided for @pantrySummaryExpired.
  ///
  /// In en, this message translates to:
  /// **'Expired'**
  String get pantrySummaryExpired;

  /// No description provided for @pantrySuggestionsTitle.
  ///
  /// In en, this message translates to:
  /// **'Smart Meal Suggestions'**
  String get pantrySuggestionsTitle;

  /// No description provided for @pantrySuggestionsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Based on your available pantry stock'**
  String get pantrySuggestionsSubtitle;

  /// No description provided for @pantryEmptyNoSuggestions.
  ///
  /// In en, this message translates to:
  /// **'No Meal Suggestions'**
  String get pantryEmptyNoSuggestions;

  /// No description provided for @pantryEmptyMessageNoSuggestions.
  ///
  /// In en, this message translates to:
  /// **'Add more ingredients to get personalized meal suggestions'**
  String get pantryEmptyMessageNoSuggestions;

  /// No description provided for @pantrySnackAddedToList.
  ///
  /// In en, this message translates to:
  /// **'{itemName} added to grocery list'**
  String pantrySnackAddedToList(String itemName);

  /// No description provided for @pantrySnackMarkedUsed.
  ///
  /// In en, this message translates to:
  /// **'{itemName} marked as used'**
  String pantrySnackMarkedUsed(String itemName);

  /// No description provided for @pantrySnackAddedToPantry.
  ///
  /// In en, this message translates to:
  /// **'{itemName} added to pantry'**
  String pantrySnackAddedToPantry(String itemName);

  /// No description provided for @pantryDialogAddTitle.
  ///
  /// In en, this message translates to:
  /// **'Add Pantry Item'**
  String get pantryDialogAddTitle;

  /// No description provided for @pantryDialogItemNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Item Name *'**
  String get pantryDialogItemNameLabel;

  /// No description provided for @pantryDialogItemNameHint.
  ///
  /// In en, this message translates to:
  /// **'e.g., Tomatoes'**
  String get pantryDialogItemNameHint;

  /// No description provided for @pantryDialogCategoryLabel.
  ///
  /// In en, this message translates to:
  /// **'Category *'**
  String get pantryDialogCategoryLabel;

  /// No description provided for @pantryDialogQuantityLabel.
  ///
  /// In en, this message translates to:
  /// **'Quantity *'**
  String get pantryDialogQuantityLabel;

  /// No description provided for @pantryDialogQuantityHint.
  ///
  /// In en, this message translates to:
  /// **'0.0'**
  String get pantryDialogQuantityHint;

  /// No description provided for @pantryDialogUnitLabel.
  ///
  /// In en, this message translates to:
  /// **'Unit *'**
  String get pantryDialogUnitLabel;

  /// No description provided for @pantryDialogExpiryDateLabel.
  ///
  /// In en, this message translates to:
  /// **'Expiry Date *'**
  String get pantryDialogExpiryDateLabel;

  /// No description provided for @pantryDialogErrorFields.
  ///
  /// In en, this message translates to:
  /// **'Please fill all required fields'**
  String get pantryDialogErrorFields;

  /// No description provided for @pantryDialogCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get pantryDialogCancel;

  /// No description provided for @pantryDialogConfirmAdd.
  ///
  /// In en, this message translates to:
  /// **'Add Item'**
  String get pantryDialogConfirmAdd;

  /// No description provided for @pantryCategoryVegetables.
  ///
  /// In en, this message translates to:
  /// **'Vegetables'**
  String get pantryCategoryVegetables;

  /// No description provided for @pantryCategoryGrains.
  ///
  /// In en, this message translates to:
  /// **'Grains'**
  String get pantryCategoryGrains;

  /// No description provided for @pantryCategorySpices.
  ///
  /// In en, this message translates to:
  /// **'Spices'**
  String get pantryCategorySpices;

  /// No description provided for @pantryCategoryDairy.
  ///
  /// In en, this message translates to:
  /// **'Dairy'**
  String get pantryCategoryDairy;

  /// No description provided for @pantryCategoryProteins.
  ///
  /// In en, this message translates to:
  /// **'Proteins'**
  String get pantryCategoryProteins;

  /// No description provided for @pantryCategoryOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get pantryCategoryOther;

  /// No description provided for @unitKg.
  ///
  /// In en, this message translates to:
  /// **'kg'**
  String get unitKg;

  /// No description provided for @unitG.
  ///
  /// In en, this message translates to:
  /// **'g'**
  String get unitG;

  /// No description provided for @unitL.
  ///
  /// In en, this message translates to:
  /// **'L'**
  String get unitL;

  /// No description provided for @unitMl.
  ///
  /// In en, this message translates to:
  /// **'ml'**
  String get unitMl;

  /// No description provided for @unitPcs.
  ///
  /// In en, this message translates to:
  /// **'pcs'**
  String get unitPcs;

  /// No description provided for @pantryStatusFresh.
  ///
  /// In en, this message translates to:
  /// **'Fresh'**
  String get pantryStatusFresh;

  /// No description provided for @pantryStatusExpiringSoon.
  ///
  /// In en, this message translates to:
  /// **'Expiring Soon'**
  String get pantryStatusExpiringSoon;

  /// No description provided for @pantryStatusExpired.
  ///
  /// In en, this message translates to:
  /// **'Expired'**
  String get pantryStatusExpired;

  /// No description provided for @pantryStatusUnknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get pantryStatusUnknown;

  /// No description provided for @pantryMealCal.
  ///
  /// In en, this message translates to:
  /// **'{value} cal'**
  String pantryMealCal(String value);

  /// No description provided for @pantryMealAvailablePercent.
  ///
  /// In en, this message translates to:
  /// **'{value}% available'**
  String pantryMealAvailablePercent(int value);

  /// No description provided for @pantryMealRequiredIngredients.
  ///
  /// In en, this message translates to:
  /// **'Required Ingredients'**
  String get pantryMealRequiredIngredients;

  /// No description provided for @pantryMealInPantry.
  ///
  /// In en, this message translates to:
  /// **'In Pantry'**
  String get pantryMealInPantry;

  /// No description provided for @pantryMealMissingIngredients.
  ///
  /// In en, this message translates to:
  /// **'Missing Ingredients'**
  String get pantryMealMissingIngredients;

  /// No description provided for @pantryMealEstimatedCost.
  ///
  /// In en, this message translates to:
  /// **'Estimated cost: ₹{value}'**
  String pantryMealEstimatedCost(String value);

  /// No description provided for @pantryMealReadyToCook.
  ///
  /// In en, this message translates to:
  /// **'All ingredients available! Ready to cook.'**
  String get pantryMealReadyToCook;

  /// No description provided for @pantryMealAddedMissingToGrocery.
  ///
  /// In en, this message translates to:
  /// **'Missing ingredients added to grocery list'**
  String get pantryMealAddedMissingToGrocery;

  /// No description provided for @pantryMealStartCooking.
  ///
  /// In en, this message translates to:
  /// **'Start Cooking'**
  String get pantryMealStartCooking;

  /// No description provided for @pantryMealAddMissingItems.
  ///
  /// In en, this message translates to:
  /// **'Add Missing Items to Grocery'**
  String get pantryMealAddMissingItems;

  /// No description provided for @pantryMealMissingLabel.
  ///
  /// In en, this message translates to:
  /// **'Missing: {value}'**
  String pantryMealMissingLabel(String value);

  /// No description provided for @pantryMealAllAvailable.
  ///
  /// In en, this message translates to:
  /// **'All ingredients available!'**
  String get pantryMealAllAvailable;

  /// No description provided for @pantryMealTapToView.
  ///
  /// In en, this message translates to:
  /// **'Tap to view details'**
  String get pantryMealTapToView;

  /// No description provided for @pantryDetailsStock.
  ///
  /// In en, this message translates to:
  /// **'Current Stock'**
  String get pantryDetailsStock;

  /// No description provided for @pantryDetailsDaysLeft.
  ///
  /// In en, this message translates to:
  /// **'Days Left'**
  String get pantryDetailsDaysLeft;

  /// No description provided for @pantryDetailsDaysRange.
  ///
  /// In en, this message translates to:
  /// **'{value} days'**
  String pantryDetailsDaysRange(int value);

  /// No description provided for @pantryDetailsPurchaseDate.
  ///
  /// In en, this message translates to:
  /// **'Purchase Date'**
  String get pantryDetailsPurchaseDate;

  /// No description provided for @pantryDetailsExpiryDate.
  ///
  /// In en, this message translates to:
  /// **'Expiry Date'**
  String get pantryDetailsExpiryDate;

  /// No description provided for @pantryDetailsStockLevel.
  ///
  /// In en, this message translates to:
  /// **'Stock Level'**
  String get pantryDetailsStockLevel;

  /// No description provided for @pantryDetailsNoUsage.
  ///
  /// In en, this message translates to:
  /// **'No usage recorded yet'**
  String get pantryDetailsNoUsage;

  /// No description provided for @pantryDetailsUsageHistory.
  ///
  /// In en, this message translates to:
  /// **'Usage History'**
  String get pantryDetailsUsageHistory;

  /// No description provided for @pantryDetailsMarkUsedTitle.
  ///
  /// In en, this message translates to:
  /// **'Mark {itemName} as Used'**
  String pantryDetailsMarkUsedTitle(String itemName);

  /// No description provided for @pantryDetailsSelectPortion.
  ///
  /// In en, this message translates to:
  /// **'Select portion used:'**
  String get pantryDetailsSelectPortion;

  /// No description provided for @pantryDetailsConfirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get pantryDetailsConfirm;

  /// No description provided for @pantryDetailsAddToList.
  ///
  /// In en, this message translates to:
  /// **'Add to List'**
  String get pantryDetailsAddToList;

  /// No description provided for @pantryDetailsMarkUsed.
  ///
  /// In en, this message translates to:
  /// **'Mark Used'**
  String get pantryDetailsMarkUsed;

  /// No description provided for @pantryDetailsExpiresLabel.
  ///
  /// In en, this message translates to:
  /// **'Expires: {date} ({days} days)'**
  String pantryDetailsExpiresLabel(String date, int days);

  /// No description provided for @mockIngredientCapsicum.
  ///
  /// In en, this message translates to:
  /// **'Capsicum'**
  String get mockIngredientCapsicum;

  /// No description provided for @mockIngredientMixedVeg.
  ///
  /// In en, this message translates to:
  /// **'Mixed Vegetables'**
  String get mockIngredientMixedVeg;

  /// No description provided for @mockIngredientDalia.
  ///
  /// In en, this message translates to:
  /// **'Dalia (Broken Wheat)'**
  String get mockIngredientDalia;

  /// No description provided for @mockMealVegPulao.
  ///
  /// In en, this message translates to:
  /// **'Vegetable Pulao'**
  String get mockMealVegPulao;

  /// No description provided for @mockMealPaneerTikka.
  ///
  /// In en, this message translates to:
  /// **'Paneer Tikka'**
  String get mockMealPaneerTikka;

  /// No description provided for @mockMealDaliaKhichdi.
  ///
  /// In en, this message translates to:
  /// **'Dalia Khichdi'**
  String get mockMealDaliaKhichdi;

  /// No description provided for @mockIngredientOnions.
  ///
  /// In en, this message translates to:
  /// **'Onions'**
  String get mockIngredientOnions;

  /// No description provided for @mockIngredientTomatoes.
  ///
  /// In en, this message translates to:
  /// **'Tomatoes'**
  String get mockIngredientTomatoes;

  /// No description provided for @mockIngredientSpinach.
  ///
  /// In en, this message translates to:
  /// **'Spinach'**
  String get mockIngredientSpinach;

  /// No description provided for @mockIngredientCarrots.
  ///
  /// In en, this message translates to:
  /// **'Carrots'**
  String get mockIngredientCarrots;

  /// No description provided for @mockIngredientBasmatiRice.
  ///
  /// In en, this message translates to:
  /// **'Basmati Rice'**
  String get mockIngredientBasmatiRice;

  /// No description provided for @mockIngredientWheatFlour.
  ///
  /// In en, this message translates to:
  /// **'Whole Wheat Flour'**
  String get mockIngredientWheatFlour;

  /// No description provided for @mockIngredientMoongDal.
  ///
  /// In en, this message translates to:
  /// **'Moong Dal'**
  String get mockIngredientMoongDal;

  /// No description provided for @mockIngredientTurmeric.
  ///
  /// In en, this message translates to:
  /// **'Turmeric Powder'**
  String get mockIngredientTurmeric;

  /// No description provided for @mockIngredientCumin.
  ///
  /// In en, this message translates to:
  /// **'Cumin Seeds'**
  String get mockIngredientCumin;

  /// No description provided for @mockIngredientGaramMasala.
  ///
  /// In en, this message translates to:
  /// **'Garam Masala'**
  String get mockIngredientGaramMasala;

  /// No description provided for @mockIngredientMilk.
  ///
  /// In en, this message translates to:
  /// **'Milk'**
  String get mockIngredientMilk;

  /// No description provided for @mockIngredientYogurt.
  ///
  /// In en, this message translates to:
  /// **'Yogurt'**
  String get mockIngredientYogurt;

  /// No description provided for @mockIngredientPaneer.
  ///
  /// In en, this message translates to:
  /// **'Paneer'**
  String get mockIngredientPaneer;

  /// No description provided for @mockIngredientChicken.
  ///
  /// In en, this message translates to:
  /// **'Chicken Breast'**
  String get mockIngredientChicken;

  /// No description provided for @mockIngredientEggs.
  ///
  /// In en, this message translates to:
  /// **'Eggs'**
  String get mockIngredientEggs;

  /// No description provided for @mockIngredientGreenPeas.
  ///
  /// In en, this message translates to:
  /// **'Green Peas'**
  String get mockIngredientGreenPeas;

  /// No description provided for @mockIngredientCream.
  ///
  /// In en, this message translates to:
  /// **'Cream'**
  String get mockIngredientCream;

  /// No description provided for @mockIngredientButter.
  ///
  /// In en, this message translates to:
  /// **'Butter'**
  String get mockIngredientButter;

  /// No description provided for @mockIngredientCoconutMilk.
  ///
  /// In en, this message translates to:
  /// **'Coconut Milk'**
  String get mockIngredientCoconutMilk;

  /// No description provided for @mockIngredientGarlic.
  ///
  /// In en, this message translates to:
  /// **'Garlic'**
  String get mockIngredientGarlic;

  /// No description provided for @mockMealDalTadka.
  ///
  /// In en, this message translates to:
  /// **'Dal Tadka'**
  String get mockMealDalTadka;

  /// No description provided for @mockMealPaneerButterMasala.
  ///
  /// In en, this message translates to:
  /// **'Paneer Butter Masala'**
  String get mockMealPaneerButterMasala;

  /// No description provided for @mockMealEggCurry.
  ///
  /// In en, this message translates to:
  /// **'Egg Curry'**
  String get mockMealEggCurry;

  /// No description provided for @mealPlanRoastedMakhana.
  ///
  /// In en, this message translates to:
  /// **'Roasted Makhana with Green Tea'**
  String get mealPlanRoastedMakhana;

  /// No description provided for @mealPlanRotiPalakPaneer.
  ///
  /// In en, this message translates to:
  /// **'Roti with Palak Paneer & Cucumber Raita'**
  String get mealPlanRotiPalakPaneer;

  /// No description provided for @mockMealIdliSambar.
  ///
  /// In en, this message translates to:
  /// **'Idli with Sambar'**
  String get mockMealIdliSambar;

  /// No description provided for @mockMealDosaChutney.
  ///
  /// In en, this message translates to:
  /// **'Dosa with Coconut Chutney'**
  String get mockMealDosaChutney;

  /// No description provided for @mockMealVegetableUpma.
  ///
  /// In en, this message translates to:
  /// **'Vegetable Upma'**
  String get mockMealVegetableUpma;

  /// No description provided for @mockMealLemonRice.
  ///
  /// In en, this message translates to:
  /// **'Lemon Rice'**
  String get mockMealLemonRice;

  /// No description provided for @mockMealCurdRice.
  ///
  /// In en, this message translates to:
  /// **'Curd Rice'**
  String get mockMealCurdRice;

  /// No description provided for @mockMealRagiMudde.
  ///
  /// In en, this message translates to:
  /// **'Ragi Mudde with Saaru'**
  String get mockMealRagiMudde;

  /// No description provided for @mockMealRotiDalTadka.
  ///
  /// In en, this message translates to:
  /// **'Roti with Dal Tadka'**
  String get mockMealRotiDalTadka;

  /// No description provided for @mockMealRajmaChawal.
  ///
  /// In en, this message translates to:
  /// **'Rajma Chawal'**
  String get mockMealRajmaChawal;

  /// No description provided for @mockMealVegetableKhichdi.
  ///
  /// In en, this message translates to:
  /// **'Vegetable Khichdi'**
  String get mockMealVegetableKhichdi;

  /// No description provided for @mockMealCholeRice.
  ///
  /// In en, this message translates to:
  /// **'Chole with Rice'**
  String get mockMealCholeRice;

  /// No description provided for @mockMealPaneerBhurji.
  ///
  /// In en, this message translates to:
  /// **'Paneer Bhurji with Roti'**
  String get mockMealPaneerBhurji;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'hi', 'kn'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'hi':
      return AppLocalizationsHi();
    case 'kn':
      return AppLocalizationsKn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}

// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get appName => 'NutriCart';

  @override
  String dashboardGreeting(String userName) {
    return 'नमस्ते $userName 👋';
  }

  @override
  String get dashboardHighlightTitle => 'आज आपका ट्रैक बहुत अच्छा है!';

  @override
  String get dashboardHighlightSubtitle =>
      'आपके बजट के अनुसार भोजन समायोजित किए गए हैं';

  @override
  String get dashboardQuickActionsTitle => 'त्वरित विकल्प';

  @override
  String get dashboardQuickActionMealPlanTitle => 'मी़ल प्लान';

  @override
  String get dashboardQuickActionMealPlanSubtitle => 'आज के भोजन देखें';

  @override
  String get dashboardQuickActionGroceryTitle => 'किराना';

  @override
  String get dashboardQuickActionGrocerySubtitle => 'खरीदारी सूची';

  @override
  String get dashboardQuickActionBudgetTitle => 'बजट ट्रैकर';

  @override
  String get dashboardQuickActionBudgetSubtitle => 'अपने खर्च पर नज़र रखें';

  @override
  String get dashboardQuickActionPantryTitle => 'पेंट्री मैनेजमेंट';

  @override
  String get dashboardQuickActionPantrySubtitle => 'सामग्री को ट्रैक करें';

  @override
  String get dashboardQuickActionReengineeringTitle => 'मील री-इंजीनियरिंग';

  @override
  String get dashboardQuickActionReengineeringSubtitle =>
      'स्मार्ट भोजन बदलाव देखें';

  @override
  String get dashboardQuickActionInsightsTitle => 'स्वास्थ्य इनसाइट्स';

  @override
  String get dashboardQuickActionInsightsSubtitle =>
      'अपनी स्वास्थ्य प्रगति ट्रैक करें';

  @override
  String get dashboardWhyTheseMealsTitle => 'ये भोजन क्यों?';

  @override
  String get dashboardPantryAlertsTitle => 'पेंट्री अलर्ट';

  @override
  String get dashboardOverviewTitle => 'आज का सारांश';

  @override
  String get timeAM => 'पूर्वाह्न';

  @override
  String get timePM => 'अपराह्न';

  @override
  String get seasonalSectionTitle => 'आपके आसपास के मौसमी विकल्प 🌾';

  @override
  String get seasonalSectionSubtitle =>
      'फरवरी में बेंगलुरु बाज़ारों के आधार पर';

  @override
  String get seasonalButtonAddToGrocery => 'किराना सूची में जोड़ें';

  @override
  String get seasonalSnackAddedToGrocery => 'किराना सूची में जोड़ा गया';

  @override
  String get groceryTitle => 'किराना सूची';

  @override
  String get grocerySearchHint => 'सामग्री खोजें...';

  @override
  String get groceryEmptyTitle => 'कोई आइटम नहीं मिला';

  @override
  String get groceryEmptyMessageDefault =>
      'आपकी किराना सूची खाली है। मील प्लान से आइटम जोड़ें।';

  @override
  String get groceryEmptyMessageFiltered =>
      'आपकी खोज से मेल खाने वाली सामग्री नहीं मिली।';

  @override
  String get groceryEmptyPrimary => 'मील ब्राउज़ करें';

  @override
  String get groceryEmptyClearSearch => 'खोज साफ़ करें';

  @override
  String get groceryFabAddItem => 'आइटम जोड़ें';

  @override
  String get grocerySnackAddedToPantry => 'पेंट्री में जोड़ा गया';

  @override
  String get grocerySnackRemovedFromList => 'सूची से हटाया गया';

  @override
  String get grocerySnackOpeningWhatsApp => 'WhatsApp खोला जा रहा है...';

  @override
  String get grocerySnackOpeningSms => 'SMS खोला जा रहा है...';

  @override
  String get grocerySnackCopiedList => 'सूची क्लिपबोर्ड पर कॉपी की गई';

  @override
  String get groceryShareTitle => 'किराना सूची साझा करें';

  @override
  String get groceryShoppingProgressTitle => 'खरीदारी की प्रगति';

  @override
  String groceryShoppingProgressLabel(int purchased, int total) {
    return '$purchased/$total वस्तुएं';
  }

  @override
  String get deliverySectionTitle => 'डिलिवरी एकीकरण';

  @override
  String get deliverySectionSubtitle =>
      'आपके कार्ट के आधार पर त्वरित वितरण विकल्प';

  @override
  String get deliveryBigBasketTitle => 'BigBasket';

  @override
  String get deliveryBigBasketSubtitle => 'किराने की पूरी रेंज';

  @override
  String get deliveryBigBasketFee => 'शुल्क: ₹30 (₹500 से ऊपर निःशुल्क)';

  @override
  String get deliveryBigBasketEta => 'समय: 4-6 घंटे';

  @override
  String get deliveryBlinkitTitle => 'Blinkit';

  @override
  String get deliveryBlinkitSubtitle => 'तत्काल वितरण';

  @override
  String get deliveryBlinkitFee => 'शुल्क: ₹25 (₹199 से ऊपर निःशुल्क)';

  @override
  String get deliveryBlinkitEta => 'समय: 15-20 मिनट';

  @override
  String get deliveryDMartTitle => 'DMart Ready';

  @override
  String get deliveryDMartSubtitle => 'वैल्यू शॉपिंग';

  @override
  String get deliveryDMartFee => 'पिकअप: निःशुल्क | वितरण: ₹49';

  @override
  String get deliveryDMartEta => 'समय: अगला दिन';

  @override
  String get deliveryAvailableForCart => 'आपके कार्ट आकार के लिए उपलब्ध है';

  @override
  String get deliveryMinOrderNotMet => 'न्यूनतम ऑर्डर राशि पूरी नहीं हुई';

  @override
  String get deliveryUnavailable => 'वर्तमान में आपके क्षेत्र में अनुपलब्ध है';

  @override
  String deliverySelectedLabel(String provider) {
    return 'चयनित डिलवरी: $provider';
  }

  @override
  String get deliveryChipSelected => 'चयनित';

  @override
  String get deliveryChipSelect => 'चुनें';

  @override
  String get profileSetupTitle => 'प्रोफाइल सेटअप';

  @override
  String profileStepOfTotal(int current, int total) {
    return 'कदम $current / $total';
  }

  @override
  String profileStepPercent(int percent) {
    return '$percent%';
  }

  @override
  String get profileContinue => 'आगे बढ़ें';

  @override
  String get profileCompleteSetup => 'सेटअप पूरा करें';

  @override
  String get languageSelectorTitle => 'ऐप भाषा';

  @override
  String get languageSelectorSubtitle =>
      'अपने NutriCart अनुभव के लिए भाषा चुनें';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageKannada => 'कन्नड़';

  @override
  String get languageHindi => 'हिन्दी';

  @override
  String dashboardMealCompletedCount(int completed, int total) {
    return '$total में से $completed भोजन';
  }

  @override
  String get dashboardCalorieConsumed => 'सेवन किया';

  @override
  String get dashboardCalorieRemaining => 'शेष';

  @override
  String dashboardCalorieValue(int value) {
    return '$value किलो कैलोरी';
  }

  @override
  String get dashboardUrgencyHigh => 'उच्च';

  @override
  String get dashboardUrgencyMedium => 'मध्यम';

  @override
  String get dashboardUrgencyLow => 'कम';

  @override
  String get dashboardWeeklyProgressTitle => 'साप्ताहिक प्रगति';

  @override
  String get dashboardWeeklyProgressSubtitle => 'पोषण अनुपालन ट्रैकिंग';

  @override
  String get dashboardWeeklyProgressSemantics =>
      'दैनिक अनुपालन प्रतिशत दिखाते हुए साप्ताहिक पोषण अनुपालन बार चार्ट';

  @override
  String get dashboardLegendExcellent => 'उत्कृष्ट';

  @override
  String get dashboardLegendGood => 'अच्छा';

  @override
  String get dashboardLegendNeedsImprovement => 'सुधार की आवश्यकता';

  @override
  String get dashboardLoading => 'लोड हो रहा है...';

  @override
  String get dashboardOffline => 'ऑफ़लाइन';

  @override
  String get groceryCategoryVegetables => 'सब्जियां';

  @override
  String get groceryCategoryGrains => 'अनाज';

  @override
  String get groceryCategorySpices => 'मसाले';

  @override
  String get groceryCategoryDairy => 'डेयरी';

  @override
  String get groceryBudgetSummaryTitle => 'बजट सारांश';

  @override
  String get groceryWeeklyEstimate => 'साप्ताहिक अनुमान';

  @override
  String get groceryMonthlyBudget => 'मासिक बजट';

  @override
  String get grocerySpent => 'खर्च किया';

  @override
  String get groceryRemaining => 'शेष';

  @override
  String get groceryCurrency => '₹';

  @override
  String get groceryBudgetFriendlyTitle => 'बजट-अनुकूल विकल्प';

  @override
  String groceryBudgetExceedsMessage(String amount) {
    return 'आपकी वर्तमान सूची बजट से $amount अधिक है। इन विकल्पों पर विचार करें:';
  }

  @override
  String grocerySaveAmount(String amount) {
    return '$amount बचाएं';
  }

  @override
  String groceryTotal(String amount) {
    return 'कुल: $amount';
  }

  @override
  String groceryShareGeneratedBy(String appName, String date) {
    return '$date को $appName द्वारा जनरेट किया गया';
  }

  @override
  String get profilePersonalDetails => 'व्यक्तिगत विवरण';

  @override
  String get profileHealthConditions => 'स्वास्थ्य स्थितियाँ';

  @override
  String get profileDietaryPreferences => 'आहार प्राथमिकताएं';

  @override
  String get profileAllergies => 'एलर्जी';

  @override
  String get profileBudget => 'बजट';

  @override
  String get profileBudgetTitle => 'मासिक भोजन बजट';

  @override
  String get profileAge => 'आयु';

  @override
  String get profileWeight => 'वजन';

  @override
  String get profileGender => 'लिंग';

  @override
  String get profileGenderMale => 'पुरुष';

  @override
  String get profileGenderFemale => 'महिला';

  @override
  String get profileHealthDiabetes => 'मधुमेह';

  @override
  String get profileHealthPCOS => 'पीसीओएस';

  @override
  String get profileHealthHypertension => 'उच्च रक्तचाप';

  @override
  String get profileHbA1c => 'HbA1c स्तर';

  @override
  String get profileDietVegetarian => 'शाकाहारी';

  @override
  String get profileDietVegan => 'वीगन';

  @override
  String get profileMonthlyBudgetLabel => 'मासिक बजट दर्ज करें';

  @override
  String profileUnitKg(double value) {
    return '$value किग्रा';
  }

  @override
  String profileUnitYears(int value) {
    return '$value वर्ष';
  }

  @override
  String get dashboardModalMarkComplete => 'पूरा चिह्नित करें';

  @override
  String get dashboardModalSkipMeal => 'भोजन छोड़ें';

  @override
  String get dashboardModalRequestAlternative => 'विकल्प का अनुरोध करें';

  @override
  String profileUnitDays(int value) {
    return '$value दिन';
  }

  @override
  String get groceryBudgetOverview => 'बजट सारांश';

  @override
  String groceryUsedPercent(int percent) {
    return '$percent% उपयोग किया गया';
  }

  @override
  String get groceryAvgDay => 'औसत/दिन';

  @override
  String get groceryDaysLeftLabel => 'दिन शेष';

  @override
  String get mockRecentMeal1Name => 'दाल तड़का के साथ ब्राउन राइस';

  @override
  String get mockRecentMeal1Explanation =>
      'प्रोटीन और फाइबर में उच्च, रक्त शर्करा के स्तर को प्रबंधित करने में मदद करता है। दाल PCOS प्रबंधन के लिए आवश्यक अमीनो एसिड प्रदान करती है।';

  @override
  String get mockRecentMeal1Timestamp => '2 घंटे पहले';

  @override
  String get mockRecentMeal2Name => 'ओट्स उपमा';

  @override
  String get mockRecentMeal2Explanation =>
      'कम ग्लाइसेमिक इंडेक्स वाला नाश्ता आपको लंबे समय तक भरा रखता है और शुगर स्पाइक्स को रोकता है। हृदय स्वास्थ्य के लिए बीटा-ग्लूकन से भरपूर।';

  @override
  String get mockRecentMeal2Timestamp => '5 घंटे पहले';

  @override
  String get mockSeasonalPick1Name => 'सर्दियों के खट्टे फल';

  @override
  String get mockSeasonalPick1Type => 'फल';

  @override
  String get mockSeasonalPick1Tag => 'सर्दियों के खट्टे फल';

  @override
  String get mockSeasonalPick1Descriptor => 'बैंगलोर के आसपास फरवरी में मौसमी';

  @override
  String get mockSeasonalPick2Name => 'ताजा पालक';

  @override
  String get mockSeasonalPick2Type => 'सब्जी';

  @override
  String get mockSeasonalPick2Tag => 'सर्दियों की पत्तेदार सब्जी';

  @override
  String get mockSeasonalPick2Descriptor => 'फरवरी में कोमल गुच्छे';

  @override
  String get seasonalFruit => 'फल';

  @override
  String get seasonalVegetable => 'सब्जी';

  @override
  String get seasonalTagPeakSeason => 'चरम सीजन';

  @override
  String get seasonalDescriptorPeakFeb => 'फरवरी के अंत में चरम उपलब्धता';

  @override
  String get seasonalTagLocallyAbundant => 'स्थानीय रूप से प्रचुर मात्रा में';

  @override
  String get seasonalDescriptorCityMarkets =>
      'शहर के बाजारों में निरंतर आपूर्ति';

  @override
  String get groceryWeeklyBudget => 'साप्ताहिक बजट';

  @override
  String get groceryOverBudget => 'बजट से बाहर';

  @override
  String get groceryEstimated => 'अनुमानित';

  @override
  String get grocerySaveMore => 'अधिक बचत करें';

  @override
  String groceryPurchasedStatus(int count, int total) {
    return '$count/$total खरीदा गया';
  }

  @override
  String get groceryEditQuantity => 'मात्रा संपादित करें';

  @override
  String get groceryFindAlternatives => 'विकल्प खोजें';

  @override
  String get groceryAddNotes => 'नोट्स जोड़ें';

  @override
  String get groceryPantry => 'पेंट्री';

  @override
  String get groceryRemove => 'हटाएं';

  @override
  String groceryAlternativesTitle(String name) {
    return '$name के लिए विकल्प';
  }

  @override
  String get groceryNoAlternatives => 'कोई विकल्प उपलब्ध नहीं है';

  @override
  String grocerySwitchedTo(String name) {
    return '$name पर स्विच किया गया';
  }

  @override
  String get groceryClose => 'बंद करें';

  @override
  String get groceryCategoryProduce => 'उपज';

  @override
  String get groceryCategoryMeat => 'मांस';

  @override
  String get groceryCategoryBakery => 'बेकरी';

  @override
  String get groceryCategoryFrozen => 'फ्रोजन';

  @override
  String get groceryCategoryBeverages => 'पेय पदार्थ';

  @override
  String get mockGroceryOnions => 'प्याज';

  @override
  String get mockGroceryTomatoes => 'टमाटर';

  @override
  String get mockGroceryBasmatiRice => 'बासमती चावल';

  @override
  String get mockGroceryWholeWheatFlour => 'गेहूं का आटा';

  @override
  String get mockGroceryTurmericPowder => 'हल्दी पाउडर';

  @override
  String get mockGroceryCuminSeeds => 'जीरा';

  @override
  String get mockGroceryGaramMasala => 'गरम मसाला';

  @override
  String get mockGroceryMilk => 'दूध';

  @override
  String get mockGroceryYogurt => 'दही';

  @override
  String get mockGroceryPaneer => 'पनीर';

  @override
  String get profilePersonalSubtitle =>
      'बुनियादी जानकारी के साथ अपने भोजन योजनाओं को निजीकृत करने में हमारी सहायता करें';

  @override
  String get profileAgeLabel => 'आयु *';

  @override
  String get profileAgeHint => 'अपनी आयु दर्ज करें';

  @override
  String get profileAgeRequired => 'आयु आवश्यक है';

  @override
  String get profileAgeInvalid => 'कृपया वैध आयु दर्ज करें (18-100)';

  @override
  String get profileGenderLabel => 'लिंग *';

  @override
  String get profileGenderOther => 'अन्य';

  @override
  String get profileWeightLabel => 'वजन (किलोग्राम) *';

  @override
  String get profileWeightHint => 'अपना वजन दर्ज करें';

  @override
  String get profileWeightRequired => 'वजन आवश्यक है';

  @override
  String get profileWeightInvalid =>
      'कृपया वैध वजन दर्ज करें (30-200 किलोग्राम)';

  @override
  String get profileWhyNeedInfo => 'हमें यह जानकारी क्यों चाहिए?';

  @override
  String get profileUsageTitle => 'व्यक्तिगत जानकारी का उपयोग';

  @override
  String get profileUsageAge =>
      'आयु हमें आपकी दैनिक कैलोरी आवश्यकताओं और पोषण संबंधी आवश्यकताओं की गणना करने में मदद करती है';

  @override
  String get profileUsageGender =>
      'लिंग चयापचय दर और विशिष्ट पोषक तत्वों की जरूरतों को प्रभावित करता है';

  @override
  String get profileUsageWeight =>
      'हिस्सा नियंत्रण और व्यक्तिगत भोजन योजना के लिए वजन आवश्यक है';

  @override
  String get profileUsageSecurity =>
      'सभी डेटा एन्क्रिप्टेड है और केवल आपके भोजन की सिफारिशों के लिए उपयोग किया जाता है';

  @override
  String get profileHealthSubtitle =>
      'किसी भी स्वास्थ्य स्थिति का चयन करें जिसे आप प्रबंधित करते हैं (वैकल्पिक)';

  @override
  String get profileHealthDiabetesDesc => 'टाइप 1 या टाइप 2 मधुमेह';

  @override
  String get profileHealthPCOSDesc => 'पॉलीसिस्टिक ओवरी सिंड्रोम';

  @override
  String get profileHealthHypertensionDesc => 'उच्च रक्तचाप';

  @override
  String get profileHealthAnemia => 'एनीमिया';

  @override
  String get profileHealthAnemiaDesc => 'आयरन की कमी';

  @override
  String get profileHealthThyroid => 'थायराइड';

  @override
  String get profileHealthThyroidDesc => 'थायराइड विकार';

  @override
  String get profileHealthHeart => 'हृदय रोग';

  @override
  String get profileHealthHeartDesc => 'हृदय संबंधी स्थितियां';

  @override
  String get profileHbA1cLabel => 'HbA1c स्तर (वैकल्पिक)';

  @override
  String get profileHbA1cHint => 'अपना HbA1c स्तर दर्ज करें (जैसे, 6.5)';

  @override
  String get profileHbA1cInfo =>
      'यह हमें मधुमेह प्रबंधन के लिए अधिक सटीक भोजन अनुशंसाएं प्रदान करने में मदद करता है';

  @override
  String get profileSafetyTitle => 'चिकित्सा पोषण सुरक्षा';

  @override
  String get profileSafetyCondition =>
      'स्वास्थ्य स्थितियां आपकी पोषण संबंधी आवश्यकताओं और भोजन प्रतिबंधों को प्रभावित करती हैं';

  @override
  String get profileSafetyCompliance =>
      'हम सुनिश्चित करते हैं कि भोजन योजनाएं चिकित्सा पोषण दिशानिर्देशों का अनुपालन करती हैं';

  @override
  String get profileSafetyPrevention =>
      'उन खाद्य पदार्थों को सुझाने से रोकता है जो आपकी स्थिति को खराब कर सकते हैं';

  @override
  String get profileSafetyBalance =>
      'आपकी स्वास्थ्य आवश्यकताओं के लिए विशिष्ट पोषक तत्वों को संतुलित करने में मदद करता है';

  @override
  String get profileSafetyGuidelines =>
      'सभी सिफारिशें जीवनशैली रोगों के लिए भारतीय आहार दिशानिर्देशों का पालन करती हैं';

  @override
  String get profileDietSubtitle =>
      'अपनी आहार वरीयताओं का चयन करें (कम से कम एक आवश्यक)';

  @override
  String get profileDietVeg => 'शाकाहारी';

  @override
  String get profileDietVegDesc => 'कोई मांस, मछली या मुर्गी नहीं';

  @override
  String get profileDietVeganDesc => 'कोई पशु उत्पाद नहीं';

  @override
  String get profileDietJain => 'जैन';

  @override
  String get profileDietJainDesc => 'कोई कंदमूल (जड़ वाली सब्जियां) नहीं';

  @override
  String get profileDietEgg => 'अंडे के साथ शाकाहारी';

  @override
  String get profileDietEggDesc => 'अंडे के साथ शाकाहारी';

  @override
  String get profileDietNonVeg => 'माँसाहारी';

  @override
  String get profileDietNonVegDesc => 'सभी खाद्य प्रकार शामिल हैं';

  @override
  String get profileDietPescatarian => 'पेस्केटेरियन';

  @override
  String get profileDietPescatarianDesc => 'मछली के साथ शाकाहारी';

  @override
  String get profileDietMultipleInfo =>
      'आप कई वरीयताओं का चयन कर सकते हैं। उदाहरण के लिए, शाकाहारी + जैन या एगेटेरियन + पेस्केटेरियन।';

  @override
  String get profileDietImportanceTitle => 'आहार वरीयता महत्व';

  @override
  String get profileDietImportanceRespect =>
      'सुनिश्चित करता है कि सभी भोजन सुझाव आपकी आहार पसंद का सम्मान करते हैं';

  @override
  String get profileDietImportanceFilter =>
      'उन सामग्रियों को फ़िल्टर करता है जो आपकी पसंद से मेल नहीं खाती हैं';

  @override
  String get profileDietImportanceCultural =>
      'सांस्कृतिक रूप से उपयुक्त भारतीय भोजन विकल्प प्रदान करता है';

  @override
  String get profileDietImportanceBalance =>
      'आपके आहार ढांचे के भीतर पोषण संतुलन बनाए रखने में मदद करता है';

  @override
  String get profileDietImportanceReligious =>
      'धार्मिक और नैतिक भोजन विकल्पों का समर्थन करता है';

  @override
  String get profileBudgetSubtitle =>
      'स्मार्ट भोजन योजना के लिए अपना मासिक भोजन बजट निर्धारित करें';

  @override
  String get profileBudgetAmountLabel => 'बजट राशि दर्ज करें *';

  @override
  String get profileBudgetAmountHint => 'अपना मासिक भोजन बजट दर्ज करें';

  @override
  String get profileBudgetAmountRequired => 'बजट आवश्यक है';

  @override
  String get profileBudgetAmountMin => 'न्यूनतम बजट ₹1,000 है';

  @override
  String get profileBudgetAmountMax => 'अधिकतम बजट ₹1,00,000 है';

  @override
  String get profileBudgetQuickSelect => 'त्वरित चयन';

  @override
  String get profileBudgetBreakdownTitle => 'बजट विवरण';

  @override
  String get profileBudgetDaily => 'दैनिक बजट';

  @override
  String get profileBudgetWeekly => 'साप्ताहिक बजट';

  @override
  String get profileBudgetPerMeal => 'प्रति भोजन (लगभग)';

  @override
  String get profileBudgetSavingsInfo =>
      'हम बजट के अनुकूल सामग्री प्रतिस्थापन का सुझाव देंगे और पूरे महीने खर्च को ट्रैक करने में आपकी मदद करेंगे।';

  @override
  String get profileBudgetAwareTitle => 'बजट-जागरूक योजना';

  @override
  String get profileBudgetAwareSuggest =>
      'ऐसे भोजन का सुझाव देता है जो आपके मासिक बजट में फिट हों';

  @override
  String get profileBudgetAwareCost =>
      'लागत प्रभावी सामग्री विकल्प प्रदान करता है';

  @override
  String get profileBudgetAwareTrack =>
      'पूरे महीने किराने के खर्च को ट्रैक करने में मदद करता है';

  @override
  String get profileBudgetAwareOptimize =>
      'न्यूनतम लागत पर अधिकतम पोषण के लिए भोजन योजनाओं को अनुकूलित करता है';

  @override
  String get profileBudgetAwarePrevent =>
      'किराने के सामान पर अधिक खर्च को रोकता है';

  @override
  String get profileAllergyTitle => 'एलर्जी और असहिष्णुता';

  @override
  String get profileAllergySubtitle =>
      'किसी भी खाद्य एलर्जी या असहिष्णुता का चयन करें (वैकल्पिक)';

  @override
  String get profileAllergySearchHint => 'खोजें या कस्टम एलर्जी जोड़ें';

  @override
  String get profileAllergySelected => 'चयनित एलर्जी';

  @override
  String get profileAllergyCommon => 'सामान्य एलर्जी';

  @override
  String get profileAllergyWarning =>
      'सभी भोजन योजनाएं स्वचालित रूप से उन सामग्रियों को बाहर कर देंगी जिनसे आपको एलर्जी है। कृपया गंभीर एलर्जी के लिए अपने डॉक्टर से परामर्श करें।';

  @override
  String get profileAllergySafetyTitle => 'एलर्जी सुरक्षा';

  @override
  String get profileAllergySafetyPrevents =>
      'आपको नुकसान पहुँचाने वाले एलर्जी वाले भोजन के सुझाव को रोकता है';

  @override
  String get profileAllergySafetyFilters =>
      'स्वचालित रूप से सभी अनुशंसाओं से असुरक्षित सामग्री को फ़िल्टर करता है';

  @override
  String get profileAllergySafetySubstitutions =>
      'भोजन योजनाओं में सुरक्षित सामग्री प्रतिस्थापन प्रदान करता है';

  @override
  String get profileAllergySafetyExclude =>
      'सुनिश्चित करता है कि किराने की सूचियों में एलर्जी वाली वस्तुएं शामिल नहीं हैं';

  @override
  String get profileAllergySafetyCritical =>
      'आपके स्वास्थ्य और सुरक्षा के लिए महत्वपूर्ण';

  @override
  String get allergyPeanuts => 'मूँगफली';

  @override
  String get allergyTreeNuts => 'ट्री नट्स';

  @override
  String get allergyMilk => 'दूध';

  @override
  String get allergyEggs => 'अंडे';

  @override
  String get allergyWheat => 'गेहूँ';

  @override
  String get allergySoy => 'सोया';

  @override
  String get allergyFish => 'मछली';

  @override
  String get allergyShellfish => 'शेलफिश';

  @override
  String get allergySesame => 'तिल';

  @override
  String get allergyMustard => 'सरसों';

  @override
  String get allergyGluten => 'ग्लूटेन';

  @override
  String get allergyLactose => 'लैक्टोज';

  @override
  String get allergyCorn => 'मकई';

  @override
  String get allergyGarlic => 'लहसुन';

  @override
  String get allergyOnion => 'प्याज';

  @override
  String get allergyTomato => 'टमाटर';

  @override
  String get allergyCitrus => 'खट्टे फल';

  @override
  String get allergyStrawberries => 'स्ट्रॉबेरी';

  @override
  String get allergyChocolate => 'चॉकलेट';

  @override
  String get allergyCaffeine => 'कैफीन';

  @override
  String get mockGroceryGinger => 'अदरक';

  @override
  String get mockGroceryGreenChillies => 'हरी मिर्च';

  @override
  String get mockGroceryCorianderLeaves => 'धनिया पत्ती';

  @override
  String get mockGroceryReasonFreq => 'अक्सर खरीदा जाता है';

  @override
  String mockGroceryReasonOften(String item) {
    return 'अक्सर $item के साथ खरीदा जाता है';
  }

  @override
  String get mockGroceryReasonPlan => 'आपके भोजन योजना के पूरक';

  @override
  String get loadingGeneral => 'लोड हो रहा है...';

  @override
  String groceryExceedsBudgetInfo(String amount) {
    return 'आपकी वर्तमान सूची बजट से $amount अधिक है। इन विकल्पों पर विचार करें:';
  }

  @override
  String grocerySubstitutionPrompt(String item1, String item2) {
    return '$item1 को $item2 में बदलें?';
  }

  @override
  String get groceryImpactMinimal => 'स्वाद पर प्रभाव न्यूनतम है';

  @override
  String get groceryCategoryPantry => 'पेंट्री स्टेपल';

  @override
  String get groceryItemBrownRice => 'ब्राउन राइस';

  @override
  String get groceryItemMoongDal => 'मूंग दाल';

  @override
  String get groceryItemSpinach => 'पालक';

  @override
  String get groceryItemCarrots => 'गाजर';

  @override
  String get groceryBudgetFriendlyAlts => 'बजट के अनुकूल विकल्प';

  @override
  String get mealPlanTitle => 'दैनिक भोजन योजना';

  @override
  String get mealPlanNoPlan => 'कोई भोजन योजना उपलब्ध नहीं है';

  @override
  String get mealPlanBreakfast => 'नाश्ता';

  @override
  String get mealPlanLunch => 'दोपहर का भोजन';

  @override
  String get mealPlanDinner => 'रात का भोजन';

  @override
  String get mealPlanSnacks => 'स्नैक्स';

  @override
  String get mealPlanToday => 'आज';

  @override
  String get mealPlanPrevDay => 'पिछला दिन';

  @override
  String get mealPlanNextDay => 'अगला दिन';

  @override
  String get mealPlanWhyMeal => 'यही भोजन क्यों?';

  @override
  String get mealPlanCookingSteps => 'पकाने के चरण';

  @override
  String get mealPlanListenInstructions => 'निर्देश सुनें';

  @override
  String get mealPlanIngredients => 'सामग्री';

  @override
  String mealPlanAddCount(int count) {
    return 'जोड़ें ($count)';
  }

  @override
  String mealPlanCanSubstitute(String item) {
    return '$item का उपयोग कर सकते हैं';
  }

  @override
  String get mealPlanLongPressSelect =>
      'ग्रोसरी लिस्ट के लिए सामग्री चुनने के लिए देर तक दबाएं';

  @override
  String get mealPlanPrepTime => 'तैयारी का समय';

  @override
  String get mealPlanServings => 'सर्विंग्स';

  @override
  String get mealPlanCalories => 'कैलोरी';

  @override
  String mealPlanKcalValue(String value) {
    return '$value किलोकैलोरी';
  }

  @override
  String get mealPlanFeedbackTitle => 'भोजन फीडबैक';

  @override
  String get mealPlanEaten => 'खाया';

  @override
  String get mealPlanPartial => 'आंशिक';

  @override
  String get mealPlanSkipped => 'छोड़ दिया';

  @override
  String get mealPlanAdaptFeedback =>
      'योजना आपके फीडबैक के आधार पर अनुकूलित होगी';

  @override
  String mealPlanKcal(String value) {
    return '$value किलो कैलोरी';
  }

  @override
  String mealPlanRupee(String value) {
    return '₹$value';
  }

  @override
  String get mealPlanBudgetWithin => 'बजट के भीतर - बहुत अच्छा!';

  @override
  String mealPlanBudgetExceeded(String amount) {
    return 'बजट ₹$amount से अधिक हो गया';
  }

  @override
  String get mealPlanSummaryTitle => 'दैनिक सारांश';

  @override
  String get mealPlanTotalCalories => 'कुल कैलोरी';

  @override
  String get mealPlanTotalCost => 'कुल लागत';

  @override
  String get mealPlanAISelectedHeader =>
      'हमारे AI ने इन मापदंडों के आधार पर भोजन चुना:';

  @override
  String get mealPlanWhyToday => 'आज के भोजन का कारण';

  @override
  String get mealPlanReason1 =>
      'प्रोटीन युक्त नाश्ता आपके पीसीओएस प्रबंधन में मदद करता है और पेट भरा रखता है';

  @override
  String get mealPlanReason2 =>
      'दोपहर के भोजन में संतुलित पोषक तत्वों के साथ मधुमेह नियंत्रण के लिए उपयुक्त खाद्य पदार्थ शामिल हैं';

  @override
  String get mealPlanReason3 =>
      'रात का खाना हल्का और पौष्टिक है, जो बेहतर नींद और पाचन को बढ़ावा देता है';

  @override
  String get mealPlanReason4 =>
      'सभी भोजन पोषण लक्ष्यों को पूरा करते हुए आपके दैनिक बजट के भीतर हैं';

  @override
  String get mealPlanOatsUpma => 'सब्जियों के साथ ओट्स उपमा';

  @override
  String get mealPlanMoongDalCheela => 'पुदीने की चटनी के साथ मूंग दाल चीला';

  @override
  String get mealPlanRagiDosa => 'सांभर के साथ रागी डोसा';

  @override
  String get mealPlanBrownRiceDal => 'दाल तड़का और सलाद के साथ ब्राउन राइस';

  @override
  String get mealPlanQuinoaPulao => 'रायता के साथ क्विनोआ पुलाव';

  @override
  String get mealPlanGrilledChicken => 'मल्टीग्रेन रोटी के साथ ग्रिल्ड चिकन';

  @override
  String get mealPlanPalakPaneer => 'रोटी के साथ पालक पनीर';

  @override
  String get mealPlanVegKhichdi => 'दही के साथ वेजिटेबल खिचड़ी';

  @override
  String get mealPlanGrilledFish => 'उबली हुई सब्जियों के साथ ग्रिल्ड फिश';

  @override
  String get mealPlanMixedNuts => 'मिश्रित मेवे और बीज';

  @override
  String get mealPlanFruitSalad => 'दही के साथ फ्रूट सलाद';

  @override
  String get mealPlanRoastedChickpeas => 'भुने हुए चने';

  @override
  String get mealPlanDiabetesSafe => 'मधुमेह के लिए सुरक्षित';

  @override
  String get mealPlanPCOSFriendly => 'पीसीओएस-अनुकूल';

  @override
  String get mealPlanHeartHealthy => 'हृदय के लिए स्वस्थ';

  @override
  String get mealPlanIronRich => 'आयरन से भरपूर';

  @override
  String get mealPlanHighProtein => 'उच्च प्रोटीन';

  @override
  String get mealPlanVitaminRich => 'विटामिन से भरपूर';

  @override
  String get mealPlanHighFiber => 'उच्च फाइबर';

  @override
  String get mealPlanOatsUpmaSummary =>
      'कम ग्लाइसेमिक इंडेक्स वाला नाश्ता जो आपका पेट भरा रखता है और शुगर को बढ़ने से रोकता है।';

  @override
  String get mealPlanOatsUpmaReason1 =>
      'ओट्स और सब्जियों से प्राप्त उच्च फाइबर';

  @override
  String get mealPlanOatsUpmaReason2 => 'ग्लूकोज का धीमा अवशोषण';

  @override
  String get mealPlanOatsUpmaReason3 => 'आवश्यक खनिजों से भरपूर';

  @override
  String get mealPlanBrownRiceSummary =>
      'जटिल कार्ब्स और पौधे-आधारित प्रोटीन प्रदान करने वाला संतुलित भोजन।';

  @override
  String get mealPlanBrownRiceReason1 => 'तृप्ति के लिए प्रोटीन युक्त दाल';

  @override
  String get mealPlanBrownRiceReason2 => 'ब्राउन राइस और सलाद से फाइबर';

  @override
  String get mealPlanBrownRiceReason3 => 'पूर्ण अमीनो एसिड प्रोफाइल';

  @override
  String get mealPlanRoastedMakhanaSummary =>
      'एंटीऑक्सीडेंट से भरपूर हल्का, जलनरोधी नाश्ता।';

  @override
  String get mealPlanRoastedMakhanaReason1 => 'ग्रीन टी से एंटीऑक्सीडेंट';

  @override
  String get mealPlanRoastedMakhanaReason2 => 'कम कैलोरी घनत्व';

  @override
  String get mealPlanRoastedMakhanaReason3 => 'मखाने से मैंगनीज और प्रोटीन';

  @override
  String get mealPlanPalakPaneerSummary =>
      'प्रोटीन और आयरन से भरपूर रात का भोजन जो मांसपेशियों की मरम्मत और हार्मोनल स्वास्थ्य का समर्थन करता है।';

  @override
  String get mealPlanPalakPaneerReason1 => 'पालक से आयरन';

  @override
  String get mealPlanPalakPaneerReason2 => 'पनीर से प्रोटीन';

  @override
  String get mealPlanPalakPaneerReason3 => 'दही से प्रोबायोटिक्स';

  @override
  String get mockIngredientOats => 'ओट्स';

  @override
  String get mockIngredientMustardSeeds => 'सरसों के बीज';

  @override
  String get mockIngredientCurryLeaves => 'करी पत्ता';

  @override
  String get mockIngredientGreenChili => 'हरी मिर्च';

  @override
  String get mockIngredientPhoolMakhana => 'फूल मखाना';

  @override
  String get mockIngredientGreenTeaBag => 'ग्रीन टी बैग';

  @override
  String get mockIngredientBlackSalt => 'काला नमक और काली मिर्च';

  @override
  String get mockIngredientGhee => 'घी / जैतून का तेल';

  @override
  String get mockIngredientCucumber => 'खीरा';

  @override
  String get mockIngredientPalakPuree => 'पालक की प्यूरी';

  @override
  String get mockIngredientPaneerCubes => 'पनीर के टुकड़े';

  @override
  String get mockInstructionDryRoast =>
      'ओट्स को हल्का सुनहरा होने तक 2-3 मिनट तक सूखा भून लें।';

  @override
  String get mockInstructionTadka =>
      'तेल गरम करें, सरसों के दाने, करी पत्ता और हरी मिर्च डालें।';

  @override
  String get mockInstructionSauteVeg =>
      'प्याज और सब्जियां डालें, नरम होने तक भूनें।';

  @override
  String get mockInstructionBoilWater =>
      'पानी और नमक डालें, उबाल आने दें। भुने हुए ओट्स डालें।';

  @override
  String get mockInstructionCookOats =>
      'पानी सूखने और ओट्स के नरम होने तक पकाएं।';

  @override
  String get mockInstructionCookBrownRice => 'निर्देशानुसार ब्राउन राइस पकाएं।';

  @override
  String get mockInstructionPressureCookDal =>
      'हल्दी और नमक के साथ दाल को प्रेशर कुक करें।';

  @override
  String get mockInstructionPerformTadka =>
      'थोड़े से घी/तेल में जीरा और लहसुन के साथ तड़का लगाएं।';

  @override
  String get mockInstructionPrepareSalad =>
      'कटे हुए खीरे और टमाटर के साथ ताज़ा सलाद तैयार करें।';

  @override
  String get mockInstructionRoastMakhana =>
      'एक पैन में घी गरम करें और मखानों को कुरकुरा होने तक भूनें।';

  @override
  String get mockInstructionSeasonMakhana =>
      'गरम होने पर काला नमक और काली मिर्च डालें।';

  @override
  String get mockInstructionBrewTea =>
      'गर्म पानी में ग्रीन टी बैग को 2-3 मिनट के लिए डुबोएं।';

  @override
  String get mockInstructionPreparePalakPaneer =>
      'मसालों और पनीर के साथ पालक पनीर ग्रेवी तैयार करें।';

  @override
  String get mockInstructionMakeRotis => 'तवे पर ताज़ा रोटियां बनाएं।';

  @override
  String get mockInstructionMixRaita =>
      'रायते के लिए फेंटे हुए दही में कद्दूकस किया हुआ खीरा मिलाएं।';

  @override
  String get mockBenefitInsulin =>
      'धीमी ऊर्जा रिलीज इंसुलिन के स्तर को बढ़ने से रोकती है।';

  @override
  String get mockBenefitSatiety =>
      'उच्च फाइबर सामग्री तृप्ति को बढ़ावा देती है।';

  @override
  String get mockBenefitDigestion =>
      'उच्च फाइबर पाचन क्रिया को सुगम बनाने में मदद करता है।';

  @override
  String get mockBenefitHormonal =>
      'पोषक तत्व PCOS प्रबंधन में सहायता करते हैं।';

  @override
  String get mockBenefitOxidative =>
      'ग्रीन टी ऑक्सीडेटिव तनाव को कम करने में मदद करती है।';

  @override
  String get mockBenefitMindful =>
      'कुरकुरी बनावट कम कैलोरी के साथ क्रेविंंग को संतुष्ट करती है।';

  @override
  String get mockBenefitIron => 'पालक पौधे-आधारित आयरन का एक समृद्ध स्रोत है।';

  @override
  String get mockBenefitGutHealth =>
      'रायता बेहतर पाचन के लिए प्रोबायोटिक्स प्रदान करता है।';

  @override
  String get mockConditionDigestion => 'पाचन';

  @override
  String get mockConditionHormonal => 'हार्मोनल संतुलन';

  @override
  String get mockConditionInflammation => 'जलन';

  @override
  String get mockConditionMindful => 'सचेत स्नैकिंग';

  @override
  String get mockConditionIron => 'आयरन की कमी';

  @override
  String get mockConditionGutHealth => 'पेट का स्वास्थ्य';

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
      'ताजे फल एंटीऑक्सीडेंट और प्राकृतिक मिठास प्रदान करते हैं';

  @override
  String get mealPlanRoastedChickpeasExpl =>
      'फाइबर युक्त स्नैक जो आपको भोजन के बीच भरा रखता है';

  @override
  String get insightsTitle => 'स्वास्थ्य जानकारी';

  @override
  String get insightsRefreshTooltip => 'जानकारी ताज़ा करें';

  @override
  String get insightsYourHealthScore => 'आपका स्वास्थ्य स्कोर';

  @override
  String insightsWeeklyChange(String value) {
    return 'इस सप्ताह $value अंक';
  }

  @override
  String get insightsHealthConditions => 'स्वास्थ्य की स्थिति';

  @override
  String get insightsNutrientBalance => 'पोषक तत्व संतुलन';

  @override
  String get insightsWeeklyTrends => 'साप्ताहिक रुझान';

  @override
  String get insightsPersonalizedInsights => 'व्यक्तिगत जानकारी';

  @override
  String get insightsRecommendations => 'सिफारिशें';

  @override
  String get insightsDietAdherence => 'आहार का पालन';

  @override
  String get insightsNutrientTracking => 'दैनिक पोषक तत्व ट्रैकिंग';

  @override
  String get insightsStatusWithinRange => 'सीमा के भीतर';

  @override
  String get insightsStatusBorderline => 'सीमा रेखा पर';

  @override
  String get insightsStatusNeedsImprovement => 'सुधार की आवश्यकता';

  @override
  String get insightsStatusStable => 'स्थिर';

  @override
  String get insightsStatusImproving => 'सुधर रहा है';

  @override
  String get insightsStatusNeedsAttention => 'ध्यान देने की आवश्यकता';

  @override
  String get insightsTrendImproving => 'सुधर रहा है';

  @override
  String get insightsTrendDeclining => 'कम हो रहा है';

  @override
  String get insights7DayTrends => '7-दिवसीय रुझान';

  @override
  String get insightsTabAdherence => 'अनुपालन';

  @override
  String get insightsTabCalories => 'कैलोरी';

  @override
  String get insightsTabBudget => 'बजट';

  @override
  String get insightsNoData => 'कोई डेटा उपलब्ध नहीं';

  @override
  String get insightsDefaultTitle => 'जानकारी';

  @override
  String get insightsActionable => 'कार्रवाई योग्य';

  @override
  String get insightsDefaultRecommendation => 'सिफारिश';

  @override
  String get mockInsightConsistentTimingTitle => 'लगातार भोजन का समय';

  @override
  String get mockInsightConsistentTimingDesc =>
      'आपने 6 दिनों तक नियमित भोजन का समय बनाए रखा है। यह रक्त शर्करा के स्तर को स्थिर करने में मदद करता है।';

  @override
  String get mockInsightFiberLowTitle => 'फाइबर का सेवन लक्ष्य से कम';

  @override
  String get mockInsightFiberLowDesc =>
      'आपका फाइबर सेवन लक्ष्य का 73% है। अधिक सब्जियां और साबुत अनाज जोड़ने पर विचार करें।';

  @override
  String get mockInsightBudgetOptTitle => 'बजट अनुकूलन';

  @override
  String get mockInsightBudgetOptDesc =>
      'आप पोषण संबंधी लक्ष्यों को पूरा करते हुए बजट के भीतर रह रहे हैं। बेहतरीन संतुलन!';

  @override
  String get mockInsightSugarHighTitle => 'चीनी का सेवन अधिक';

  @override
  String get mockInsightSugarHighDesc =>
      'दैनिक चीनी का सेवन लक्ष्य से 29% अधिक है। मीठे पेय और मिठाइयों को कम करने का प्रयास करें।';

  @override
  String get mockRecFiberIncreaseTitle => 'फाइबर का सेवन बढ़ाएं';

  @override
  String get mockRecFiberIncreaseDesc =>
      'दोपहर और रात के खाने में 1 कप मिश्रित सब्जियां जोड़ें। सफेद चावल को भूरे चावल (ब्राउन राइस) में बदलने का प्रयास करें।';

  @override
  String get mockRecSugarReduceTitle => 'अतिरिक्त चीनी कम करें';

  @override
  String get mockRecSugarReduceDesc =>
      'मीठे पेय पदार्थों को हर्बल चाय या इन्फ्यूज्ड पानी से बदलें। फलों के रस के बजाय ताजे फल चुनें।';

  @override
  String get mockRecProteinMaintainTitle => 'वर्तमान प्रोटीन स्तर बनाए रखें';

  @override
  String get mockRecProteinMaintainDesc =>
      'आपका प्रोटीन सेवन उत्कृष्ट है। अपने भोजन में दाल, पनीर और अंडे शामिल करना जारी रखें।';

  @override
  String get mockRecHydrateTitle => 'हाइड्रेटेड रहें';

  @override
  String get mockRecHydrateDesc =>
      'चयापचय और पोषक तत्वों के अवशोषण में सहायता के लिए प्रतिदिन 8-10 गिलास पानी पीने का लक्ष्य रखें।';

  @override
  String get adaptivePlanActive => 'अनुकूली योजना सक्रिय';

  @override
  String get adaptivePersonalized => 'व्यक्तिगत';

  @override
  String get adaptiveAdjustedDesc =>
      'आपकी खाने की आदतों के आधार पर आपकी योजना को स्वचालित रूप से समायोजित किया गया है:';

  @override
  String get adaptivePortionsOptimized =>
      'आपकी उपभोग की आदतों के लिए अनुकूलित हिस्से';

  @override
  String get adaptiveMealsReplaced => 'आपकी पसंद के आधार पर बदले गए भोजन';

  @override
  String get adaptiveNutrientsRebalanced =>
      'इष्टतम स्वास्थ्य के लिए पुनर्संतुलित पोषक तत्व';

  @override
  String get mockConditionDiabetes => 'टाइप 2 मधुमेह';

  @override
  String get mockConditionPCOS => 'पीसीओएस';

  @override
  String get mockConditionHypertension => 'उच्च रक्तचाप';

  @override
  String get mealPlanProtein => 'प्रोटीन';

  @override
  String get mealPlanFiber => 'फाइबर';

  @override
  String get mealPlanSugar => 'चीनी';

  @override
  String get mealPlanSodium => 'सोडियम';

  @override
  String get pantryTitle => 'पेंट्री मैनेजमेंट';

  @override
  String get pantryRefreshTooltip => 'पेंट्री ताज़ा करें';

  @override
  String get pantrySearchHint => 'सामग्री खोजें...';

  @override
  String get pantryTabInventory => 'इन्वेंट्री';

  @override
  String get pantryTabSuggestions => 'भोजन सुझाव';

  @override
  String get pantryFabAddItem => 'आइटम जोड़ें';

  @override
  String get pantryEmptyNoItems => 'पेंट्री में कोई आइटम नहीं है';

  @override
  String get pantryEmptyNoResults => 'कोई परिणाम नहीं मिला';

  @override
  String get pantryEmptyMessageNoItems =>
      'अपनी पेंट्री इन्वेंट्री को ट्रैक करने के लिए सामग्री जोड़ना शुरू करें';

  @override
  String get pantryEmptyMessageNoResults =>
      'अलग कीवर्ड के साथ खोजने का प्रयास करें';

  @override
  String get pantrySummaryTotal => 'कुल आइटम';

  @override
  String get pantrySummaryFresh => 'ताजा';

  @override
  String get pantrySummaryExpiring => 'समाप्त होने वाला';

  @override
  String get pantrySummaryExpired => 'समाप्त';

  @override
  String get pantrySuggestionsTitle => 'स्मार्ट भोजन सुझाव';

  @override
  String get pantrySuggestionsSubtitle =>
      'आपकी उपलब्ध पेंट्री स्टॉक के आधार पर';

  @override
  String get pantryEmptyNoSuggestions => 'कोई भोजन सुझाव नहीं';

  @override
  String get pantryEmptyMessageNoSuggestions =>
      'व्यक्तिगत भोजन सुझाव प्राप्त करने के लिए और सामग्री जोड़ें';

  @override
  String pantrySnackAddedToList(String itemName) {
    return '$itemName को किराना सूची में जोड़ा गया';
  }

  @override
  String pantrySnackMarkedUsed(String itemName) {
    return '$itemName को उपयोग किया गया चिह्नित किया गया';
  }

  @override
  String pantrySnackAddedToPantry(String itemName) {
    return '$itemName को पेंट्री में जोड़ा गया';
  }

  @override
  String get pantryDialogAddTitle => 'पेंट्री आइटम जोड़ें';

  @override
  String get pantryDialogItemNameLabel => 'आइटम का नाम *';

  @override
  String get pantryDialogItemNameHint => 'जैसे, टमाटर';

  @override
  String get pantryDialogCategoryLabel => 'श्रेणी *';

  @override
  String get pantryDialogQuantityLabel => 'मात्रा *';

  @override
  String get pantryDialogQuantityHint => '0.0';

  @override
  String get pantryDialogUnitLabel => 'इकाई *';

  @override
  String get pantryDialogExpiryDateLabel => 'समाप्ति तिथि *';

  @override
  String get pantryDialogErrorFields => 'कृपया सभी आवश्यक फ़ील्ड भरें';

  @override
  String get pantryDialogCancel => 'रद्द करें';

  @override
  String get pantryDialogConfirmAdd => 'आइटम जोड़ें';

  @override
  String get pantryCategoryVegetables => 'सब्जियां';

  @override
  String get pantryCategoryGrains => 'अनाज';

  @override
  String get pantryCategorySpices => 'मसाले';

  @override
  String get pantryCategoryDairy => 'डेयरी';

  @override
  String get pantryCategoryProteins => 'प्रोटीन';

  @override
  String get pantryCategoryOther => 'अन्य';

  @override
  String get unitKg => 'किग्रा';

  @override
  String get unitG => 'ग्राम';

  @override
  String get unitL => 'लीटर';

  @override
  String get unitMl => 'मिली';

  @override
  String get unitPcs => 'पीस';

  @override
  String get pantryStatusFresh => 'ताजा';

  @override
  String get pantryStatusExpiringSoon => 'जल्द समाप्त होगा';

  @override
  String get pantryStatusExpired => 'समाप्त';

  @override
  String get pantryStatusUnknown => 'अज्ञात';

  @override
  String pantryMealCal(String value) {
    return '$value कैलोरी';
  }

  @override
  String pantryMealAvailablePercent(int value) {
    return '$value% उपलब्ध';
  }

  @override
  String get pantryMealRequiredIngredients => 'आवश्यक सामग्री';

  @override
  String get pantryMealInPantry => 'पेंट्री में';

  @override
  String get pantryMealMissingIngredients => 'लापता सामग्री';

  @override
  String pantryMealEstimatedCost(String value) {
    return 'अनुमानित लागत: ₹$value';
  }

  @override
  String get pantryMealReadyToCook => 'सभी सामग्री उपलब्ध! पकाने के लिए तैयार।';

  @override
  String get pantryMealAddedMissingToGrocery =>
      'लापता सामग्री किराना सूची में जोड़ी गई';

  @override
  String get pantryMealStartCooking => 'खाना पकाना शुरू करें';

  @override
  String get pantryMealAddMissingItems => 'लापता वस्तुओं को किराना में जोड़ें';

  @override
  String pantryMealMissingLabel(String value) {
    return 'लापता: $value';
  }

  @override
  String get pantryMealAllAvailable => 'सभी सामग्री उपलब्ध!';

  @override
  String get pantryMealTapToView => 'विवरण देखने के लिए टैप करें';

  @override
  String get pantryDetailsStock => 'वर्तमान स्टॉक';

  @override
  String get pantryDetailsDaysLeft => 'दिन शेष';

  @override
  String pantryDetailsDaysRange(int value) {
    return '$value दिन';
  }

  @override
  String get pantryDetailsPurchaseDate => 'खरीद की तारीख';

  @override
  String get pantryDetailsExpiryDate => 'समाप्ति तिथि';

  @override
  String get pantryDetailsStockLevel => 'स्टॉक स्तर';

  @override
  String get pantryDetailsNoUsage => 'अभी तक कोई उपयोग रिकॉर्ड नहीं किया गया';

  @override
  String get pantryDetailsUsageHistory => 'उपयोग इतिहास';

  @override
  String pantryDetailsMarkUsedTitle(String itemName) {
    return '$itemName को उपयोग किया गया चिह्नित करें';
  }

  @override
  String get pantryDetailsSelectPortion => 'उपयोग किया गया हिस्सा चुनें:';

  @override
  String get pantryDetailsConfirm => 'पुष्टि करें';

  @override
  String get pantryDetailsAddToList => 'सूची में जोड़ें';

  @override
  String get pantryDetailsMarkUsed => 'उपयोग चिह्नित करें';

  @override
  String pantryDetailsExpiresLabel(String date, int days) {
    return 'समाप्त होगा: $date ($days दिन)';
  }

  @override
  String get mockIngredientCapsicum => 'शिमला मिर्च';

  @override
  String get mockIngredientMixedVeg => 'मिश्रित सब्जियां';

  @override
  String get mockIngredientDalia => 'दलिया';

  @override
  String get mockMealVegPulao => 'वेजिटेबल पुलाव';

  @override
  String get mockMealPaneerTikka => 'पनीर टिक्का';

  @override
  String get mockMealDaliaKhichdi => 'दलिया खिचड़ी';

  @override
  String get mockIngredientOnions => 'प्याज';

  @override
  String get mockIngredientTomatoes => 'टमाटर';

  @override
  String get mockIngredientSpinach => 'पालक';

  @override
  String get mockIngredientCarrots => 'गाजर';

  @override
  String get mockIngredientBasmatiRice => 'बासमती चावल';

  @override
  String get mockIngredientWheatFlour => 'गेहूं का आटा';

  @override
  String get mockIngredientMoongDal => 'मूंग दाल';

  @override
  String get mockIngredientTurmeric => 'हल्दी पाउडर';

  @override
  String get mockIngredientCumin => 'जीरा';

  @override
  String get mockIngredientGaramMasala => 'गरम मसाला';

  @override
  String get mockIngredientMilk => 'दूध';

  @override
  String get mockIngredientYogurt => 'दही';

  @override
  String get mockIngredientPaneer => 'पनीर';

  @override
  String get mockIngredientChicken => 'चिकन ब्रेस्ट';

  @override
  String get mockIngredientEggs => 'अंडे';

  @override
  String get mockIngredientGreenPeas => 'हरी मटर';

  @override
  String get mockIngredientCream => 'क्रीम';

  @override
  String get mockIngredientButter => 'मक्खन';

  @override
  String get mockIngredientCoconutMilk => 'नारियल का दूध';

  @override
  String get mockIngredientGarlic => 'लहसुन';

  @override
  String get mockMealDalTadka => 'दाल तड़का';

  @override
  String get mockMealPaneerButterMasala => 'पनीर बटर मसाला';

  @override
  String get mockMealEggCurry => 'अंडा करी';

  @override
  String get mealPlanRoastedMakhana => 'भुने हुए मखाने और ग्रीन टी';

  @override
  String get mealPlanRotiPalakPaneer =>
      'Roti with Palak Paneer & Cucumber Raita';

  @override
  String get mockMealIdliSambar => 'इडली और सांभर';

  @override
  String get mockMealDosaChutney => 'डोसा और नारियल की चटनी';

  @override
  String get mockMealVegetableUpma => 'सब्जी उपमा';

  @override
  String get mockMealLemonRice => 'नींबू चावल';

  @override
  String get mockMealCurdRice => 'दही चावल';

  @override
  String get mockMealRagiMudde => 'रागी मुद्दे और सारू';

  @override
  String get mockMealRotiDalTadka => 'रोटी और दाल तड़का';

  @override
  String get mockMealRajmaChawal => 'राजमा चावल';

  @override
  String get mockMealVegetableKhichdi => 'सब्जी खिचड़ी';

  @override
  String get mockMealCholeRice => 'छोले और चावल';

  @override
  String get mockMealPaneerBhurji => 'पनीर भुर्जी और रोटी';
}

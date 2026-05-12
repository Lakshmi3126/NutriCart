import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import '../../core/services/voice_assistant_service.dart';
import '../../widgets/custom_icon_widget.dart';
import './widgets/cooking_instructions_widget.dart';
import './widgets/health_impact_widget.dart';
import './widgets/ingredients_list_widget.dart';
import './widgets/meal_header_widget.dart';
import './widgets/meal_info_widget.dart';
import './widgets/nutrition_breakdown_widget.dart';
import './widgets/why_this_meal_widget.dart';

/// Meal Details screen providing comprehensive information about selected Indian dishes
/// with health-focused explanations and interactive features
class MealDetails extends StatefulWidget {
  const MealDetails({Key? key}) : super(key: key);

  @override
  State<MealDetails> createState() => _MealDetailsState();
}

class _MealDetailsState extends State<MealDetails> {
  bool _isFavorite = false;
  final ScrollController _scrollController = ScrollController();

  Map<String, dynamic> _mealData = {};
  bool _isInitialized = false;
  final VoiceAssistantService _voiceAssistant = VoiceAssistantService();

  @override
  void initState() {
    super.initState();
    _voiceAssistant.init();
  }

  @override
  void dispose() {
    _voiceAssistant.stop();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
      final l10n = AppLocalizations.of(context)!;
      final args = ModalRoute.of(context)?.settings.arguments;
      if (args is Map<String, dynamic>) {
        if (args.containsKey('mealId')) {
          final mealId = args['mealId'];
          _mealData = _getRecipeById(mealId, l10n);
        } else {
          _mealData = args;
        }
      } else {
        _mealData = _getRecipeById(4, l10n);
      }
      _isInitialized = true;
    }
  }

  Map<String, dynamic> _getRecipeById(dynamic id, AppLocalizations l10n) {
    final mealId = (id is String) ? int.tryParse(id) : id;

    switch (mealId) {
      case 1:
        return {
          "id": 1,
          "name": "Ragi Dosa + Mint Peanut Chutney",
          "image": "assets/images/meals/2_ragi_dosas_mint_peanut_chutney.png",
          "imageSemanticLabel":
              "Ragi dosa served with mint peanut chutney",
          "prepTime": "20 min",
          "servings": "2",
          "calories": 320,
          "nutrition": {"carbs": 43, "protein": 10, "fiber": 8, "fat": 9},
          "reasoning": {
            "summary":
                "Low-glycemic breakfast optimized for sustained energy during school hours.",
            "reasons": [
              "Millet batter was selected over refined rice batter to reduce post-breakfast glucose spikes.",
              "Chutney salt was reduced; roasted peanut and mint improve flavor without excess sodium.",
              "Batter prepared previous night to fit Sunita's busy morning schedule.",
            ],
          },
          "ingredients": [
            {"name": "Ragi dosa batter", "quantity": "1 cup", "substitution": "Ragi + urad homemade batter"},
            {"name": "Roasted peanuts", "quantity": "2 tbsp", "substitution": "Roasted chana dal"},
            {"name": "Mint leaves", "quantity": "1/2 cup", "substitution": "Coriander leaves"},
            {"name": "Curry leaves", "quantity": "6-8", "substitution": null},
            {"name": "Onion", "quantity": "1 small", "substitution": null},
            {"name": "Oil", "quantity": "1 tsp total", "substitution": "Cold-pressed groundnut oil"},
          ],
          "instructions": [
            {"instruction": "Heat tawa and spread batter into two medium dosas.", "timing": "6 min"},
            {"instruction": "Cook with minimal oil on both sides until crisp.", "timing": "5 min"},
            {"instruction": "Blend peanuts, mint, green chili, and lemon into chutney.", "timing": "5 min"},
            {"instruction": "Adjust salt lightly and serve warm.", "timing": "2 min"},
          ],
          "healthBenefits": [
            {
              "condition": "Type 2 Diabetes",
              "benefit":
                  "Balanced carbohydrate distribution supports glucose stability in the first half of the day.",
            },
            {
              "condition": "Mild Hypertension",
              "benefit":
                  "Reduced chutney salt and controlled oil tempering may support blood pressure management.",
            },
          ],
        };
      
      case 2:
        return {
          "id": 2,
          "name": "Guava + Almonds",
          "image": "assets/images/meals/1_small_guava_5_almonds.png",
          "imageSemanticLabel": "Fresh guava served with almonds",
          "prepTime": "5 min",
          "servings": "1",
          "calories": 110,
          "nutrition": {
            "carbs": 14,
            "protein": 4,
            "fiber": 5,
            "fat": 6
          },
          "reasoning": {
            "summary": "Low glycemic fruit paired with healthy fats helps maintain stable blood sugar between meals.",
            "reasons": [
              "Guava provides fiber and vitamin C with lower sugar load than packaged snacks.",
              "Almonds improve satiety and reduce hunger before lunch.",
              "Quick snack option that fits Sunita’s work schedule."
            ],
          },
          "ingredients": [
          {
            "name": "Guava",
            "quantity": "1 small",
            "substitution": "Pear"
          },
          {
          "name": "Almonds",
          "quantity": "5 pieces",
          "substitution": "Walnuts"
          }
        ],
          "instructions": [
            {
               "instruction": "Wash and slice guava.",
                 "timing": "2 min"
            },
            {
              "instruction": "Serve with almonds.",
              "timing": "1 min"
            }
          ],
        "healthBenefits": [
         {
            "condition": "Type 2 Diabetes",
            "benefit":
            "Fiber-rich snack may help reduce sudden glucose spikes between meals."
          },
          {
        "condition": "Heart Health",
        "benefit":
            "Almonds provide healthy fats that support cardiovascular wellness."
      }
    ],
  };
      case 3:
        return {
          "id": 3,
          "name": "Brown+White Rice Mix, Sambar, Beans Poriyal, Curd",
          "image": "assets/images/meals/brown_white_rice_mix_sambar_beans_poriyal_curd.png",
          "imageSemanticLabel":
              "Mixed rice meal with sambar, beans poriyal and curd",
          "prepTime": "35 min",
          "servings": "2",
          "calories": 470,
          "nutrition": {"carbs": 62, "protein": 17, "fiber": 13, "fat": 11},
          "reasoning": {
            "summary":
                "Higher-fiber lunch selected to improve satiety and reduce afternoon cravings.",
            "reasons": [
              "White rice was partially replaced with brown rice for slower glucose release.",
              "Dal-based sambar adds protein without increasing cost significantly.",
              "Poriyal uses seasonal beans from local market to keep budget practical.",
            ],
          },
          "ingredients": [
            {"name": "White rice", "quantity": "1/2 cup cooked", "substitution": "More brown rice if acceptable"},
            {"name": "Brown rice", "quantity": "1/3 cup cooked", "substitution": "Little millet"},
            {"name": "Toor dal", "quantity": "1/2 cup cooked", "substitution": "Masoor dal"},
            {"name": "Beans", "quantity": "1 cup chopped", "substitution": "Cabbage"},
            {"name": "Curd", "quantity": "1/2 cup", "substitution": "Low-fat homemade curd"},
          ],
          "instructions": [
            {"instruction": "Cook white and brown rice together in a 60:40 ratio.", "timing": "18 min"},
            {"instruction": "Prepare sambar with toor dal and mixed vegetables.", "timing": "15 min"},
            {"instruction": "Make beans poriyal with minimal oil and grated coconut.", "timing": "7 min"},
            {"instruction": "Serve with plain curd and cucumber.", "timing": "2 min"},
          ],
          "healthBenefits": [
            {
              "condition": "Type 2 Diabetes",
              "benefit":
                  "Mixed-grain lunch and dal combination may reduce post-lunch blood sugar variability.",
            },
            {
              "condition": "Mild Hypertension",
              "benefit":
                  "Home-cooked sambar with measured salt helps maintain lower sodium intake.",
            }
          ],
        };
      case 4:
        return {
          "id": 4,
          "name": "Roasted Chana Sundal",
          "image": "assets/images/meals/Roasted Chana Sundal + Lemon.png",
          "imageSemanticLabel": "Roasted chana sundal in a bowl",
          "prepTime": "12 min",
          "servings": "1",
          "calories": 160,
          "nutrition": {"carbs": 22, "protein": 7, "fiber": 6, "fat": 4},
          "reasoning": {
            "summary":
                "Evening snack selected to avoid fried tea-time foods while keeping satiety high.",
            "reasons": [
              "Legume-based snack provides better protein-fiber balance than biscuits.",
              "Lemon, curry leaves, and mustard seeds improve taste with less salt.",
              "Quick to prepare after work and acceptable for family snacking.",
            ],
          },
          "ingredients": [
            {"name": "Boiled black chana", "quantity": "3/4 cup", "substitution": "White chana"},
            {"name": "Mustard seeds", "quantity": "1/4 tsp", "substitution": null},
            {"name": "Curry leaves", "quantity": "5-6", "substitution": null},
            {"name": "Grated coconut", "quantity": "1 tbsp", "substitution": "Skip for lower calories"},
            {"name": "Lemon", "quantity": "1/2", "substitution": null},
          ],
          "instructions": [
            {"instruction": "Heat 1 tsp oil and splutter mustard with curry leaves.", "timing": "2 min"},
            {"instruction": "Add boiled chana and saute on low flame.", "timing": "5 min"},
            {"instruction": "Add coconut, lemon juice, and minimal salt before serving.", "timing": "3 min"},
          ],
          "healthBenefits": [
            {
              "condition": "Type 2 Diabetes",
              "benefit":
                  "Protein-rich snack can reduce sharp glucose fluctuations before dinner.",
            },
            {
              "condition": "Weight and satiety",
              "benefit":
                  "Higher fiber improves fullness and may help portion control at dinner.",
            }
          ],
        };
      case 5:
      default:
        return {
          "id": 5,
          "name": "2 Phulkas + Lauki Chana Dal + Cucumber Salad",
          "image": "assets/images/meals/2 Phulkas + Lauki Chana Dal + Cucumber Salad.png",
          "imageSemanticLabel":
              "Phulkas served with lauki chana dal and cucumber salad",
          "prepTime": "30 min",
          "servings": "2",
          "calories": 620,
          "nutrition": {"carbs": 68, "protein": 19, "fiber": 14, "fat": 13},
          "reasoning": {
            "summary":
                "Portion-balanced dinner to support overnight glucose control and blood pressure goals.",
            "reasons": [
              "Dinner carbohydrate portion is controlled with 2 medium phulkas.",
              "Lauki chana dal gives fiber and protein with lower oil tempering.",
              "Extra raw cucumber adds volume and satiety without excess calories.",
            ],
          },
          "ingredients": [
            {"name": "Whole wheat flour", "quantity": "1 cup dough", "substitution": "Jowar-wheat mix"},
            {"name": "Lauki", "quantity": "1 cup chopped", "substitution": "Tori"},
            {"name": "Chana dal", "quantity": "1/2 cup cooked", "substitution": "Moong dal"},
            {"name": "Onion and tomato", "quantity": "1/2 cup", "substitution": null},
            {"name": "Cucumber", "quantity": "1 cup sliced", "substitution": "Carrot-cucumber mix"},
          ],
          "instructions": [
            {"instruction": "Pressure cook chana dal until soft.", "timing": "12 min"},
            {"instruction": "Cook lauki with onion-tomato masala and fold in dal.", "timing": "12 min"},
            {"instruction": "Prepare 2 medium phulkas with minimal oil.", "timing": "5 min"},
            {"instruction": "Serve with fresh cucumber salad and lemon.", "timing": "2 min"},
          ],
          "healthBenefits": [
            {
              "condition": "Type 2 Diabetes",
              "benefit":
                  "Controlled evening carb load with higher fiber may support better fasting glucose trends.",
            },
            {
              "condition": "Mild Hypertension",
              "benefit":
                  "Lower-sodium cooking and potassium-rich vegetables support heart-health goals.",
            }
          ],
        };
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Stack(
        children: [
          // Scrollable content
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              // Meal header with image
              SliverToBoxAdapter(
                child: MealHeaderWidget(
                  mealData: _mealData,
                  onBack: () =>
                      Navigator.of(context, rootNavigator: true).pop(),
                  onFavoriteToggle: _toggleFavorite,
                  isFavorite: _isFavorite,
                  onTapToRead: () => _speakSection(_mealData['name'] as String? ?? ''),
                ),
              ),

              // Meal info section
              SliverToBoxAdapter(child: MealInfoWidget(mealData: _mealData)),

              // Why this meal section (moved up for better flow)
              SliverToBoxAdapter(
                child: WhyThisMealWidget(
                  reasoningData: _mealData['reasoning'] as Map<String, dynamic>,
                ),
              ),

              // Nutrition breakdown
              SliverToBoxAdapter(
                child: NutritionBreakdownWidget(
                  nutritionData: _mealData['nutrition'] as Map<String, dynamic>,
                ),
              ),

              // Ingredients list
              SliverToBoxAdapter(
                child: IngredientsListWidget(
                  ingredients: (_mealData['ingredients'] as List)
                      .cast<Map<String, dynamic>>(),
                  onAddToGroceryList: _addIngredientToGroceryList,
                  onTapToRead: _speakSection,
                ),
              ),

              // Cooking instructions
              SliverToBoxAdapter(
                child: CookingInstructionsWidget(
                  instructions: (_mealData['instructions'] as List)
                      .cast<Map<String, dynamic>>(),
                  onVoicePlayback: _playInstructionsVoice,
                  onTapToRead: _speakSection,
                ),
              ),

              // Health impact
              SliverToBoxAdapter(
                child: HealthImpactWidget(
                  healthBenefits: (_mealData['healthBenefits'] as List)
                      .cast<Map<String, dynamic>>(),
                ),
              ),

              // Bottom spacing for action bar
              SliverToBoxAdapter(child: SizedBox(height: 4.h)),
            ],
          ),

          
                    
        ],
      ),
    );
  }

  void _toggleFavorite() {
    setState(() {
      _isFavorite = !_isFavorite;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _isFavorite ? 'Added to favorites' : 'Removed from favorites',
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _addIngredientToGroceryList(Map<String, dynamic> ingredient) {
    // In production, this would add to actual grocery list state/database
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${ingredient['name']} added to grocery list'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _playInstructionsVoice() async {
    final l10n = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context).languageCode;

    if (_voiceAssistant.isPlaying) {
      await _voiceAssistant.stop();
      return;
    }

    // Reading order: Title → Description → Ingredients → Instructions
    String textToRead = "${_mealData['name']}. ";
    
    if (_mealData['reasoning'] != null && _mealData['reasoning']['summary'] != null) {
      textToRead += "${_mealData['reasoning']['summary']}. ";
    }

    textToRead += "${l10n.mealPlanIngredients}: ";
    final ingredients = (_mealData['ingredients'] as List? ?? []);
    for (var i in ingredients) {
      textToRead += "${i['name']} ${i['quantity']}. ";
    }

    textToRead += "${l10n.mealPlanCookingSteps}: ";
    final instructions = (_mealData['instructions'] as List? ?? []);
    for (var i in instructions) {
      textToRead += "${i['instruction']}. ";
    }

    _voiceAssistant.speak(textToRead, locale);
  }

  void _speakSection(String text) {
    if (text.isEmpty) return;
    final locale = Localizations.localeOf(context).languageCode;
    _voiceAssistant.speak(text, locale);
  }

  void _addToMealPlan() {
    // In production, this would add meal to meal plan
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Meal added to plan'),
        duration: Duration(seconds: 2),
      ),
    );

    Navigator.of(
      context,
      rootNavigator: true,
    ).pushNamed('/daily-meal-planning');
  }

  void _shareRecipe() {
    // Share recipe using share_plus package
    final recipeText =
        '''
${_mealData['name']}

Prep Time: ${_mealData['prepTime']}
Servings: ${_mealData['servings']}
Calories: ${_mealData['calories']} kcal

Ingredients:
${(_mealData['ingredients'] as List).map((i) => '• ${i['name']} - ${i['quantity']}').join('\n')}

Instructions:
${(_mealData['instructions'] as List).asMap().entries.map((e) => '${e.key + 1}. ${e.value['instruction']}').join('\n')}

Shared from NutriCart - Your AI Nutrition Partner
''';

    SharePlus.instance.share(
      ShareParams(
        text: recipeText,
        subject: _mealData['name'] as String,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import '../../widgets/custom_icon_widget.dart';
import '../../widgets/loading_state_widget.dart';
import '../../widgets/empty_state_widget.dart';
import '../../models/meal_feedback.dart';
import '../../models/adaptive_meal_plan.dart';
import '../../services/meal_feedback_service.dart';
import '../../services/adaptive_meal_service.dart';
import '../../services/meal_api_service.dart';
import './widgets/date_selector_widget.dart';
import './widgets/meal_section_widget.dart';
import './widgets/voice_input_button_widget.dart';
import './widgets/meal_feedback_dialog.dart';
import './widgets/adaptive_insights_widget.dart';

/// Daily Meal Planning screen for comprehensive meal selection with health-conscious recommendations
/// Implements stack navigation with date picker and expandable meal sections
class DailyMealPlanning extends StatefulWidget {
  const DailyMealPlanning({Key? key}) : super(key: key);

  @override
  State<DailyMealPlanning> createState() => _DailyMealPlanningState();
}

class _DailyMealPlanningState extends State<DailyMealPlanning> {
  DateTime _selectedDate = DateTime.now();
  bool _isLoading = false;
  bool _isSaving = false;
  final Map<String, Map<String, dynamic>> _selectedMeals = {
    'breakfast': {},
    'lunch': {},
    'dinner': {},
    'snacks': {},
  };

  final MealFeedbackService _feedbackService = MealFeedbackService();
  final AdaptiveMealService _adaptiveService = AdaptiveMealService();
  final MealApiService _mealApiService = MealApiService();
  double _adaptationScore = 0.0;
  NutrientTargets _dailyTargets = NutrientTargets(
    calories: 1800,
    protein: 80,
    carbs: 220,
    fat: 60,
    fiber: 30,
  );
  NutrientTargets _adjustedTargets = NutrientTargets(
    calories: 1800,
    protein: 80,
    carbs: 220,
    fat: 60,
    fiber: 30,
  );

  // Replace mock data with API-fetched meal recommendations
  Map<String, List<Map<String, dynamic>>> _mealRecommendations = {
    'breakfast': [],
    'lunch': [],
    'dinner': [],
    'snacks': [],
  };

  @override
  void initState() {
    super.initState();
    _loadMealPlanFromBackend();
  }

  /// Load meal plan from backend API
  Future<void> _loadMealPlanFromBackend() async {
    setState(() => _isLoading = true);
    try {
      // Fetch daily meal plan from backend
      final mealPlanData = await _mealApiService.fetchDailyMealPlan(
        date: _selectedDate,
      );

      // Extract meal recommendations from API response
      setState(() {
        _mealRecommendations = {
          'breakfast': List<Map<String, dynamic>>.from(
            mealPlanData['meals']?['breakfast'] ?? [],
          ),
          'lunch': List<Map<String, dynamic>>.from(
            mealPlanData['meals']?['lunch'] ?? [],
          ),
          'dinner': List<Map<String, dynamic>>.from(
            mealPlanData['meals']?['dinner'] ?? [],
          ),
          'snacks': List<Map<String, dynamic>>.from(
            mealPlanData['meals']?['snacks'] ?? [],
          ),
        };

        // Update nutrient targets from backend
        if (mealPlanData['daily_targets'] != null) {
          _dailyTargets = NutrientTargets.fromJson(
            mealPlanData['daily_targets'],
          );
        }
        if (mealPlanData['adjusted_targets'] != null) {
          _adjustedTargets = NutrientTargets.fromJson(
            mealPlanData['adjusted_targets'],
          );
        }
      });

      // Load adaptive data
      await _loadAdaptiveData();
    } catch (e) {
      print('Error loading meal plan from backend: $e');
      // Show error to user
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to load meal plan. Please try again.'),
            backgroundColor: Colors.red,
            action: SnackBarAction(
              label: 'Retry',
              textColor: Colors.white,
              onPressed: _loadMealPlanFromBackend,
            ),
          ),
        );
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _loadAdaptiveData() async {
    try {
      // Fetch adaptive insights from backend
      final insights = await _mealApiService.fetchAdaptiveInsights();

      setState(() {
        _adaptationScore =
            (insights['adaptation_score'] as num?)?.toDouble() ?? 0.0;
      });

      // Apply adaptive portion adjustments
      await _applyAdaptivePortions();

      // Check for auto-replacements
      await _checkAutoReplacements();
    } catch (e) {
      print('Error loading adaptive data: $e');
      // Silent fail - continue with default recommendations
    }
  }

  Future<void> _applyAdaptivePortions() async {
    for (final mealType in ['breakfast', 'lunch', 'dinner', 'snacks']) {
      final multiplier = await _adaptiveService
          .calculateAdaptivePortionMultiplier(mealType);

      // Apply to recommendations
      final recommendations = _mealRecommendations[mealType];
      if (recommendations != null) {
        for (final meal in recommendations) {
          meal['portionMultiplier'] = multiplier;
        }
      }
    }
  }

  Future<void> _checkAutoReplacements() async {
    final userProfile = {
      'healthConditions': {'Diabetes', 'PCOS'},
      'dietaryPreferences': {'Vegetarian'},
    };

    for (final mealType in ['breakfast', 'lunch', 'dinner', 'snacks']) {
      final recommendations = _mealRecommendations[mealType];
      if (recommendations == null || recommendations.isEmpty) continue;

      for (int i = 0; i < recommendations.length; i++) {
        final meal = recommendations[i];
        final shouldReplace = await _adaptiveService.shouldReplaceMeal(
          meal['id'] as String,
          mealType,
        );

        if (shouldReplace) {
          final alternative = _adaptiveService.findAlternativeMeal(
            recommendations,
            meal['id'] as String,
            userProfile['healthConditions'] as Set<String>,
            userProfile['dietaryPreferences'] as Set<String>,
          );

          if (alternative != null) {
            setState(() {
              alternative['isReplacement'] = true;
              alternative['replacementReason'] =
                  'Auto-replaced based on your preferences';
              recommendations[i] = alternative;
            });
          }
        }
      }
    }
  }

  void _onDateSelected(DateTime date) {
    setState(() {
      _selectedDate = date;
      _selectedMeals.clear();
    });
    // Reload meal plan for new date
    _loadMealPlanFromBackend();
  }

  void _onMealSelected(String mealType, Map<String, dynamic> meal) {
    setState(() {
      _selectedMeals[mealType] = meal;
    });
  }

  void _onPortionAdjusted(String mealType, double multiplier) {
    if (_selectedMeals[mealType]?.isNotEmpty ?? false) {
      setState(() {
        _selectedMeals[mealType]!['portionMultiplier'] = multiplier;
      });
    }
  }

  void _onMealRemoved(String mealType, String mealId) {
    setState(() {
      final recommendations = _mealRecommendations[mealType] ?? [];
      _mealRecommendations[mealType] = recommendations
          .where((meal) => meal['id'] != mealId)
          .toList();
    });
  }

  Future<void> _handleVoiceCommand(String command) async {
    // Simulate voice command processing
    await Future.delayed(const Duration(milliseconds: 500));

    if (command.toLowerCase().contains('diabetic') &&
        command.toLowerCase().contains('lunch')) {
      // Filter diabetic-friendly lunch options
      final diabeticLunch = _mealRecommendations['lunch']
          ?.where((meal) => meal['isDiabeticFriendly'] == true)
          .toList();
      if (diabeticLunch?.isNotEmpty ?? false) {
        _onMealSelected('lunch', diabeticLunch!.first);
      }
    } else if (command.toLowerCase().contains('vegetarian')) {
      // Show vegetarian options
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Showing vegetarian options')),
      );
    }
  }

  void _showMealDetails(Map<String, dynamic> meal) async {
    try {
      // Fetch detailed recipe and explanation from backend
      final recipe = await _mealApiService.fetchRecipe(
        mealId: meal['id'] as String,
      );
      final explanation = await _mealApiService.fetchMealExplanation(
        mealId: meal['id'] as String,
      );

      // Merge backend data with meal data
      final enrichedMeal = {
        ...meal,
        'recipe': recipe,
        'explanation': explanation,
      };

      Navigator.of(
        context,
        rootNavigator: true,
      ).pushNamed('/meal-details', arguments: enrichedMeal);
    } catch (e) {
      print('Error fetching meal details: $e');
      // Fallback to basic meal data
      Navigator.of(
        context,
        rootNavigator: true,
      ).pushNamed('/meal-details', arguments: meal);
    }
  }

  void _showSubstitutionDialog(String mealType, Map<String, dynamic> meal) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.6,
        minChildSize: 0.4,
        maxChildSize: 0.9,
        expand: false,
        builder: (context, scrollController) {
          final theme = Theme.of(context);
          return Container(
            padding: EdgeInsets.all(4.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 12.w,
                    height: 0.5.h,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.onSurfaceVariant.withValues(
                        alpha: 0.3,
                      ),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  'Ingredient Substitutions',
                  style: theme.textTheme.headlineSmall,
                ),
                SizedBox(height: 1.h),
                Text(
                  'Budget-friendly alternatives for ${meal['name']}',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                SizedBox(height: 2.h),
                Expanded(
                  child: ListView(
                    controller: scrollController,
                    children: [
                      _buildSubstitutionItem(
                        theme,
                        'Paneer',
                        'Tofu',
                        'Save ₹40/kg',
                        'Similar protein content',
                      ),
                      _buildSubstitutionItem(
                        theme,
                        'Quinoa',
                        'Brown Rice',
                        'Save ₹180/kg',
                        'Good fiber source',
                      ),
                      _buildSubstitutionItem(
                        theme,
                        'Almonds',
                        'Peanuts',
                        'Save ₹400/kg',
                        'Similar healthy fats',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSubstitutionItem(
    ThemeData theme,
    String original,
    String substitute,
    String savings,
    String benefit,
  ) {
    return Card(
      margin: EdgeInsets.only(bottom: 1.h),
      child: Padding(
        padding: EdgeInsets.all(3.w),
        child: Row(
          children: [
            Container(
              width: 12.w,
              height: 12.w,
              decoration: BoxDecoration(
                color: theme.colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(2.w),
              ),
              child: CustomIconWidget(
                iconName: 'swap_horiz',
                color: theme.colorScheme.primary,
                size: 6.w,
              ),
            ),
            SizedBox(width: 3.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        original,
                        style: theme.textTheme.titleMedium?.copyWith(
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      CustomIconWidget(
                        iconName: 'arrow_forward',
                        size: 4.w,
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                      Text(
                        substitute,
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 0.5.h),
                  Text(
                    savings,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: Colors.green,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    benefit,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _saveMealPlan() async {
    await _saveDayPlan();
  }

  Future<void> _saveDayPlan() async {
    if (_selectedMeals.values.every((meal) => meal.isEmpty)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select at least one meal before saving'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    setState(() => _isSaving = true);

    // Simulate API call to save meal plan
    await Future.delayed(const Duration(seconds: 1));

    setState(() => _isSaving = false);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              CustomIconWidget(
                iconName: 'check_circle',
                color: Colors.white,
                size: 5.w,
              ),
              SizedBox(width: 2.w),
              const Expanded(
                child: Text(
                  'Meal plan saved! Grocery list updated automatically.',
                ),
              ),
            ],
          ),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.green,
          action: SnackBarAction(
            label: 'View List',
            textColor: Colors.white,
            onPressed: () {
              Navigator.of(
                context,
                rootNavigator: true,
              ).pushNamed('/grocery-list');
            },
          ),
        ),
      );
    }
  }

  bool _hasSelections() {
    return _selectedMeals.values.any((meal) => meal.isNotEmpty);
  }

  void _showMealFeedbackDialog(String mealType, Map<String, dynamic> meal) {
    showDialog(
      context: context,
      builder: (context) => MealFeedbackDialog(
        mealId: meal['id'] as String,
        mealName: meal['name'] as String,
        mealType: mealType,
        onFeedbackSubmit: (status, portion, reason) async {
          await _saveMealFeedback(mealType, meal, status, portion, reason);
        },
      ),
    );
  }

  Future<void> _saveMealFeedback(
    String mealType,
    Map<String, dynamic> meal,
    FeedbackStatus status,
    double portionConsumed,
    String? reason,
  ) async {
    try {
      // Submit feedback to backend API
      await _mealApiService.submitMealFeedback(
        mealId: meal['id'] as String,
        mealType: mealType,
        date: _selectedDate,
        status: status.name,
        portionConsumed: portionConsumed,
        reason: reason,
      );

      // Also save to local Supabase for offline support
      final feedback = MealFeedback(
        id: _feedbackService.generateFeedbackId(),
        mealId: meal['id'] as String,
        mealType: mealType,
        date: _selectedDate,
        status: status,
        portionConsumed: portionConsumed,
        reason: reason,
        timestamp: DateTime.now(),
      );
      await _feedbackService.saveFeedback(feedback);

      // Reload adaptive data
      await _loadAdaptiveData();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              status == FeedbackStatus.eaten
                  ? 'Great! Feedback saved. Your plan will adapt.'
                  : 'Feedback saved. We\'ll adjust future recommendations.',
            ),
            backgroundColor: status == FeedbackStatus.eaten
                ? Colors.green
                : Colors.orange,
          ),
        );
      }
    } catch (e) {
      print('Error saving meal feedback: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to save feedback. Please try again.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Meal Planning'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
          ),
        ),
        body: const LoadingStateWidget(type: LoadingType.list),
      );
    }

    final hasAnyMeals = _mealRecommendations.values.any(
      (meals) => meals.isNotEmpty,
    );

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // Enhanced Header
            Container(
              padding: EdgeInsets.all(4.w),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                boxShadow: [
                  BoxShadow(
                    color: theme.shadowColor.withValues(alpha: 0.05),
                    blurRadius: 8.0,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: CustomIconWidget(
                          iconName: 'arrow_back',
                          color: theme.colorScheme.onSurface,
                          size: 24,
                        ),
                        onPressed: () =>
                            Navigator.of(context, rootNavigator: true).pop(),
                      ),
                      Expanded(
                        child: Text(
                          'Meal Planning',
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: theme.colorScheme.onSurface,
                            fontSize: 18.sp,
                          ),
                        ),
                      ),
                      VoiceInputButtonWidget(
                        onVoiceCommand: _handleVoiceCommand,
                      ),
                    ],
                  ),
                  SizedBox(height: 2.h),
                  DateSelectorWidget(
                    selectedDate: _selectedDate,
                    onDateSelected: _onDateSelected,
                  ),
                ],
              ),
            ),

            // Content
            Expanded(
              child: !hasAnyMeals
                  ? EmptyStateWidget(
                      title: 'No Meals Available',
                      message:
                          'We couldn\'t load meal recommendations. Please try again.',
                      iconName: 'restaurant_menu',
                      actionLabel: 'Retry',
                      onAction: _loadMealPlanFromBackend,
                    )
                  : RefreshIndicator(
                      onRefresh: _loadMealPlanFromBackend,
                      color: theme.colorScheme.primary,
                      child: SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        child: Column(
                          children: [
                            // Adaptive Insights
                            if (_adaptationScore > 0)
                              Padding(
                                padding: EdgeInsets.all(4.w),
                                child: AdaptiveInsightsWidget(
                                  adaptationScore: _adaptationScore,
                                  dailyTargets: _dailyTargets,
                                  adjustedTargets: _adjustedTargets,
                                  selectedMeals: _selectedMeals,
                                ),
                              ),

                            // Meal Sections with Enhanced Styling
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 4.w),
                              child: Column(
                                children: [
                                  _buildMealSection(
                                    'breakfast',
                                    'Breakfast',
                                    'free_breakfast',
                                  ),
                                  SizedBox(height: 2.h),
                                  _buildMealSection(
                                    'lunch',
                                    'Lunch',
                                    'lunch_dining',
                                  ),
                                  SizedBox(height: 2.h),
                                  _buildMealSection(
                                    'dinner',
                                    'Dinner',
                                    'dinner_dining',
                                  ),
                                  SizedBox(height: 2.h),
                                  _buildMealSection(
                                    'snacks',
                                    'Snacks',
                                    'cookie',
                                  ),
                                  SizedBox(height: 10.h),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),

      // Enhanced Save Button
      floatingActionButton: _hasSelections()
          ? Container(
              margin: EdgeInsets.only(bottom: 2.h),
              child: FloatingActionButton.extended(
                onPressed: _isSaving ? null : _saveMealPlan,
                backgroundColor: theme.colorScheme.primary,
                icon: _isSaving
                    ? SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            theme.colorScheme.onPrimary,
                          ),
                        ),
                      )
                    : CustomIconWidget(
                        iconName: 'check',
                        color: theme.colorScheme.onPrimary,
                        size: 24,
                      ),
                label: Text(
                  _isSaving ? 'Saving...' : 'Save Plan',
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: theme.colorScheme.onPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            )
          : null,
    );
  }

  Widget _buildMealSection(String mealType, String title, String icon) {
    return MealSectionWidget(
      mealType: mealType,
      title: title,
      icon: icon,
      recommendations: _mealRecommendations[mealType] ?? [],
      selectedMeal: _selectedMeals[mealType] ?? {},
      onMealSelected: _onMealSelected,
      onMealDetails: _showMealDetails,
      onMealRemoved: _onMealRemoved,
      onPortionAdjusted: _onPortionAdjusted,
      onSubstitution: _showSubstitutionDialog,
      onMealFeedback: _showMealFeedbackDialog,
    );
  }
}
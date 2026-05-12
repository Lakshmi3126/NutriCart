import 'package:flutter/material.dart';
import 'package:nutricart/l10n/app_localizations.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart';

import '../../core/app_export.dart';
import '../../widgets/custom_icon_widget.dart';
import '../../widgets/loading_state_widget.dart';
import '../../services/daily_meal_plan_mock_service.dart';
import './widgets/meal_card_simple_widget.dart';
import './widgets/daily_summary_widget.dart';
import './widgets/explainability_panel_widget.dart';

/// Daily Meal Plan screen providing comprehensive daily nutrition tracking
/// with interactive meal management and health insights
class DailyMealPlan extends StatefulWidget {
  const DailyMealPlan({Key? key}) : super(key: key);

  @override
  State<DailyMealPlan> createState() => _DailyMealPlanState();
}

class _DailyMealPlanState extends State<DailyMealPlan> {
  DateTime _selectedDate = DateTime.now();
  bool _isLoading = false;
  Map<String, dynamic>? _mealPlanData;
  final Map<String, String?> _mealFeedback = {};

  @override
  void initState() {
    super.initState();
    _loadMealPlan();
  }

  Future<void> _loadMealPlan() async {
    setState(() => _isLoading = true);
    try {
      final data = await DailyMealPlanMockService.getDailyMealPlan(
        _selectedDate,
      );
      setState(() => _mealPlanData = data);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to load meal plan: $e'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _onDateChanged(int days) {
    setState(() {
      _selectedDate = _selectedDate.add(Duration(days: days));
      _mealFeedback.clear();
    });
    _loadMealPlan();
  }

  void _onMealFeedback(String mealId, String feedback) {
    setState(() => _mealFeedback[mealId] = feedback);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(AppLocalizations.of(context)!.mealPlanAdaptFeedback),
        backgroundColor: Theme.of(context).colorScheme.secondary,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(title: Text(l10n.mealPlanTitle), centerTitle: true),
      body: SafeArea(
        child: Column(
          children: [
            // Date selector header
            _buildDateSelector(theme),

            // Main content
            Expanded(
              child: _isLoading
                  ? const LoadingStateWidget()
                  : _mealPlanData == null
                  ? Center(
                      child: Text(
                        l10n.mealPlanNoPlan,
                        style: theme.textTheme.bodyLarge,
                      ),
                    )
                  : RefreshIndicator(
                      onRefresh: _loadMealPlan,
                      child: SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        padding: EdgeInsets.all(4.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Breakfast
                            _buildMealSection(
                              l10n.mealPlanBreakfast,
                              'free_breakfast',
                              _mealPlanData!['meals']['breakfast'],
                              const Color(0xFFFFB74D),
                              theme,
                            ),
                            SizedBox(height: 2.h),

                            // Mid-Morning
                            _buildMealSection(
                              'Mid-Morning',
                              'wb_sunny',
                              _mealPlanData!['meals']['midMorning'],
                              const Color(0xFF26A69A),
                              theme,
                            ),
                            SizedBox(height: 2.h),

                            // Lunch
                            _buildMealSection(
                              l10n.mealPlanLunch,
                              'lunch_dining',
                              _mealPlanData!['meals']['lunch'],
                              const Color(0xFF4A90A4),
                              theme,
                            ),
                            SizedBox(height: 2.h),

                            // Evening Snack
                            _buildMealSection(
                              'Evening Snack',
                              'emoji_food_beverage',
                              _mealPlanData!['meals']['eveningSnack'],
                              const Color(0xFFAB47BC),
                              theme,
                            ),
                            SizedBox(height: 2.h),

                            // Dinner
                            _buildMealSection(
                              l10n.mealPlanDinner,
                              'dinner_dining',
                              _mealPlanData!['meals']['dinner'],
                              const Color(0xFF7CB342),
                              theme,
                            ),
                            SizedBox(height: 3.h),

                            // Daily Summary
                            DailySummaryWidget(
                              summaryData: _mealPlanData!['dailySummary'],
                            ),
                            SizedBox(height: 3.h),

                            // Explainability Panel
                            ExplainabilityPanelWidget(
                              explainabilityData: {
                                'title': _mealPlanData!['explainability']['title'],
                                'reasons':
                                    _mealPlanData!['explainability']['reasons'],
                              },
                            ),
                            SizedBox(height: 2.h),
                          ],
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateSelector(ThemeData theme) {
    final l10n = AppLocalizations.of(context)!;
    final dateFormat = DateFormat('dd/MM/yyyy');
    final isToday =
        _selectedDate.year == DateTime.now().year &&
        _selectedDate.month == DateTime.now().month &&
        _selectedDate.day == DateTime.now().day;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        border: Border(
          bottom: BorderSide(
            color: theme.colorScheme.outline.withValues(alpha: 0.2),
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () => _onDateChanged(-1),
            icon: const CustomIconWidget(iconName: 'chevron_left', size: 24),
            tooltip: l10n.mealPlanPrevDay,
          ),
          Column(
            children: [
              Text(
                dateFormat.format(_selectedDate),
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 16.sp,
                ),
              ),
              if (isToday)
                Text(
                  l10n.mealPlanToday,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.w600,
                    fontSize: 11.sp,
                  ),
                ),
            ],
          ),
          IconButton(
            onPressed: () => _onDateChanged(1),
            icon: const CustomIconWidget(iconName: 'chevron_right', size: 24),
            tooltip: l10n.mealPlanNextDay,
          ),
        ],
      ),
    );
  }

  Widget _buildMealSection(
    String title,
    String icon,
    Map<String, dynamic> mealData,
    Color accentColor,
    ThemeData theme,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 10.w,
              height: 10.w,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [accentColor, accentColor.withValues(alpha: 0.8)],
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: CustomIconWidget(
                iconName: icon,
                color: Colors.white,
                size: 20,
              ),
            ),
            SizedBox(width: 3.w),
            Text(
              title,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 16.sp,
              ),
            ),
          ],
        ),
        SizedBox(height: 1.5.h),
        MealCardSimpleWidget(
          mealData: mealData,
          selectedFeedback: _mealFeedback[mealData['id']],
          onFeedback: (feedback) => _onMealFeedback(mealData['id'], feedback),
        ),
      ],
    );
  }
}

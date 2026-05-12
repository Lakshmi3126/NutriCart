import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import '../../widgets/loading_state_widget.dart';
import './widgets/budget_tracking_widget.dart';
import './widgets/meal_summary_card_widget.dart';
import './widgets/pantry_alert_widget.dart';
import './widgets/quick_action_card_widget.dart';
import './widgets/recent_meal_explanation_widget.dart';
import './widgets/seasonal_picks_widget.dart';
import './widgets/weekly_progress_chart_widget.dart';
import '../../l10n/app_localizations.dart';
import '../user_profile_setup/widgets/language_selector.dart';

class DashboardInitialPage extends StatefulWidget {
  const DashboardInitialPage({Key? key}) : super(key: key);

  @override
  State<DashboardInitialPage> createState() => _DashboardInitialPageState();
}

class _DashboardInitialPageState extends State<DashboardInitialPage> {
  bool _isLoading = false;
  bool _isOffline = false;
    bool isMealCompleted(String mealTime) {
    final now = DateTime.now();

    final format = DateFormat("hh:mm a");
    final mealDateTime = format.parse(mealTime);

    final mealMinutes =
        mealDateTime.hour * 60 + mealDateTime.minute;

    final currentMinutes =
        now.hour * 60 + now.minute;

    return currentMinutes >= mealMinutes;
  }
  // Mock user data
  final String userName = "Sunita";

  // Mock meal data
  List<Map<String, dynamic>> get todaysMeals => [
    {
      "id": 1,
      "mealType": "Breakfast",
      "name": "Ragi Dosa + Mint Peanut Chutney",
      "calories": 320,
      "isCompleted": isMealCompleted("08:00 AM"),
      "time": "08:00 AM",
      "healthScore": 88,
    },
    {
      "id": 2,
      "mealType": "Mid-Morning",
      "name": "Guava + Almonds",
      "calories": 110,
      "isCompleted": isMealCompleted("10:45 AM"),
      "time": "10:45 AM",
      "healthScore": 86,
    },
    {
      "id": 3,
      "mealType": "Lunch",
      "name": "Brown+White Rice Mix, Sambar & Beans Poriyal",
      "calories": 470,
      "isCompleted": isMealCompleted("01:15 PM"),
      "time": "01:15 PM",
      "healthScore": 90,
    },
    {
      "id": 4,
      "mealType": "Snacks",
      "name": "Roasted Chana Sundal",
      "calories": 160,
      "isCompleted": isMealCompleted("05:00 PM"),
      "time": "05:00 PM",
      "healthScore": 84,
    },
    {
      "id": 5,
      "mealType": "Dinner",
      "name": "2 Phulkas + Lauki Chana Dal + Salad",
      "calories": 620,
      "isCompleted": isMealCompleted("08:15 PM"),
      "time": "08:15 PM",
      "healthScore": 87,
    },
  ];

  // Mock weekly progress data
  final List<Map<String, dynamic>> weeklyProgress = [
    {"day": "Mon", "adherence": 82, "calories": 1680},
    {"day": "Tue", "adherence": 86, "calories": 1715},
    {"day": "Wed", "adherence": 78, "calories": 1665},
    {"day": "Thu", "adherence": 90, "calories": 1730},
    {"day": "Fri", "adherence": 84, "calories": 1695},
    {"day": "Sat", "adherence": 87, "calories": 1750},
    {"day": "Today", "adherence": 89, "calories": 1675},
  ];

  // Mock recent meal explanations
  final List<Map<String, dynamic>> recentExplanations = [
    {
      "meal": "Brown Rice with Dal Tadka",
      "explanation":
          "Balanced carbohydrate distribution supports glucose stability through afternoon classes.",
      "timestamp": "1 hour ago",
    },
    {
      "meal": "Ragi Dosa + Mint Chutney",
      "explanation":
          "Millet batter and low-sodium chutney reduced sugar spike risk while keeping breakfast familiar.",
      "timestamp": "4 hours ago",
    },
  ];

  // Mock pantry alerts
  final List<Map<String, dynamic>> pantryAlerts = [
    {
      "item": "Brown Rice",
      "quantity": "500g",
      "expiryDate": "25/05/2026",
      "daysLeft": 17,
      "urgency": "medium",
    },
    {
      "item": "Curd",
      "quantity": "300g",
      "expiryDate": "11/05/2026",
      "daysLeft": 3,
      "urgency": "high",
    },
  ];

  // Mock budget data
 Map<String, dynamic> get budgetData {
  final now = DateTime.now();

  final monthlyBudget = 9500;

  final totalDaysInMonth =
      DateTime(now.year, now.month + 1, 0).day;

  final daysPassed = now.day;

  final daysLeft = totalDaysInMonth - daysPassed;

  final avgDailySpend = 275;

  final spent = daysPassed * avgDailySpend;

  final remaining = monthlyBudget - spent;

  return {
    "monthlyBudget": monthlyBudget,
    "spent": spent,
    "remaining": remaining > 0 ? remaining : 0,
    "daysLeft": daysLeft,
    "avgDailySpend": avgDailySpend,
    "weeklyEstimate": 1920,
    "currency": "₹",
  };
}


  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final currentDate = DateFormat('EEEE, MMM d').format(DateTime.now());
    final l10n = AppLocalizations.of(context)!;

    if (_isLoading) {
      return const LoadingStateWidget(type: LoadingType.dashboard);
    }

    // Localized Recent Meal Explanations
    final localizedRecentExplanations = [
      {
        "meal": l10n.mockRecentMeal1Name,
        "explanation": l10n.mockRecentMeal1Explanation,
        "timestamp": l10n.mockRecentMeal1Timestamp,
      },
      {
        "meal": l10n.mockRecentMeal2Name,
        "explanation": l10n.mockRecentMeal2Explanation,
        "timestamp": l10n.mockRecentMeal2Timestamp,
      },
    ];

    final finalPantryAlerts = pantryAlerts.map((alert) {
      String item = alert["item"];
      if (item == "Brown Rice") item = l10n.groceryItemBrownRice;
      if (item == "Moong Dal") item = l10n.groceryItemMoongDal;
      return {...alert, "item": item};
    }).toList();

    return RefreshIndicator(
      onRefresh: _handleRefresh,
      color: theme.colorScheme.primary,
      child: CustomScrollView(
        slivers: [
          // Enhanced Greeting Header
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.fromLTRB(4.w, 2.h, 4.w, 3.h),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    theme.colorScheme.primary.withValues(alpha: 0.08),
                    theme.colorScheme.surface,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: const [0.0, 0.7],
                ),
              ),
              child: SafeArea(
                bottom: false,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                l10n.dashboardGreeting(userName),
                                style: theme.textTheme.headlineSmall?.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: theme.colorScheme.onSurface,
                                  fontSize: 20.sp,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 0.5.h),
                              Text(
                                currentDate,
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: theme.colorScheme.onSurfaceVariant,
                                  fontSize: 13.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                        _isOffline
                            ? Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 3.w,
                                  vertical: 1.h,
                                ),
                                decoration: BoxDecoration(
                                  color: theme.colorScheme.errorContainer,
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    CustomIconWidget(
                                      iconName: 'cloud_off',
                                      size: 16,
                                      color: theme.colorScheme.error,
                                    ),
                                    SizedBox(width: 1.w),
                                    Text(
                                      l10n.dashboardOffline,
                                      style: theme.textTheme.labelSmall
                                          ?.copyWith(
                                            color: theme.colorScheme.error,
                                            fontWeight: FontWeight.w600,
                                          ),
                                    ),
                                  ],
                                ),
                              )
                            : Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                    LanguageSelector(isCompact: true),
                                  SizedBox(width: 2.w),
                                  Container(
                                    padding: EdgeInsets.all(2.5.w),
                                    decoration: BoxDecoration(
                                      color: theme.colorScheme.primaryContainer,
                                      shape: BoxShape.circle,
                                    ),
                                    child: CustomIconWidget(
                                      iconName: 'notifications_outlined',
                                      size: 22,
                                      color: theme.colorScheme.primary,
                                    ),
                                  ),
                                ],
                              ),
                      ],
                    ),
                    SizedBox(height: 2.h),
                    // Today's Highlight Card
                    Container(
                      padding: EdgeInsets.all(3.w),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            theme.colorScheme.secondary,
                            theme.colorScheme.secondary.withValues(alpha: 0.8),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(16.0),
                        boxShadow: [
                          BoxShadow(
                            color: theme.colorScheme.secondary.withValues(
                              alpha: 0.3,
                            ),
                            blurRadius: 12.0,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(2.w),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.25),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: CustomIconWidget(
                              iconName: 'check_circle',
                              size: 28,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: 3.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  l10n.dashboardHighlightTitle,
                                  style: theme.textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                    fontSize: 14.sp,
                                  ),
                                ),
                                SizedBox(height: 0.5.h),
                                Text(
                                  l10n.dashboardHighlightSubtitle,
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: Colors.white.withValues(alpha: 0.95),
                                    fontSize: 12.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Today's Meal Summary Card
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 0.5.h),
              child: MealSummaryCardWidget(
                meals: todaysMeals,
                onMealTap: (mealId) => _navigateToMealDetails(mealId),
                onMealLongPress: (mealId) => _showQuickActions(mealId),
              ),
            ),
          ),

          // Quick Action Cards Section
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                            l10n.dashboardQuickActionsTitle,
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: theme.colorScheme.onSurface,
                      fontSize: 16.sp,
                    ),
                  ),
                  SizedBox(height: 1.5.h),
                  Row(
                    children: [
                      Expanded(
                        child: QuickActionCardWidget(
                          icon: 'restaurant_menu',
                                  title: l10n.dashboardQuickActionMealPlanTitle,
                                  subtitle:
                                      l10n.dashboardQuickActionMealPlanSubtitle,
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              AppRoutes.dailyMealPlan,
                            );
                          },
                        ),
                      ),
                      SizedBox(width: 3.w),
                      Expanded(
                        child: QuickActionCardWidget(
                          icon: 'shopping_cart',
                                  title: l10n.dashboardQuickActionGroceryTitle,
                                  subtitle:
                                      l10n.dashboardQuickActionGrocerySubtitle,
                          onTap: () => Navigator.of(
                            context,
                            rootNavigator: true,
                          ).pushNamed('/grocery-list'),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 2.w),
                  QuickActionCardWidget(
                    icon: 'account_balance_wallet',
                            title: l10n.dashboardQuickActionBudgetTitle,
                            subtitle: l10n.dashboardQuickActionBudgetSubtitle,
                    onTap: () {},
                    isFullWidth: true,
                  ),
                  QuickActionCardWidget(
                    icon: 'kitchen',
                            title: l10n.dashboardQuickActionPantryTitle,
                            subtitle: l10n.dashboardQuickActionPantrySubtitle,
                    isFullWidth: true,
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.pantryManagement);
                    },
                  ),
                  QuickActionCardWidget(
                    icon: 'auto_fix_high',
                            title: l10n.dashboardQuickActionReengineeringTitle,
                            subtitle:
                                l10n.dashboardQuickActionReengineeringSubtitle,
                    isFullWidth: true,
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.mealReEngineering);
                    },
                  ),
                  QuickActionCardWidget(
                    icon: 'insights',
                            title: l10n.dashboardQuickActionInsightsTitle,
                            subtitle:
                                l10n.dashboardQuickActionInsightsSubtitle,
                    isFullWidth: true,
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.healthInsights);
                    },
                  ),
                ],
              ),
            ),
          ),

          // Seasonal Picks Near You
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
              child: const SeasonalPicksWidget(),
            ),
          ),

          // Budget Tracking Widget
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
              child: BudgetTrackingWidget(budgetData: budgetData),
            ),
          ),

          // Weekly Progress Chart
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
              child: WeeklyProgressChartWidget(progressData: weeklyProgress),
            ),
          ),

          // Recent Meal Explanations
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                            l10n.dashboardWhyTheseMealsTitle,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  SizedBox(height: 1.h),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: localizedRecentExplanations.length,
                    separatorBuilder: (context, index) => SizedBox(height: 1.h),
                    itemBuilder: (context, index) {
                      return RecentMealExplanationWidget(
                        explanation: localizedRecentExplanations[index],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),

          // Pantry Alerts
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                            l10n.dashboardPantryAlertsTitle,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  SizedBox(height: 1.h),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: finalPantryAlerts.length,
                    separatorBuilder: (context, index) => SizedBox(height: 1.h),
                    itemBuilder: (context, index) {
                      return PantryAlertWidget(alert: finalPantryAlerts[index]);
                    },
                  ),
                ],
              ),
            ),
          ),

          // Bottom spacing
          SliverToBoxAdapter(child: SizedBox(height: 10.h)),
        ],
      ),
    );
  }

  Future<void> _handleRefresh() async {
    setState(() => _isLoading = true);

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _isLoading = false;
      _isOffline = false;
    });
  }

  void _navigateToMealDetails(int mealId) {
    Navigator.of(
      context,
      rootNavigator: true,
    ).pushNamed('/meal-details', arguments: {'mealId': mealId});
  }

  void _showQuickActions(int mealId) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    showModalBottomSheet(
      context: context,
      backgroundColor: theme.colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 12.w,
                  height: 0.5.h,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.onSurfaceVariant.withValues(
                      alpha: 0.3,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  l10n.dashboardQuickActionsTitle,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 2.h),
                _buildQuickActionTile(
                  icon: 'check_circle',
                  title: l10n.dashboardModalMarkComplete,
                  onTap: () {
                    Navigator.pop(context);
                    _markMealComplete(mealId);
                  },
                  theme: theme,
                ),
                _buildQuickActionTile(
                  icon: 'cancel',
                  title: l10n.dashboardModalSkipMeal,
                  onTap: () {
                    Navigator.pop(context);
                    _skipMeal(mealId);
                  },
                  theme: theme,
                ),
                _buildQuickActionTile(
                  icon: 'swap_horiz',
                  title: l10n.dashboardModalRequestAlternative,
                  onTap: () {
                    Navigator.pop(context);
                    _requestAlternative(mealId);
                  },
                  theme: theme,
                ),
                SizedBox(height: 1.h),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildQuickActionTile({
    required String icon,
    required String title,
    required VoidCallback onTap,
    required ThemeData theme,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.5.h),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(2.w),
              decoration: BoxDecoration(
                color: theme.colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(8),
              ),
              child: CustomIconWidget(
                iconName: icon,
                size: 24,
                color: theme.colorScheme.primary,
              ),
            ),
            SizedBox(width: 3.w),
            Text(
              title,
              style: theme.textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _markMealComplete(int mealId) {
    // Implementation for marking meal complete
  }

  void _skipMeal(int mealId) {
    // Implementation for skipping meal
  }

  void _requestAlternative(int mealId) {
    // Implementation for requesting alternative
  }

}

import 'package:flutter/material.dart';
import 'package:nutricart/l10n/app_localizations.dart';
import 'package:sizer/sizer.dart';

import '../../services/health_insights_mock_service.dart';
import '../../widgets/loading_state_widget.dart';
import './widgets/health_summary_card_widget.dart';
import './widgets/nutrient_balance_widget.dart';
import './widgets/weekly_trend_widget.dart';
import './widgets/insight_card_widget.dart';
import './widgets/recommendation_widget.dart';

class HealthInsights extends StatefulWidget {
  const HealthInsights({Key? key}) : super(key: key);

  @override
  State<HealthInsights> createState() => _HealthInsightsState();
}

class _HealthInsightsState extends State<HealthInsights> {
  bool _isLoading = true;
  Map<String, dynamic> _healthData = {};

  @override
  void initState() {
    super.initState();
    _loadHealthInsights();
  }

  Future<void> _loadHealthInsights() async {
    setState(() => _isLoading = true);
    try {
      final data = await HealthInsightsMockService.getHealthInsights();
      setState(() {
        _healthData = data;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _handleRefresh() async {
    await _loadHealthInsights();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    if (_isLoading) {
      return const Scaffold(
        body: LoadingStateWidget(type: LoadingType.dashboard),
      );
    }

    final healthScore = _healthData['healthScore'] ?? 0;
    final weeklyChange = _healthData['weeklyChange'] ?? 0;
    final healthConditions =
        _healthData['healthConditions'] as List<dynamic>? ?? [];
    final nutrientBalance =
        _healthData['nutrientBalance'] as Map<String, dynamic>? ?? {};
    final weeklyTrends =
        _healthData['weeklyTrends'] as Map<String, dynamic>? ?? {};
    final insights = _healthData['insights'] as List<dynamic>? ?? [];
    final recommendations =
        _healthData['recommendations'] as List<dynamic>? ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n.insightsTitle,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w700,
            fontSize: 18.sp,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh, size: 24),
            onPressed: _handleRefresh,
            tooltip: l10n.insightsRefreshTooltip,
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _handleRefresh,
        color: theme.colorScheme.primary,
        child: CustomScrollView(
          slivers: [
            // Health Score Header
            SliverToBoxAdapter(
              child: Container(
                margin: EdgeInsets.fromLTRB(4.w, 2.h, 4.w, 2.h),
                padding: EdgeInsets.all(4.w),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      theme.colorScheme.primary,
                      theme.colorScheme.primary.withValues(alpha: 0.8),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16.0),
                  boxShadow: [
                    BoxShadow(
                      color: theme.colorScheme.primary.withValues(alpha: 0.3),
                      blurRadius: 12.0,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      l10n.insightsYourHealthScore,
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: Colors.white.withValues(alpha: 0.9),
                        fontSize: 14.sp,
                      ),
                    ),
                    SizedBox(height: 1.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '$healthScore',
                          style: theme.textTheme.displayLarge?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                            fontSize: 48.sp,
                            height: 1.0,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 1.5.h, left: 1.w),
                          child: Text(
                            '/100',
                            style: theme.textTheme.titleLarge?.copyWith(
                              color: Colors.white.withValues(alpha: 0.8),
                              fontSize: 18.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 1.h),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 3.w,
                        vertical: 0.8.h,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            weeklyChange >= 0
                                ? Icons.trending_up
                                : Icons.trending_down,
                            color: Colors.white,
                            size: 16,
                          ),
                          SizedBox(width: 1.w),
                          Text(
                            l10n.insightsWeeklyChange(
                              '${weeklyChange >= 0 ? '+' : ''}$weeklyChange',
                            ),
                            style: theme.textTheme.labelMedium?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 12.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Section: Health Summary Cards
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(4.w, 2.h, 4.w, 1.h),
                child: Text(
                  l10n.insightsHealthConditions,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 16.sp,
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final condition = healthConditions[index];
                  return HealthSummaryCardWidget(condition: condition);
                }, childCount: healthConditions.length),
              ),
            ),

            // Section: Nutrient Balance
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(4.w, 3.h, 4.w, 1.h),
                child: Text(
                  l10n.insightsNutrientBalance,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 16.sp,
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: NutrientBalanceWidget(nutrients: nutrientBalance),
            ),

            // Section: Weekly Trends
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(4.w, 3.h, 4.w, 1.h),
                child: Text(
                  l10n.insightsWeeklyTrends,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 16.sp,
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(child: WeeklyTrendWidget(trends: weeklyTrends)),

            // Section: Insights
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(4.w, 3.h, 4.w, 1.h),
                child: Text(
                  l10n.insightsPersonalizedInsights,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 16.sp,
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final insight = insights[index];
                  return InsightCardWidget(insight: insight);
                }, childCount: insights.length),
              ),
            ),

            // Section: Recommendations
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(4.w, 3.h, 4.w, 1.h),
                child: Text(
                  l10n.insightsRecommendations,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 16.sp,
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final recommendation = recommendations[index];
                  return RecommendationWidget(recommendation: recommendation);
                }, childCount: recommendations.length),
              ),
            ),

            // Bottom spacing
            SliverToBoxAdapter(child: SizedBox(height: 3.h)),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import '../../services/meal_re_engineering_mock_service.dart';
import '../../widgets/custom_error_widget.dart';
import '../../widgets/custom_icon_widget.dart';
import '../../widgets/loading_state_widget.dart';
import './widgets/action_buttons_widget.dart';
import './widgets/impact_summary_widget.dart';
import './widgets/meal_comparison_card_widget.dart';
import './widgets/reason_explanation_widget.dart';

/// Meal Re-engineering screen showing intelligent meal substitution
/// with comprehensive comparison analysis and user-controlled acceptance workflow
class MealReEngineering extends StatefulWidget {
  const MealReEngineering({Key? key}) : super(key: key);

  @override
  State<MealReEngineering> createState() => _MealReEngineeringState();
}

class _MealReEngineeringState extends State<MealReEngineering> {
  bool _isLoading = true;
  bool _hasError = false;
  Map<String, dynamic>? _mealData;
  int _pendingUpdates = 0;

  @override
  void initState() {
    super.initState();
    _loadMealData();
  }

  Future<void> _loadMealData() async {
    try {
      setState(() {
        _isLoading = true;
        _hasError = false;
      });

      final data =
          await MealReEngineeringMockService.getMealReEngineeringData();
      final count = await MealReEngineeringMockService.getPendingUpdatesCount();

      setState(() {
        _mealData = data;
        _pendingUpdates = count;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _hasError = true;
        _isLoading = false;
      });
    }
  }

  void _handleAcceptChange() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Meal modification saved for Sunita\'s plan'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        behavior: SnackBarBehavior.floating,
      ),
    );
    // Navigate back after acceptance
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        Navigator.pop(context);
      }
    });
  }

  void _handleViewAlternatives() {
    final alternatives = _mealData?['alternatives'] as List<dynamic>? ?? [];

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      builder: (context) {
        final theme = Theme.of(context);
        return Container(
          padding: EdgeInsets.all(4.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 12.w,
                  height: 0.5.h,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.outline.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                'Practical alternatives',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 16.sp,
                ),
              ),
              SizedBox(height: 2.h),
              ...alternatives.map((alt) => _buildAlternativeItem(alt, theme)),
              SizedBox(height: 2.h),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAlternativeItem(Map<String, dynamic> alt, ThemeData theme) {
    return Container(
      margin: EdgeInsets.only(bottom: 2.h),
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        border: Border.all(
          color: theme.colorScheme.outline.withValues(alpha: 0.2),
        ),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  alt['name'] as String,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 0.5.h),
                Row(
                  children: [
                    CustomIconWidget(
                      iconName: 'local_fire_department',
                      color: const Color(0xFFFF6F00),
                      size: 14,
                    ),
                    SizedBox(width: 1.w),
                    Text(
                      '${alt['calories']} kcal',
                      style: theme.textTheme.bodySmall,
                    ),
                    SizedBox(width: 3.w),
                    CustomIconWidget(
                      iconName: 'currency_rupee',
                      color: theme.colorScheme.secondary,
                      size: 14,
                    ),
                    Text('₹${alt['cost']}', style: theme.textTheme.bodySmall),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 2.5.w, vertical: 0.8.h),
            decoration: BoxDecoration(
              color: theme.colorScheme.secondaryContainer,
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Text(
              alt['healthBadge'] as String,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.secondary,
                fontWeight: FontWeight.w600,
                fontSize: 10.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleLearnMore() {
    showDialog(
      context: context,
      builder: (context) {
        final theme = Theme.of(context);
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          title: Row(
            children: [
              CustomIconWidget(
                iconName: 'lightbulb',
                color: theme.colorScheme.primary,
                size: 24,
              ),
              SizedBox(width: 2.w),
              Text(
                'How adaptation works',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'NutriCart frontend logic checks:',
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 1.h),
              _buildLearnMorePoint(
                'Sunita\'s diabetes and mild hypertension goals',
                theme,
              ),
              _buildLearnMorePoint(
                'Household budget range and low-cost substitutions',
                theme,
              ),
              _buildLearnMorePoint(
                'Cultural meal familiarity for family acceptance',
                theme,
              ),
              _buildLearnMorePoint(
                'Simple daily feedback like skipped or partial meals',
                theme,
              ),
              SizedBox(height: 2.h),
              Text(
                'When adjustments are needed, meals stay familiar while portions, oil, sodium, or grain mix are tuned.',
                style: theme.textTheme.bodyMedium,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Got it',
                style: TextStyle(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildLearnMorePoint(String text, ThemeData theme) {
    return Padding(
      padding: EdgeInsets.only(bottom: 1.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 0.5.h),
            child: CustomIconWidget(
              iconName: 'check_circle',
              color: theme.colorScheme.secondary,
              size: 16,
            ),
          ),
          SizedBox(width: 2.w),
          Expanded(child: Text(text, style: theme.textTheme.bodyMedium)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: SafeArea(
        child: _isLoading
            ? const LoadingStateWidget()
            : _hasError
            ? const CustomErrorWidget(
                errorMessage: 'Failed to load meal updates',
              )
            : CustomScrollView(
                slivers: [
                  // Header with notification badge
                  SliverToBoxAdapter(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            theme.colorScheme.primary,
                            theme.colorScheme.primary.withValues(alpha: 0.8),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(4.w, 2.h, 4.w, 3.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                IconButton(
                                  icon: const Icon(
                                    Icons.arrow_back,
                                    color: Colors.white,
                                  ),
                                  onPressed: () => Navigator.pop(context),
                                ),
                                Expanded(
                                  child: Text(
                                    'Adaptive Meal Re-Engineering',
                                    style: theme.textTheme.titleLarge?.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18.sp,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 2.5.w,
                                    vertical: 0.8.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: Text(
                                    '$_pendingUpdates',
                                    style: theme.textTheme.labelMedium
                                        ?.copyWith(
                                          color: theme.colorScheme.primary,
                                          fontWeight: FontWeight.w700,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 1.h),
                            Padding(
                              padding: EdgeInsets.only(left: 12.w),
                              child: Text(
                                'Familiar meals adjusted for glucose stability, lower sodium, and budget fit',
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: Colors.white.withValues(alpha: 0.9),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Comparison section
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.all(4.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Original vs modified meal',
                            style: theme.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.w700,
                              fontSize: 16.sp,
                            ),
                          ),
                          SizedBox(height: 2.h),
                          MealComparisonCardWidget(
                            originalMeal:
                                _mealData?['originalMeal']
                                    as Map<String, dynamic>,
                            updatedMeal:
                                _mealData?['updatedMeal']
                                    as Map<String, dynamic>,
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Reason & Explanation section
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4.w),
                      child: ReasonExplanationWidget(
                        reasonData:
                            _mealData?['reason'] as Map<String, dynamic>,
                      ),
                    ),
                  ),

                  SizedBox(height: 2.h).toSliver(),

                  // Impact Summary section
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4.w),
                      child: ImpactSummaryWidget(
                        impactData:
                            _mealData?['impact'] as Map<String, dynamic>,
                      ),
                    ),
                  ),

                  SizedBox(height: 2.h).toSliver(),

                  // Action buttons
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(4.w, 0, 4.w, 3.h),
                      child: ActionButtonsWidget(
                        onAcceptChange: _handleAcceptChange,
                        onViewAlternatives: _handleViewAlternatives,
                        onLearnMore: _handleLearnMore,
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

// Extension to convert SizedBox to Sliver
extension SizedBoxExtension on SizedBox {
  Widget toSliver() => SliverToBoxAdapter(child: this);
}
import 'package:flutter/material.dart';
import 'package:nutricart/l10n/app_localizations.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

/// Simplified meal card widget for Daily Meal Plan
/// Displays meal information with interactive feedback buttons
class MealCardSimpleWidget extends StatelessWidget {
  final Map<String, dynamic> mealData;
  final String? selectedFeedback;
  final Function(String) onFeedback;

  const MealCardSimpleWidget({
    Key? key,
    required this.mealData,
    this.selectedFeedback,
    required this.onFeedback,
  }) : super(key: key);

  String _getLocalizedText(BuildContext context, String? key) {
    if (key == null || key.isEmpty) return '';
    final l10n = AppLocalizations.of(context)!;
    
    switch (key) {
      case 'mealPlanOatsUpma': return l10n.mealPlanOatsUpma;
      case 'mealPlanMoongDalCheela': return l10n.mealPlanMoongDalCheela;
      case 'mealPlanRagiDosa': return l10n.mealPlanRagiDosa;
      case 'mealPlanBrownRiceDal': return l10n.mealPlanBrownRiceDal;
      case 'mealPlanQuinoaPulao': return l10n.mealPlanQuinoaPulao;
      case 'mealPlanGrilledChicken': return l10n.mealPlanGrilledChicken;
      case 'mealPlanPalakPaneer': return l10n.mealPlanPalakPaneer;
      case 'mealPlanVegKhichdi': return l10n.mealPlanVegKhichdi;
      case 'mealPlanGrilledFish': return l10n.mealPlanGrilledFish;
      case 'mealPlanMixedNuts': return l10n.mealPlanMixedNuts;
      case 'mealPlanFruitSalad': return l10n.mealPlanFruitSalad;
      case 'mealPlanRoastedChickpeas': return l10n.mealPlanRoastedChickpeas;
      case 'mealPlanDiabetesSafe': return l10n.mealPlanDiabetesSafe;
      case 'mealPlanPCOSFriendly': return l10n.mealPlanPCOSFriendly;
      case 'mealPlanHeartHealthy': return l10n.mealPlanHeartHealthy;
      case 'mealPlanIronRich': return l10n.mealPlanIronRich;
      case 'mealPlanHighProtein': return l10n.mealPlanHighProtein;
      case 'mealPlanVitaminRich': return l10n.mealPlanVitaminRich;
      case 'mealPlanHighFiber': return l10n.mealPlanHighFiber;
      case 'mealPlanOatsUpmaExpl': return l10n.mealPlanOatsUpmaExpl;
      case 'mealPlanMoongDalExpl': return l10n.mealPlanMoongDalExpl;
      case 'mealPlanRagiDosaExpl': return l10n.mealPlanRagiDosaExpl;
      case 'mealPlanBrownRiceExpl': return l10n.mealPlanBrownRiceExpl;
      case 'mealPlanQuinoaExpl': return l10n.mealPlanQuinoaExpl;
      case 'mealPlanGrilledChickenExpl': return l10n.mealPlanGrilledChickenExpl;
      case 'mealPlanPalakPaneerExpl': return l10n.mealPlanPalakPaneerExpl;
      case 'mealPlanVegKhichdiExpl': return l10n.mealPlanVegKhichdiExpl;
      case 'mealPlanGrilledFishExpl': return l10n.mealPlanGrilledFishExpl;
      case 'mealPlanMixedNutsExpl': return l10n.mealPlanMixedNutsExpl;
      case 'mealPlanFruitSaladExpl': return l10n.mealPlanFruitSaladExpl;
      case 'mealPlanRoastedChickpeasExpl': return l10n.mealPlanRoastedChickpeasExpl;
      default: return key;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final time = mealData['time'] as String? ?? '';
    final sodiumMg = mealData['sodiumMg'];
    final glycemicNote = mealData['glycemicNote'] as String?;

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
        side: BorderSide(
          color: theme.colorScheme.outline.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Meal image with health badge
          ClipRRect(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(15.0),
            ),
            child: Stack(
              children: [
                CustomImageWidget(
                  imageUrl: mealData['image'] as String,
                  width: double.infinity,
                  height: 18.h,
                  fit: BoxFit.cover,
                  semanticLabel: mealData['semanticLabel'] as String,
                ),
                // Health Badge
                Positioned(
                  top: 2.w,
                  right: 2.w,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 2.5.w,
                      vertical: 0.8.h,
                    ),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF43A047), Color(0xFF66BB6A)],
                      ),
                      borderRadius: BorderRadius.circular(20.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.2),
                          blurRadius: 4.0,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const CustomIconWidget(
                          iconName: 'verified',
                          color: Colors.white,
                          size: 14,
                        ),
                        SizedBox(width: 1.w),
                        Text(
                          _getLocalizedText(context, mealData['healthBadge'] as String?),
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 10.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: EdgeInsets.all(3.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Meal name
                Text(
                  _getLocalizedText(context, mealData['name'] as String?),
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 14.sp,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 1.h),

                // Calories and cost
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 2.5.w,
                        vertical: 0.8.h,
                      ),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.secondaryContainer,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const CustomIconWidget(
                            iconName: 'local_fire_department',
                            color: Color(0xFFFF6F00),
                            size: 14,
                          ),
                          SizedBox(width: 1.w),
                          Text(
                            l10n.mealPlanKcal(mealData['calories'].toString()),
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.secondary,
                              fontWeight: FontWeight.w700,
                              fontSize: 11.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 2.w),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 2.5.w,
                        vertical: 0.8.h,
                      ),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const CustomIconWidget(
                            iconName: 'currency_rupee',
                            color: Color(0xFF4A90A4),
                            size: 14,
                          ),
                          SizedBox(width: 0.5.w),
                          Text(
                            AppLocalizations.of(context)!.mealPlanRupee(mealData['cost'].toStringAsFixed(0)),
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.primary,
                              fontWeight: FontWeight.w700,
                              fontSize: 11.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                if (time.isNotEmpty) ...[
                  SizedBox(height: 1.h),
                  Row(
                    children: [
                      CustomIconWidget(
                        iconName: 'schedule',
                        color: theme.colorScheme.primary,
                        size: 16,
                      ),
                      SizedBox(width: 1.5.w),
                      Text(
                        time,
                        style: theme.textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                      if (sodiumMg != null) ...[
                        SizedBox(width: 3.w),
                        CustomIconWidget(
                          iconName: 'water_drop',
                          color: const Color(0xFF4A90A4),
                          size: 16,
                        ),
                        SizedBox(width: 1.w),
                        Text(
                          'Sodium ${sodiumMg} mg',
                          style: theme.textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF4A90A4),
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
                SizedBox(height: 1.5.h),

                // Why this meal explanation
                Container(
                  padding: EdgeInsets.all(2.5.w),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomIconWidget(
                        iconName: 'lightbulb',
                        color: theme.colorScheme.primary,
                        size: 18,
                      ),
                      SizedBox(width: 2.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.mealPlanWhyMeal,
                              style: theme.textTheme.labelSmall?.copyWith(
                                color: theme.colorScheme.primary,
                                fontWeight: FontWeight.w700,
                                fontSize: 10.sp,
                              ),
                            ),
                            SizedBox(height: 0.5.h),
                            Text(
                              _getLocalizedText(context, mealData['explanation'] as String?),
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: theme.colorScheme.onSurfaceVariant,
                                fontSize: 11.sp,
                              ),
                            ),
                            if (glycemicNote != null && glycemicNote.isNotEmpty) ...[
                              SizedBox(height: 0.7.h),
                              Text(
                                glycemicNote,
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: theme.colorScheme.secondary,
                                  fontSize: 10.5.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 2.h),

                // Feedback buttons
                Text(
                  AppLocalizations.of(context)!.mealPlanFeedbackTitle,
                  style: theme.textTheme.labelMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 12.sp,
                  ),
                ),
                SizedBox(height: 1.h),
                Row(
                  children: [
                    Expanded(
                      child: _buildFeedbackButton(
                        context,
                        AppLocalizations.of(context)!.mealPlanEaten,
                        'check_circle',
                        'eaten',
                        theme.colorScheme.secondary,
                      ),
                    ),
                    SizedBox(width: 2.w),
                    Expanded(
                      child: _buildFeedbackButton(
                        context,
                        AppLocalizations.of(context)!.mealPlanPartial,
                        'remove_circle',
                        'partial',
                        const Color(0xFFFFB74D),
                      ),
                    ),
                    SizedBox(width: 2.w),
                    Expanded(
                      child: _buildFeedbackButton(
                        context,
                        AppLocalizations.of(context)!.mealPlanSkipped,
                        'cancel',
                        'skipped',
                        theme.colorScheme.error,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeedbackButton(
    BuildContext context,
    String label,
    String icon,
    String feedbackValue,
    Color color,
  ) {
    final theme = Theme.of(context);
    final isSelected = selectedFeedback == feedbackValue;

    return InkWell(
      onTap: () => onFeedback(feedbackValue),
      borderRadius: BorderRadius.circular(12.0),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 1.2.h),
        decoration: BoxDecoration(
          color: isSelected ? color : color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(
            color: isSelected ? color : color.withValues(alpha: 0.3),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomIconWidget(
              iconName: icon,
              color: isSelected ? Colors.white : color,
              size: 20,
            ),
            SizedBox(height: 0.5.h),
            Text(
              label,
              style: theme.textTheme.labelSmall?.copyWith(
                color: isSelected ? Colors.white : color,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                fontSize: 10.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

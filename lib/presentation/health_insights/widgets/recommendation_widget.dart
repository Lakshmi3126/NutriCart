import 'package:flutter/material.dart';
import 'package:nutricart/l10n/app_localizations.dart';
import 'package:sizer/sizer.dart';


class RecommendationWidget extends StatelessWidget {
  final Map<String, dynamic> recommendation;

  const RecommendationWidget({Key? key, required this.recommendation})
    : super(key: key);

  String _getLocalizedText(BuildContext context, String? key) {
    if (key == null) return '';
    final l10n = AppLocalizations.of(context)!;
    switch (key) {
      case 'mockRecFiberIncreaseTitle':
        return l10n.mockRecFiberIncreaseTitle;
      case 'mockRecFiberIncreaseDesc':
        return l10n.mockRecFiberIncreaseDesc;
      case 'mockRecSugarReduceTitle':
        return l10n.mockRecSugarReduceTitle;
      case 'mockRecSugarReduceDesc':
        return l10n.mockRecSugarReduceDesc;
      case 'mockRecProteinMaintainTitle':
        return l10n.mockRecProteinMaintainTitle;
      case 'mockRecProteinMaintainDesc':
        return l10n.mockRecProteinMaintainDesc;
      case 'mockRecHydrateTitle':
        return l10n.mockRecHydrateTitle;
      case 'mockRecHydrateDesc':
        return l10n.mockRecHydrateDesc;
      default:
        return key;
    }
  }

  IconData _getIconData(String iconName) {
    switch (iconName) {
      case 'restaurant':
        return Icons.restaurant;
      case 'local_drink':
        return Icons.local_drink;
      case 'thumb_up':
        return Icons.thumb_up;
      case 'water_drop':
        return Icons.water_drop;
      case 'health_and_safety':
        return Icons.health_and_safety;
      case 'event_note':
        return Icons.event_note;
      default:
        return Icons.lightbulb;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final title = recommendation['title'] != null
        ? _getLocalizedText(context, recommendation['title'])
        : AppLocalizations.of(context)!.insightsDefaultRecommendation;
    final description = _getLocalizedText(context, recommendation['description']);
    final actionable = recommendation['actionable'] ?? false;
    final iconName = recommendation['icon'] ?? 'lightbulb';

    return Container(
      margin: EdgeInsets.only(bottom: 2.h),
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(
          color: theme.colorScheme.outline.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(2.5.w),
            decoration: BoxDecoration(
              color: theme.colorScheme.secondaryContainer,
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Icon(
              _getIconData(iconName),
              color: theme.colorScheme.secondary,
              size: 22,
            ),
          ),
          SizedBox(width: 3.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                    if (actionable)
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 2.w,
                          vertical: 0.4.h,
                        ),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.tertiaryContainer,
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Text(
                          AppLocalizations.of(context)!.insightsActionable,
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: theme.colorScheme.tertiary,
                            fontWeight: FontWeight.w600,
                            fontSize: 9.sp,
                          ),
                        ),
                      ),
                  ],
                ),
                SizedBox(height: 0.8.h),
                Text(
                  description,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                    fontSize: 12.sp,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:nutricart/l10n/app_localizations.dart';
import 'package:sizer/sizer.dart';


class InsightCardWidget extends StatelessWidget {
  final Map<String, dynamic> insight;

  const InsightCardWidget({Key? key, required this.insight}) : super(key: key);

  String _getLocalizedText(BuildContext context, String? key) {
    if (key == null) return '';
    final l10n = AppLocalizations.of(context)!;
    switch (key) {
      case 'mockInsightConsistentTimingTitle':
        return l10n.mockInsightConsistentTimingTitle;
      case 'mockInsightConsistentTimingDesc':
        return l10n.mockInsightConsistentTimingDesc;
      case 'mockInsightFiberLowTitle':
        return l10n.mockInsightFiberLowTitle;
      case 'mockInsightFiberLowDesc':
        return l10n.mockInsightFiberLowDesc;
      case 'mockInsightBudgetOptTitle':
        return l10n.mockInsightBudgetOptTitle;
      case 'mockInsightBudgetOptDesc':
        return l10n.mockInsightBudgetOptDesc;
      case 'mockInsightSugarHighTitle':
        return l10n.mockInsightSugarHighTitle;
      case 'mockInsightSugarHighDesc':
        return l10n.mockInsightSugarHighDesc;
      default:
        return key;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority.toLowerCase()) {
      case 'high':
        return const Color(0xFFE53935);
      case 'medium':
        return const Color(0xFFFB8C00);
      case 'low':
        return const Color(0xFF43A047);
      default:
        return const Color(0xFF4A90A4);
    }
  }

  IconData _getIconData(String iconName) {
    switch (iconName) {
      case 'schedule':
        return Icons.schedule;
      case 'trending_down':
        return Icons.trending_down;
      case 'savings':
        return Icons.savings;
      case 'warning':
        return Icons.warning;
      case 'trending_up':
        return Icons.trending_up;
      case 'monitor_heart':
        return Icons.monitor_heart;
      default:
        return Icons.info;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final title = insight['title'] != null
        ? _getLocalizedText(context, insight['title'])
        : AppLocalizations.of(context)!.insightsDefaultTitle;
    final description = _getLocalizedText(context, insight['description']);
    final priority = insight['priority'] ?? 'low';
    final iconName = insight['icon'] ?? 'info';

    final priorityColor = _getPriorityColor(priority);

    return Container(
      margin: EdgeInsets.only(bottom: 2.h),
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(
          color: priorityColor.withValues(alpha: 0.3),
          width: 1.5,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(2.5.w),
            decoration: BoxDecoration(
              color: priorityColor.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Icon(_getIconData(iconName), color: priorityColor, size: 22),
          ),
          SizedBox(width: 3.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 14.sp,
                  ),
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

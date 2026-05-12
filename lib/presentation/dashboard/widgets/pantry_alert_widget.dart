import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../core/app_export.dart';
import '../../../l10n/app_localizations.dart';

class PantryAlertWidget extends StatelessWidget {
  final Map<String, dynamic> alert;

  const PantryAlertWidget({Key? key, required this.alert}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final urgency = alert["urgency"] as String;
    final daysLeft = alert["daysLeft"] as int;

    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: _getUrgencyColor(urgency, theme).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: _getUrgencyColor(urgency, theme).withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(2.w),
            decoration: BoxDecoration(
              color: _getUrgencyColor(urgency, theme),
              borderRadius: BorderRadius.circular(8),
            ),
            child: CustomIconWidget(
              iconName: urgency == 'high' ? 'warning' : 'info',
              size: 20,
              color: theme.colorScheme.onError,
            ),
          ),
          SizedBox(width: 3.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  alert["item"] as String,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                SizedBox(height: 0.5.h),
                Text(
                  '${alert["quantity"]} • Expires: ${alert["expiryDate"]}',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
            decoration: BoxDecoration(
              color: _getUrgencyColor(urgency, theme),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              l10n.profileUnitDays(daysLeft),
              style: theme.textTheme.labelSmall?.copyWith(
                color: theme.colorScheme.onError,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getUrgencyColor(String urgency, ThemeData theme) {
    switch (urgency.toLowerCase()) {
      case 'high':
        return theme.colorScheme.error;
      case 'medium':
        return Colors.orange;
      default:
        return theme.colorScheme.primary;
    }
  }
}

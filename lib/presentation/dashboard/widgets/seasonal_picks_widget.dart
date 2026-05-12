import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../widgets/custom_icon_widget.dart';
import '../../../l10n/app_localizations.dart';

class SeasonalPicksWidget extends StatelessWidget {
  const SeasonalPicksWidget({super.key});

  List<Map<String, String>> _localizedSeasonalItems(AppLocalizations l10n) => [
        // Fruits
        {
          'name': l10n.mockSeasonalPick1Name,
          'type': l10n.seasonalFruit,
          'tag': l10n.mockSeasonalPick1Tag,
          'descriptor': l10n.mockSeasonalPick1Descriptor,
        },
        {
          'name': 'Grapes', // Or add more keys if needed, but I'll at least use l10n.seasonalFruit
          'type': l10n.seasonalFruit,
          'tag': l10n.seasonalTagPeakSeason,
          'descriptor': l10n.seasonalDescriptorPeakFeb,
        },
        {
          'name': 'Papaya',
          'type': l10n.seasonalFruit,
          'tag': l10n.seasonalTagLocallyAbundant,
          'descriptor': l10n.seasonalDescriptorCityMarkets,
        },
        // Vegetables
        {
          'name': l10n.mockSeasonalPick2Name,
          'type': l10n.seasonalVegetable,
          'tag': l10n.mockSeasonalPick2Tag,
          'descriptor': l10n.mockSeasonalPick2Descriptor,
        },
      ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.seasonalSectionTitle,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w700,
            color: theme.colorScheme.onSurface,
            fontSize: 16.sp,
          ),
        ),
        SizedBox(height: 0.5.h),
        Text(
          l10n.seasonalSectionSubtitle,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
            fontSize: 11.5.sp,
          ),
        ),
        SizedBox(height: 2.h),
        SizedBox(
          height: 22.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: _localizedSeasonalItems(l10n).length,
            separatorBuilder: (_, __) => SizedBox(width: 3.w),
            itemBuilder: (context, index) {
              final item = _localizedSeasonalItems(l10n)[index];
              return _buildSeasonalCard(context, item);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSeasonalCard(
    BuildContext context,
    Map<String, String> item,
  ) {
    final theme = Theme.of(context);
    final type = item['type'] ?? '';
    final name = item['name'] ?? '';
    final tag = item['tag'] ?? '';
    final descriptor = item['descriptor'] ?? 'Seasonal in Feb';

    return SizedBox(
      width: 60.w,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.0),
        child: Card(
          elevation: 0,
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
            side: BorderSide(
              color: theme.colorScheme.outline.withValues(alpha: 0.2),
              width: 1,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(3.5.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(2.5.w),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: CustomIconWidget(
                        iconName: _iconForType(type),
                        size: 22,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                    SizedBox(width: 2.5.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            type,
                            style: theme.textTheme.labelMedium?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 0.3.h),
                          Text(
                            tag,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.secondary,
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 1.2.h),
                Text(
                  name,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: theme.colorScheme.onSurface,
                    fontSize: 14.sp,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 0.5.h),
                Text(
                  descriptor,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                    fontSize: 11.sp,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const Spacer(),
                SizedBox(height: 0.8.h),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: () {
                      final l10n = AppLocalizations.of(context)!;
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(l10n.seasonalSnackAddedToGrocery),
                          duration: const Duration(seconds: 2),
                        ),
                      );
                    },
                    style: FilledButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        vertical: 0.9.h,
                      ),
                      backgroundColor: theme.colorScheme.primary,
                      foregroundColor: theme.colorScheme.onPrimary,
                      textStyle: theme.textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 11.sp,
                      ),
                    ),
                    icon: const Icon(Icons.add_shopping_cart, size: 18),
                    label: Builder(
                      builder: (context) {
                        final l10n = AppLocalizations.of(context)!;
                        return Text(l10n.seasonalButtonAddToGrocery);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _iconForType(String type) {
    final lower = type.toLowerCase();
    if (lower.contains('fruit')) {
      return 'spa';
    }
    if (lower.contains('vegetable')) {
      return 'eco';
    }
    return 'local_grocery_store';
  }
}



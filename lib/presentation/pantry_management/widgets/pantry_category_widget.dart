import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../l10n/app_localizations.dart';

/// Pantry category widget displaying collapsible sections
/// with categorized ingredients and swipe actions.
class PantryCategoryWidget extends StatefulWidget {
  final Map<String, dynamic> category;
  final Function(String, String) onAddToGroceryList;
  final Function(String, String, double) onMarkAsUsed;

  const PantryCategoryWidget({
    Key? key,
    required this.category,
    required this.onAddToGroceryList,
    required this.onMarkAsUsed,
  }) : super(key: key);

  @override
  State<PantryCategoryWidget> createState() => _PantryCategoryWidgetState();
}

class _PantryCategoryWidgetState extends State<PantryCategoryWidget> {
  bool _isExpanded = true;

  Color _getStatusColor(String status, ThemeData theme) {
    switch (status.toLowerCase()) {
      case 'fresh':
        return AppTheme.successLight;
      case 'expiring_soon':
        return AppTheme.warningLight;
      case 'expired':
        return theme.colorScheme.error;
      default:
        return theme.colorScheme.primary;
    }
  }

  String _getStatusLabel(String status, AppLocalizations l10n) {
    switch (status.toLowerCase()) {
      case 'fresh':
        return l10n.pantryStatusFresh;
      case 'expiring_soon':
        return l10n.pantryStatusExpiringSoon;
      case 'expired':
        return l10n.pantryStatusExpired;
      default:
        return l10n.pantryStatusUnknown;
    }
  }

  String _getLocalizedCategoryName(String name, AppLocalizations l10n) {
    switch (name) {
      case 'Vegetables':
        return l10n.pantryCategoryVegetables;
      case 'Grains':
        return l10n.pantryCategoryGrains;
      case 'Spices':
        return l10n.pantryCategorySpices;
      case 'Dairy':
        return l10n.pantryCategoryDairy;
      case 'Proteins':
        return l10n.pantryCategoryProteins;
      default:
        return l10n.pantryCategoryOther;
    }
  }

  String _getLocalizedIngredientName(String name, AppLocalizations l10n) {
    switch (name) {
      case 'Capsicum':
        return l10n.mockIngredientCapsicum;
      case 'Mixed Vegetables':
        return l10n.mockIngredientMixedVeg;
      case 'Dalia (Broken Wheat)':
        return l10n.mockIngredientDalia;
      case 'Onions':
        return l10n.mockIngredientOnions;
      case 'Tomatoes':
        return l10n.mockIngredientTomatoes;
      case 'Spinach':
        return l10n.mockIngredientSpinach;
      case 'Carrots':
        return l10n.mockIngredientCarrots;
      case 'Basmati Rice':
        return l10n.mockIngredientBasmatiRice;
      case 'Whole Wheat Flour':
        return l10n.mockIngredientWheatFlour;
      case 'Moong Dal':
        return l10n.mockIngredientMoongDal;
      case 'Turmeric Powder':
        return l10n.mockIngredientTurmeric;
      case 'Cumin Seeds':
        return l10n.mockIngredientCumin;
      case 'Garam Masala':
        return l10n.mockIngredientGaramMasala;
      case 'Milk':
        return l10n.mockIngredientMilk;
      case 'Yogurt':
        return l10n.mockIngredientYogurt;
      case 'Paneer':
        return l10n.mockIngredientPaneer;
      case 'Chicken Breast':
        return l10n.mockIngredientChicken;
      case 'Eggs':
        return l10n.mockIngredientEggs;
      case 'Green Peas':
        return l10n.mockIngredientGreenPeas;
      case 'Cream':
        return l10n.mockIngredientCream;
      case 'Butter':
        return l10n.mockIngredientButter;
      case 'Coconut Milk':
        return l10n.mockIngredientCoconutMilk;
      default:
        return name;
    }
  }

  String _getLocalizedUnit(String unit, AppLocalizations l10n) {
    switch (unit.toLowerCase()) {
      case 'kg':
        return l10n.unitKg;
      case 'g':
        return l10n.unitG;
      case 'l':
        return l10n.unitL;
      case 'ml':
        return l10n.unitMl;
      case 'pcs':
        return l10n.unitPcs;
      default:
        return unit;
    }
  }

  void _showItemDetails(BuildContext context, Map<String, dynamic> item) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final usageHistory = item['usageHistory'] as List;

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
        builder: (context, scrollController) => Container(
          padding: EdgeInsets.all(4.w),
          child: ListView(
            controller: scrollController,
            children: [
              // Handle bar
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
              // Item name
              Text(
                _getLocalizedIngredientName(item['name'], l10n),
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: theme.colorScheme.onSurface,
                ),
              ),
              SizedBox(height: 2.h),
              // Stock info
              Row(
                children: [
                  Expanded(
                    child: _buildInfoCard(
                      theme,
                      l10n.pantryDetailsStock,
                      '${item['quantity']} ${_getLocalizedUnit(item['unit'], l10n)}',
                      Icons.inventory_2,
                    ),
                  ),
                  SizedBox(width: 3.w),
                  Expanded(
                    child: _buildInfoCard(
                      theme,
                      l10n.pantryDetailsDaysLeft,
                      l10n.pantryDetailsDaysRange(item['daysUntilExpiry'] ?? 0),
                      Icons.calendar_today,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 2.h),
              // Dates
              _buildDateRow(
                theme,
                l10n.pantryDetailsPurchaseDate,
                item['purchaseDate'],
                Icons.shopping_bag,
              ),
              SizedBox(height: 1.h),
              _buildDateRow(
                theme,
                l10n.pantryDetailsExpiryDate,
                item['expiryDate'],
                Icons.event_busy,
              ),
              SizedBox(height: 2.h),
              // Stock level progress
              Text(
                l10n.pantryDetailsStockLevel,
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: theme.colorScheme.onSurface,
                ),
              ),
              SizedBox(height: 1.h),
              LinearProgressIndicator(
                value:
                    (item['currentStock'] as double) /
                    (item['maxStock'] as double),
                backgroundColor: theme.colorScheme.surfaceContainerHighest
                    .withValues(alpha: 0.3),
                valueColor: AlwaysStoppedAnimation<Color>(
                  _getStatusColor(item['status'], theme),
                ),
                minHeight: 1.h,
                borderRadius: BorderRadius.circular(4),
              ),
              SizedBox(height: 0.5.h),
              Text(
                '${item['currentStock']} / ${item['maxStock']} ${_getLocalizedUnit(item['unit'], l10n)}',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              SizedBox(height: 2.h),
              // Usage history
              Text(
                l10n.pantryDetailsUsageHistory,
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: theme.colorScheme.onSurface,
                ),
              ),
              SizedBox(height: 1.h),
              if (usageHistory.isEmpty)
                Text(
                  l10n.pantryDetailsNoUsage,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                    fontStyle: FontStyle.italic,
                  ),
                )
              else
                ...usageHistory.map((usage) {
                  return Container(
                    margin: EdgeInsets.only(bottom: 1.h),
                    padding: EdgeInsets.all(3.w),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surfaceContainerHighest
                          .withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        CustomIconWidget(
                          iconName: 'restaurant',
                          color: theme.colorScheme.primary,
                          size: 20,
                        ),
                        SizedBox(width: 3.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                usage['meal'],
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                usage['date'],
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: theme.colorScheme.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          '${usage['amount']} ${_getLocalizedUnit(item['unit'], l10n)}',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                  );
                }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard(
    ThemeData theme,
    String label,
    String value,
    IconData icon,
  ) {
    return Container(
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: theme.colorScheme.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: theme.colorScheme.primary.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Icon(icon, color: theme.colorScheme.primary, size: 24),
          SizedBox(height: 1.h),
          Text(
            value,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
              color: theme.colorScheme.primary,
            ),
          ),
          SizedBox(height: 0.5.h),
          Text(
            label,
            style: theme.textTheme.labelSmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildDateRow(
    ThemeData theme,
    String label,
    String date,
    IconData icon,
  ) {
    return Row(
      children: [
        Icon(icon, color: theme.colorScheme.onSurfaceVariant, size: 20),
        SizedBox(width: 3.w),
        Text(
          '$label: ',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        Text(
          date,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: theme.colorScheme.onSurface,
          ),
        ),
      ],
    );
  }

  void _showPortionSelector(BuildContext context, Map<String, dynamic> item) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    double selectedPortion = (item['quantity'] as double) * 0.25;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: Text(l10n.pantryDetailsMarkUsedTitle(item['name'])),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(l10n.pantryDetailsSelectPortion, style: theme.textTheme.bodyMedium),
              SizedBox(height: 2.h),
              Slider(
                value: selectedPortion,
                min: 0,
                max: item['quantity'] as double,
                divisions: 20,
                label:
                    '${selectedPortion.toStringAsFixed(1)} ${_getLocalizedUnit(item['unit'], l10n)}',
                onChanged: (value) {
                  setDialogState(() => selectedPortion = value);
                },
              ),
              Center(
                child: Text(
                  '${selectedPortion.toStringAsFixed(1)} ${_getLocalizedUnit(item['unit'], l10n)}',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(l10n.pantryDialogCancel),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                widget.onMarkAsUsed(item['id'], item['name'], selectedPortion);
              },
              child: Text(l10n.pantryDetailsConfirm),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final items = widget.category['items'] as List;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: theme.colorScheme.outline.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          // Category header
          InkWell(
            onTap: () => setState(() => _isExpanded = !_isExpanded),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Container(
              padding: EdgeInsets.all(4.w),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withValues(alpha: 0.1),
                borderRadius: _isExpanded
                    ? const BorderRadius.vertical(top: Radius.circular(12))
                    : BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(2.w),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: CustomIconWidget(
                      iconName: widget.category['icon'],
                      color: theme.colorScheme.onPrimary,
                      size: 20,
                    ),
                  ),
                  SizedBox(width: 3.w),
                  Expanded(
                    child: Text(
                      _getLocalizedCategoryName(widget.category['name'], l10n),
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 3.w,
                      vertical: 0.5.h,
                    ),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '${items.length}',
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: theme.colorScheme.onPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(width: 2.w),
                  Icon(
                    _isExpanded ? Icons.expand_less : Icons.expand_more,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ],
              ),
            ),
          ),
          // Items list
          if (_isExpanded)
            ...items.asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;
              final isLast = index == items.length - 1;

              return Slidable(
                key: ValueKey(item['id']),
                endActionPane: ActionPane(
                  motion: const ScrollMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (context) =>
                          widget.onAddToGroceryList(item['id'], item['name']),
                      backgroundColor: theme.colorScheme.secondary,
                      foregroundColor: theme.colorScheme.onSecondary,
                      icon: Icons.add_shopping_cart,
                      label: l10n.pantryDetailsAddToList,
                    ),
                  ],
                ),
                startActionPane: ActionPane(
                  motion: const ScrollMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (context) =>
                          _showPortionSelector(context, item),
                      backgroundColor: theme.colorScheme.primary,
                      foregroundColor: theme.colorScheme.onPrimary,
                      icon: Icons.check_circle,
                      label: l10n.pantryDetailsMarkUsed,
                    ),
                  ],
                ),
                child: InkWell(
                  onTap: () => _showItemDetails(context, item),
                  child: Container(
                    padding: EdgeInsets.all(4.w),
                    decoration: BoxDecoration(
                      border: isLast
                          ? null
                          : Border(
                              bottom: BorderSide(
                                color: theme.colorScheme.outline.withValues(
                                  alpha: 0.1,
                                ),
                                width: 1,
                              ),
                            ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _getLocalizedIngredientName(
                                      item['name'],
                                      l10n,
                                    ),
                                    style: theme.textTheme.titleSmall?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: theme.colorScheme.onSurface,
                                    ),
                                  ),
                                  SizedBox(height: 0.5.h),
                                  Text(
                                    '${item['quantity']} ${_getLocalizedUnit(item['unit'], l10n)}',
                                    style: theme.textTheme.bodySmall?.copyWith(
                                      color: theme.colorScheme.onSurfaceVariant,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 3.w,
                                vertical: 0.8.h,
                              ),
                              decoration: BoxDecoration(
                                color: _getStatusColor(
                                  item['status'],
                                  theme,
                                ).withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: _getStatusColor(
                                    item['status'],
                                    theme,
                                  ).withValues(alpha: 0.4),
                                  width: 1,
                                ),
                              ),
                              child: Text(
                                _getStatusLabel(item['status'], l10n),
                                style: theme.textTheme.labelSmall?.copyWith(
                                  color: _getStatusColor(item['status'], theme),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 1.h),
                        // Stock progress bar
                        Row(
                          children: [
                            Expanded(
                              child: LinearProgressIndicator(
                                value:
                                    (item['currentStock'] as double) /
                                    (item['maxStock'] as double),
                                backgroundColor: theme
                                    .colorScheme
                                    .surfaceContainerHighest
                                    .withValues(alpha: 0.3),
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  _getStatusColor(item['status'], theme),
                                ),
                                minHeight: 0.8.h,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            SizedBox(width: 3.w),
                            Text(
                              '${((item['currentStock'] as double) / (item['maxStock'] as double) * 100).toStringAsFixed(0)}%',
                              style: theme.textTheme.labelSmall?.copyWith(
                                color: theme.colorScheme.onSurfaceVariant,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 1.h),
                        // Expiry info
                        Row(
                          children: [
                            Icon(
                              Icons.calendar_today,
                              size: 14,
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                            SizedBox(width: 2.w),
                            Text(
                              l10n.pantryDetailsExpiresLabel(
                                item['expiryDate'],
                                item['daysUntilExpiry'] ?? 0,
                              ),
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
        ],
      ),
    );
  }
}

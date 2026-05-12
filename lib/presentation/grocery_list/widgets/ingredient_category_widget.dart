import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../widgets/custom_icon_widget.dart';
import '../../../l10n/app_localizations.dart';

/// Ingredient category widget displaying collapsible sections
/// with categorized ingredients and swipe actions.
class IngredientCategoryWidget extends StatefulWidget {
  final Map<String, dynamic> category;
  final Function(int) onTogglePurchased;
  final Function(int) onAddToPantry;
  final Function(int) onRemoveFromList;

  const IngredientCategoryWidget({
    Key? key,
    required this.category,
    required this.onTogglePurchased,
    required this.onAddToPantry,
    required this.onRemoveFromList,
  }) : super(key: key);

  @override
  State<IngredientCategoryWidget> createState() =>
      _IngredientCategoryWidgetState();
}

class _IngredientCategoryWidgetState extends State<IngredientCategoryWidget> {
  bool _isExpanded = true;

  Color _getCategoryColor(String categoryName, ThemeData theme) {
    switch (categoryName.toLowerCase()) {
      case 'produce':
        return Colors.green;
      case 'dairy':
        return Colors.blue;
      case 'meat':
        return Colors.red;
      case 'bakery':
        return Colors.orange;
      case 'pantry':
        return Colors.brown;
      case 'frozen':
        return Colors.lightBlue;
      case 'beverages':
        return Colors.purple;
      default:
        return theme.colorScheme.primary;
    }
  }

  void _showAlternativesDialog(
    BuildContext context,
    Map<String, dynamic> item,
  ) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final alternatives = item["alternatives"] as List;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.groceryAlternativesTitle(item["name"])),
        content: alternatives.isEmpty
            ? Text(l10n.groceryNoAlternatives)
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: alternatives.map((alt) {
                  return ListTile(
                    leading: CustomIconWidget(
                      iconName: 'swap_horiz',
                      color: theme.colorScheme.secondary,
                      size: 24,
                    ),
                    title: Text(alt),
                    onTap: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(l10n.grocerySwitchedTo(alt))),
                      );
                    },
                  );
                }).toList(),
              ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.groceryClose),
          ),
        ],
      ),
    );
  }

  void _showContextMenu(
    BuildContext context,
    Map<String, dynamic> item,
    int index,
  ) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(4.w),
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
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            SizedBox(height: 2.h),
            ListTile(
              leading: CustomIconWidget(
                iconName: 'edit',
                color: theme.colorScheme.primary,
                size: 24,
              ),
              title: Text(l10n.groceryEditQuantity),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Edit quantity feature')),
                );
              },
            ),
            ListTile(
              leading: CustomIconWidget(
                iconName: 'find_replace',
                color: theme.colorScheme.secondary,
                size: 24,
              ),
               title: Text(l10n.groceryFindAlternatives),
              onTap: () {
                Navigator.pop(context);
                _showAlternativesDialog(context, item);
              },
            ),
            ListTile(
              leading: CustomIconWidget(
                iconName: 'note_add',
                color: theme.colorScheme.tertiary,
                size: 24,
              ),
              title: Text(l10n.groceryAddNotes),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Add notes feature')),
                );
              },
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
    final categoryName = widget.category["category"] as String;
    final iconName = widget.category["icon"] as String;
    final items = widget.category["items"] as List;

    // Filter out items already in pantry
    final visibleItems = items.where((item) => !item["inPantry"]).toList();

    if (visibleItems.isEmpty) {
      return const SizedBox.shrink();
    }

    final purchasedCount = visibleItems
        .where((item) => item["isPurchased"] == true)
        .length;

    return Card(
      elevation: 0,
      margin: EdgeInsets.only(bottom: 2.h),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
        side: BorderSide(
          color: theme.colorScheme.outline.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(15.0),
              bottom: _isExpanded ? Radius.zero : Radius.circular(15.0),
            ),
            child: Container(
              padding: EdgeInsets.all(4.w),
              decoration: BoxDecoration(
                color: _getCategoryColor(
                  categoryName,
                  theme,
                ).withValues(alpha: 0.05),
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(15.0),
                  bottom: _isExpanded ? Radius.zero : Radius.circular(15.0),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(2.5.w),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          _getCategoryColor(categoryName, theme),
                          _getCategoryColor(
                            categoryName,
                            theme,
                          ).withValues(alpha: 0.8),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: CustomIconWidget(
                      iconName: iconName,
                      color: Colors.white,
                      size: 22,
                    ),
                  ),
                  SizedBox(width: 3.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          categoryName,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                            fontSize: 14.sp,
                          ),
                        ),
                        SizedBox(height: 0.5.h),
                        Text(
                          l10n.groceryPurchasedStatus(purchasedCount, visibleItems.length),
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                            fontSize: 11.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(1.5.w),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surfaceContainerHighest,
                      shape: BoxShape.circle,
                    ),
                    child: CustomIconWidget(
                      iconName: _isExpanded ? 'expand_less' : 'expand_more',
                      color: theme.colorScheme.onSurface,
                      size: 24,
                    ),
                  ),
                ],
              ),
            ),
          ),

          if (_isExpanded)
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: visibleItems.length,
              separatorBuilder: (context, index) => Divider(
                height: 1,
                indent: 4.w,
                endIndent: 4.w,
                color: theme.dividerColor.withValues(alpha: 0.5),
              ),
              itemBuilder: (context, index) {
                final item = visibleItems[index];
                final isPurchased = item["isPurchased"] as bool;
                final originalIndex = items.indexOf(item);

                return Slidable(
                  key: ValueKey(item["id"]),
                  startActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (context) =>
                            widget.onAddToPantry(originalIndex),
                        backgroundColor: theme.colorScheme.secondaryContainer,
                        foregroundColor: theme.colorScheme.secondary,
                        icon: Icons.kitchen,
                        label: l10n.groceryPantry,
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ],
                  ),
                  endActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (context) =>
                            widget.onRemoveFromList(originalIndex),
                        backgroundColor: theme.colorScheme.errorContainer,
                        foregroundColor: theme.colorScheme.error,
                        icon: Icons.delete,
                        label: l10n.groceryRemove,
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ],
                  ),
                  child: InkWell(
                    onLongPress: () =>
                        _showContextMenu(context, item, originalIndex),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 4.w,
                        vertical: 2.h,
                      ),
                      child: Row(
                        children: [
                          Checkbox(
                            value: isPurchased,
                            onChanged: (value) =>
                                widget.onTogglePurchased(originalIndex),
                          ),
                          SizedBox(width: 2.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item["name"],
                                  style: theme.textTheme.bodyLarge?.copyWith(
                                    decoration: isPurchased
                                        ? TextDecoration.lineThrough
                                        : null,
                                    color: isPurchased
                                        ? theme.colorScheme.onSurfaceVariant
                                        : theme.colorScheme.onSurface,
                                  ),
                                ),
                                SizedBox(height: 0.5.h),
                                Text(
                                  item["quantity"],
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: theme.colorScheme.onSurfaceVariant,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            '₹${item["price"]}',
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: isPurchased
                                  ? theme.colorScheme.onSurfaceVariant
                                  : theme.colorScheme.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}

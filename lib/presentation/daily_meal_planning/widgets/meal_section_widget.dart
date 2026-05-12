import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../widgets/custom_icon_widget.dart';
import './meal_card_widget.dart';
import './portion_slider_widget.dart';

/// Expandable meal section widget displaying meal recommendations
/// Supports swipe gestures for alternatives and removal
class MealSectionWidget extends StatefulWidget {
  final String mealType;
  final String title;
  final String icon;
  final List<Map<String, dynamic>> recommendations;
  final Map<String, dynamic> selectedMeal;
  final Function(String, Map<String, dynamic>) onMealSelected;
  final Function(Map<String, dynamic>) onMealDetails;
  final Function(String, String) onMealRemoved;
  final Function(String, double) onPortionAdjusted;
  final Function(String, Map<String, dynamic>) onSubstitution;
  final Function(String, Map<String, dynamic>)? onMealFeedback;

  const MealSectionWidget({
    Key? key,
    required this.mealType,
    required this.title,
    required this.icon,
    required this.recommendations,
    required this.selectedMeal,
    required this.onMealSelected,
    required this.onMealDetails,
    required this.onMealRemoved,
    required this.onPortionAdjusted,
    required this.onSubstitution,
    this.onMealFeedback,
  }) : super(key: key);

  @override
  State<MealSectionWidget> createState() => _MealSectionWidgetState();
}

class _MealSectionWidgetState extends State<MealSectionWidget> {
  bool _isExpanded = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hasSelection = widget.selectedMeal.isNotEmpty;

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
        children: [
          InkWell(
            onTap: () => setState(() => _isExpanded = !_isExpanded),
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(15.0),
              bottom: _isExpanded ? Radius.zero : Radius.circular(15.0),
            ),
            child: Container(
              padding: EdgeInsets.all(4.w),
              decoration: BoxDecoration(
                color: _getMealTypeColor(
                  widget.mealType,
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
                    width: 12.w,
                    height: 12.w,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          _getMealTypeColor(widget.mealType, theme),
                          _getMealTypeColor(
                            widget.mealType,
                            theme,
                          ).withValues(alpha: 0.8),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: CustomIconWidget(
                      iconName: widget.icon,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  SizedBox(width: 3.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w700,
                            fontSize: 16.sp,
                          ),
                        ),
                        if (hasSelection) SizedBox(height: 0.5.h),
                        if (hasSelection)
                          Text(
                            widget.selectedMeal['name'] as String? ?? '',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: _getMealTypeColor(widget.mealType, theme),
                              fontWeight: FontWeight.w600,
                              fontSize: 12.sp,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
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
            Padding(
              padding: EdgeInsets.all(4.w),
              child: Column(
                children: [
                  if (hasSelection) ...[
                    Slidable(
                      key: ValueKey(widget.selectedMeal['id']),
                      endActionPane: ActionPane(
                        motion: const ScrollMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (_) {
                              widget.onMealRemoved(
                                widget.mealType,
                                widget.selectedMeal['id'] as String,
                              );
                            },
                            backgroundColor: theme.colorScheme.error,
                            foregroundColor: Colors.white,
                            icon: Icons.delete,
                            label: 'Remove',
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ],
                      ),
                      child: MealCardWidget(
                        meal: widget.selectedMeal,
                        isSelected: true,
                        onTap: () {},
                        onDetails: () =>
                            widget.onMealDetails(widget.selectedMeal),
                        onSubstitution: () => widget.onSubstitution(
                          widget.mealType,
                          widget.selectedMeal,
                        ),
                        onFeedback: widget.onMealFeedback != null
                            ? () => widget.onMealFeedback!(
                                widget.mealType,
                                widget.selectedMeal,
                              )
                            : null,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    PortionSliderWidget(
                      mealType: widget.mealType,
                      selectedMeal: widget.selectedMeal,
                      onPortionAdjusted: widget.onPortionAdjusted,
                    ),
                    SizedBox(height: 2.h),
                    Divider(color: theme.dividerColor.withValues(alpha: 0.5)),
                    SizedBox(height: 2.h),
                    Row(
                      children: [
                        Text(
                          'Other Options',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                            fontSize: 14.sp,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 2.h),
                  ],

                  // Recommendations list
                  ...widget.recommendations.map((meal) {
                    final isCurrentSelection =
                        meal['id'] == widget.selectedMeal['id'];
                    if (isCurrentSelection && hasSelection) {
                      return const SizedBox.shrink();
                    }

                    return Padding(
                      padding: EdgeInsets.only(bottom: 2.h),
                      child: Slidable(
                        key: ValueKey(meal['id']),
                        startActionPane: ActionPane(
                          motion: const ScrollMotion(),
                          children: [
                            SlidableAction(
                              onPressed: (_) {
                                widget.onSubstitution(widget.mealType, meal);
                              },
                              backgroundColor: theme.colorScheme.secondary,
                              foregroundColor: Colors.white,
                              icon: Icons.swap_horiz,
                              label: 'Alternative',
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                          ],
                        ),
                        endActionPane: ActionPane(
                          motion: const ScrollMotion(),
                          children: [
                            SlidableAction(
                              onPressed: (_) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'We\'ll show different options next time',
                                    ),
                                    backgroundColor:
                                        theme.colorScheme.secondary,
                                  ),
                                );
                              },
                              backgroundColor: const Color(0xFFFB8C00),
                              foregroundColor: Colors.white,
                              icon: Icons.not_interested,
                              label: 'Skip',
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                          ],
                        ),
                        child: MealCardWidget(
                          meal: meal,
                          isSelected: false,
                          onTap: () =>
                              widget.onMealSelected(widget.mealType, meal),
                          onDetails: () => widget.onMealDetails(meal),
                          onSubstitution: () =>
                              widget.onSubstitution(widget.mealType, meal),
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Color _getMealTypeColor(String mealType, ThemeData theme) {
    switch (mealType.toLowerCase()) {
      case 'breakfast':
        return const Color(0xFFFFB74D);
      case 'lunch':
        return const Color(0xFF4A90A4);
      case 'dinner':
        return const Color(0xFF7CB342);
      case 'snacks':
        return const Color(0xFFAB47BC);
      default:
        return theme.colorScheme.primary;
    }
  }
}

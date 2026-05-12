import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

/// Widget displaying the meal's hero image with back button and favorite action
class MealHeaderWidget extends StatelessWidget {
  final Map<String, dynamic> mealData;
  final VoidCallback onBack;
  final VoidCallback onFavoriteToggle;
  final bool isFavorite;
  final VoidCallback? onTapToRead;

  const MealHeaderWidget({
    Key? key,
    required this.mealData,
    required this.onBack,
    required this.onFavoriteToggle,
    required this.isFavorite,
    this.onTapToRead,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Stack(
      children: [
        // Hero image
        CustomImageWidget(
          imageUrl: mealData['image'] as String? ?? '',
          width: double.infinity,
          height: 35.h,
          fit: BoxFit.cover,
          semanticLabel:
              mealData['imageSemanticLabel'] as String? ?? 'Meal image',
        ),

        // Gradient overlay for better text visibility
        Container(
          width: double.infinity,
          height: 35.h,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withValues(alpha: 0.3),
                Colors.transparent,
                Colors.black.withValues(alpha: 0.5),
              ],
            ),
          ),
        ),

        // Safe area controls
        SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Back button
                Material(
                  color: theme.colorScheme.surface.withValues(alpha: 0.9),
                  borderRadius: BorderRadius.circular(12),
                  child: InkWell(
                    onTap: onBack,
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      width: 12.w,
                      height: 6.h,
                      alignment: Alignment.center,
                      child: CustomIconWidget(
                        iconName: 'arrow_back',
                        color: theme.colorScheme.onSurface,
                        size: 24,
                      ),
                    ),
                  ),
                ),

                // Favorite button
                Material(
                  color: theme.colorScheme.surface.withValues(alpha: 0.9),
                  borderRadius: BorderRadius.circular(12),
                  child: InkWell(
                    onTap: onFavoriteToggle,
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      width: 12.w,
                      height: 6.h,
                      alignment: Alignment.center,
                      child: CustomIconWidget(
                        iconName: isFavorite ? 'favorite' : 'favorite_border',
                        color: isFavorite
                            ? Colors.red
                            : theme.colorScheme.onSurface,
                        size: 24,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        // Meal name at bottom
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: GestureDetector(
            onTap: onTapToRead,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
              child: Text(
                mealData['name'] as String? ?? 'Meal Name',
                style: theme.textTheme.headlineMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      color: Colors.black.withValues(alpha: 0.5),
                      offset: const Offset(0, 2),
                      blurRadius: 4,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

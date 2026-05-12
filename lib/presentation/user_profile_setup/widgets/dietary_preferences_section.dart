import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/app_export.dart';
import '../../../widgets/custom_icon_widget.dart';
import '../../../l10n/app_localizations.dart';

class DietaryPreferencesSection extends StatefulWidget {
  final Set<String> selectedPreferences;
  final Function(Set<String>) onUpdate;

  const DietaryPreferencesSection({
    Key? key,
    required this.selectedPreferences,
    required this.onUpdate,
  }) : super(key: key);

  @override
  State<DietaryPreferencesSection> createState() =>
      _DietaryPreferencesSectionState();
}

class _DietaryPreferencesSectionState extends State<DietaryPreferencesSection> {
  final Set<String> _selectedPreferences = {};
  bool _showWhySection = false;

  @override
  void initState() {
    super.initState();
    _selectedPreferences.addAll(widget.selectedPreferences);
  }

  void _togglePreference(String preference) {
    setState(() {
      // Handle mutually exclusive preferences
      if (preference == 'Vegan' && _selectedPreferences.contains(preference)) {
        _selectedPreferences.remove(preference);
      } else if (preference == 'Vegan') {
        _selectedPreferences.clear();
        _selectedPreferences.add(preference);
      } else if (preference == 'Non-Vegetarian') {
        _selectedPreferences.clear();
        _selectedPreferences.add(preference);
      } else if (preference == 'Jain') {
        _selectedPreferences.removeWhere(
          (p) =>
              p == 'Non-Vegetarian' || p == 'Pescatarian' || p == 'Eggetarian',
        );
        _selectedPreferences.add(preference);
      } else {
        _selectedPreferences.remove('Vegan');
        _selectedPreferences.remove('Non-Vegetarian');

        if (_selectedPreferences.contains(preference)) {
          _selectedPreferences.remove(preference);
        } else {
          _selectedPreferences.add(preference);
        }
      }
    });

    widget.onUpdate(_selectedPreferences);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    final List<Map<String, dynamic>> localizedPreferences = [
      {
        'id': 'Vegetarian',
        'name': l10n.profileDietVeg,
        'icon': 'eco',
        'description': l10n.profileDietVegDesc,
      },
      {
        'id': 'Vegan',
        'name': l10n.profileDietVegan,
        'icon': 'spa',
        'description': l10n.profileDietVeganDesc,
      },
      {
        'id': 'Jain',
        'name': l10n.profileDietJain,
        'icon': 'self_improvement',
        'description': l10n.profileDietJainDesc,
      },
      {
        'id': 'Eggetarian',
        'name': l10n.profileDietEgg,
        'icon': 'egg',
        'description': l10n.profileDietEggDesc,
      },
      {
        'id': 'Non-Vegetarian',
        'name': l10n.profileDietNonVeg,
        'icon': 'restaurant',
        'description': l10n.profileDietNonVegDesc,
      },
      {
        'id': 'Pescatarian',
        'name': l10n.profileDietPescatarian,
        'icon': 'set_meal',
        'description': l10n.profileDietPescatarianDesc,
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.profileDietaryPreferences,
          style: theme.textTheme.headlineSmall?.copyWith(
            color: theme.colorScheme.onSurface,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 1.h),
        Text(
          l10n.profileDietSubtitle,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        SizedBox(height: 3.h),

        // Dietary Preferences Grid
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 3.w,
            mainAxisSpacing: 2.h,
            childAspectRatio: 1.5,
          ),
          itemCount: localizedPreferences.length,
          itemBuilder: (context, index) {
            final preference = localizedPreferences[index];
            final isSelected = _selectedPreferences.contains(
              preference['id'],
            );

            return InkWell(
              onTap: () => _togglePreference(preference['id'] as String),
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: EdgeInsets.all(3.w),
                decoration: BoxDecoration(
                  color: isSelected
                      ? theme.colorScheme.secondary.withValues(alpha: 0.1)
                      : theme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isSelected
                        ? theme.colorScheme.secondary
                        : theme.colorScheme.outline.withValues(alpha: 0.3),
                    width: isSelected ? 2 : 1,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomIconWidget(
                      iconName: preference['icon'] as String,
                      color: isSelected
                          ? theme.colorScheme.secondary
                          : theme.colorScheme.onSurfaceVariant,
                      size: 28,
                    ),
                    SizedBox(height: 1.h),
                    Text(
                      preference['name'] as String,
                      style: theme.textTheme.titleSmall?.copyWith(
                        color: isSelected
                            ? theme.colorScheme.secondary
                            : theme.colorScheme.onSurface,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 0.5.h),
                    Text(
                      preference['description'] as String,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                        fontSize: 9.sp,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            );
          },
        ),

        SizedBox(height: 3.h),

        // Info Card
        Container(
          padding: EdgeInsets.all(3.w),
          decoration: BoxDecoration(
            color: theme.colorScheme.tertiary.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: theme.colorScheme.tertiary.withValues(alpha: 0.2),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomIconWidget(
                iconName: 'lightbulb',
                color: theme.colorScheme.tertiary,
                size: 20,
              ),
              SizedBox(width: 2.w),
              Expanded(
                child: Text(
                  l10n.profileDietMultipleInfo,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: 3.h),

        // Why do we need this section
        InkWell(
          onTap: () {
            setState(() {
              _showWhySection = !_showWhySection;
            });
          },
          child: Container(
            padding: EdgeInsets.all(3.w),
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: theme.colorScheme.primary.withValues(alpha: 0.2),
              ),
            ),
            child: Row(
              children: [
                CustomIconWidget(
                  iconName: _showWhySection ? 'expand_less' : 'expand_more',
                  color: theme.colorScheme.primary,
                  size: 24,
                ),
                SizedBox(width: 2.w),
                Expanded(
                  child: Text(
                    l10n.profileWhyNeedInfo,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        _showWhySection
            ? Column(
                children: [
                  SizedBox(height: 2.h),
                  Container(
                    padding: EdgeInsets.all(3.w),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surface,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: theme.colorScheme.outline.withValues(alpha: 0.2),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CustomIconWidget(
                              iconName: 'restaurant_menu',
                              color: theme.colorScheme.primary,
                              size: 20,
                            ),
                            SizedBox(width: 2.w),
                            Text(
                              l10n.profileDietImportanceTitle,
                              style: theme.textTheme.titleSmall?.copyWith(
                                color: theme.colorScheme.onSurface,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 1.h),
                        Text(
                          '• ${l10n.profileDietImportanceRespect}\n\n'
                          '• ${l10n.profileDietImportanceFilter}\n\n'
                          '• ${l10n.profileDietImportanceCultural}\n\n'
                          '• ${l10n.profileDietImportanceBalance}\n\n'
                          '• ${l10n.profileDietImportanceReligious}',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            : const SizedBox.shrink(),
      ],
    );
  }
}

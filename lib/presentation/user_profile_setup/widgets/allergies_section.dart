import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/app_export.dart';
import '../../../l10n/app_localizations.dart';

class AllergiesSection extends StatefulWidget {
  final Set<String> selectedAllergies;
  final Function(Set<String>) onUpdate;

  const AllergiesSection({
    Key? key,
    required this.selectedAllergies,
    required this.onUpdate,
  }) : super(key: key);

  @override
  State<AllergiesSection> createState() => _AllergiesSectionState();
}

class _AllergiesSectionState extends State<AllergiesSection> {
  final Set<String> _selectedAllergies = {};
  final TextEditingController _searchController = TextEditingController();
  bool _showWhySection = false;
  List<String> _filteredAllergies = [];

  final List<String> _commonAllergies = [];

  @override
  void initState() {
    super.initState();
    _selectedAllergies.addAll(widget.selectedAllergies);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _initializeAllergies();
  }

  void _initializeAllergies() {
    final l10n = AppLocalizations.of(context)!;
    final localizedCommonAllergies = [
      l10n.allergyPeanuts,
      l10n.allergyTreeNuts,
      l10n.allergyMilk,
      l10n.allergyEggs,
      l10n.allergyWheat,
      l10n.allergySoy,
      l10n.allergyFish,
      l10n.allergyShellfish,
      l10n.allergySesame,
      l10n.allergyMustard,
      l10n.allergyGluten,
      l10n.allergyLactose,
      l10n.allergyCorn,
      l10n.allergyGarlic,
      l10n.allergyOnion,
      l10n.allergyTomato,
      l10n.allergyCitrus,
      l10n.allergyStrawberries,
      l10n.allergyChocolate,
      l10n.allergyCaffeine,
    ];

    if (_commonAllergies.isEmpty) {
      _commonAllergies.addAll(localizedCommonAllergies);
      _filteredAllergies = List.from(_commonAllergies);
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterAllergies(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredAllergies = List.from(_commonAllergies);
      } else {
        _filteredAllergies = _commonAllergies
            .where(
              (allergy) => allergy.toLowerCase().contains(query.toLowerCase()),
            )
            .toList();
      }
    });
  }

  void _toggleAllergy(String allergy) {
    setState(() {
      if (_selectedAllergies.contains(allergy)) {
        _selectedAllergies.remove(allergy);
      } else {
        _selectedAllergies.add(allergy);
      }
    });
    widget.onUpdate(_selectedAllergies);
  }

  void _addCustomAllergy() {
    final customAllergy = _searchController.text.trim();
    if (customAllergy.isNotEmpty &&
        !_selectedAllergies.contains(customAllergy)) {
      setState(() {
        _selectedAllergies.add(customAllergy);
        _searchController.clear();
        _filteredAllergies = List.from(_commonAllergies);
      });
      widget.onUpdate(_selectedAllergies);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.profileAllergyTitle,
          style: theme.textTheme.headlineSmall?.copyWith(
            color: theme.colorScheme.onSurface,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 1.h),
        Text(
          l10n.profileAllergySubtitle,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        SizedBox(height: 3.h),

        // Search Bar
        TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: l10n.profileAllergySearchHint,
            prefixIcon: Padding(
              padding: EdgeInsets.all(3.w),
              child: CustomIconWidget(
                iconName: 'search',
                color: theme.colorScheme.onSurfaceVariant,
                size: 20,
              ),
            ),
            suffixIcon: _searchController.text.isNotEmpty
                ? IconButton(
                    icon: CustomIconWidget(
                      iconName: 'add_circle',
                      color: theme.colorScheme.primary,
                      size: 24,
                    ),
                    onPressed: _addCustomAllergy,
                  )
                : null,
          ),
          onChanged: _filterAllergies,
        ),
        SizedBox(height: 2.h),

        // Selected Allergies Chips
        _selectedAllergies.isNotEmpty
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.profileAllergySelected,
                    style: theme.textTheme.titleSmall?.copyWith(
                      color: theme.colorScheme.onSurface,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 1.h),
                  Wrap(
                    spacing: 2.w,
                    runSpacing: 1.h,
                    children: _selectedAllergies.map((allergy) {
                      return Chip(
                        label: Text(allergy),
                        deleteIcon: CustomIconWidget(
                          iconName: 'close',
                          color: theme.colorScheme.onSecondaryContainer,
                          size: 18,
                        ),
                        onDeleted: () => _toggleAllergy(allergy),
                        backgroundColor: theme.colorScheme.secondaryContainer,
                        labelStyle: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSecondaryContainer,
                          fontWeight: FontWeight.w500,
                        ),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 2.h),
                ],
              )
            : const SizedBox.shrink(),

        // Common Allergies List
        Text(
          l10n.profileAllergyCommon,
          style: theme.textTheme.titleSmall?.copyWith(
            color: theme.colorScheme.onSurface,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 1.h),

        Container(
          constraints: BoxConstraints(maxHeight: 30.h),
          child: ListView.separated(
            shrinkWrap: true,
            itemCount: _filteredAllergies.length,
            separatorBuilder: (context, index) => Divider(
              height: 1,
              color: theme.colorScheme.outline.withValues(alpha: 0.2),
            ),
            itemBuilder: (context, index) {
              final allergy = _filteredAllergies[index];
              final isSelected = _selectedAllergies.contains(allergy);

              return CheckboxListTile(
                title: Text(allergy, style: theme.textTheme.bodyMedium),
                value: isSelected,
                onChanged: (value) => _toggleAllergy(allergy),
                activeColor: theme.colorScheme.primary,
                controlAffinity: ListTileControlAffinity.leading,
              );
            },
          ),
        ),

        SizedBox(height: 3.h),

        // Info Card
        Container(
          padding: EdgeInsets.all(3.w),
          decoration: BoxDecoration(
            color: AppTheme.warningLight.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: AppTheme.warningLight.withValues(alpha: 0.2),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomIconWidget(
                iconName: 'warning',
                color: AppTheme.warningLight,
                size: 20,
              ),
              SizedBox(width: 2.w),
              Expanded(
                child: Text(
                  l10n.profileAllergyWarning,
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
                              iconName: 'shield',
                              color: theme.colorScheme.primary,
                              size: 20,
                            ),
                            SizedBox(width: 2.w),
                            Text(
                              l10n.profileAllergySafetyTitle,
                              style: theme.textTheme.titleSmall?.copyWith(
                                color: theme.colorScheme.onSurface,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 1.h),
                        Text(
                          '• ${l10n.profileAllergySafetyPrevents}\n\n'
                          '• ${l10n.profileAllergySafetyFilters}\n\n'
                          '• ${l10n.profileAllergySafetySubstitutions}\n\n'
                          '• ${l10n.profileAllergySafetyExclude}\n\n'
                          '• ${l10n.profileAllergySafetyCritical}',
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

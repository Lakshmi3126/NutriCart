import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/app_export.dart';
import '../../../widgets/custom_icon_widget.dart';
import '../../../l10n/app_localizations.dart';

class PersonalDetailsSection extends StatefulWidget {
  final int? age;
  final String? gender;
  final double? weight;
  final Function({int? age, String? gender, double? weight}) onUpdate;

  const PersonalDetailsSection({
    Key? key,
    this.age,
    this.gender,
    this.weight,
    required this.onUpdate,
  }) : super(key: key);

  @override
  State<PersonalDetailsSection> createState() => _PersonalDetailsSectionState();
}

class _PersonalDetailsSectionState extends State<PersonalDetailsSection> {
  final _ageController = TextEditingController();
  final _weightController = TextEditingController();
  String? _selectedGender;
  bool _showWhySection = false;

  @override
  void initState() {
    super.initState();
    if (widget.age != null) _ageController.text = widget.age.toString();
    if (widget.weight != null)
      _weightController.text = widget.weight.toString();
    _selectedGender = widget.gender;
  }

  @override
  void dispose() {
    _ageController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  void _updateAge(String value) {
    final age = int.tryParse(value);
    widget.onUpdate(age: age);
  }

  void _updateGender(String? value) {
    setState(() {
      _selectedGender = value;
    });
    widget.onUpdate(gender: value);
  }

  void _updateWeight(String value) {
    final weight = double.tryParse(value);
    widget.onUpdate(weight: weight);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.profilePersonalDetails,
          style: theme.textTheme.headlineSmall?.copyWith(
            color: theme.colorScheme.onSurface,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 1.h),
        Text(
          l10n.profilePersonalSubtitle,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        SizedBox(height: 3.h),

        // Age Input
        Text(
          l10n.profileAgeLabel,
          style: theme.textTheme.titleMedium?.copyWith(
            color: theme.colorScheme.onSurface,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 1.h),
        TextFormField(
          controller: _ageController,
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(3),
          ],
          decoration: InputDecoration(
            hintText: l10n.profileAgeHint,
            suffixIcon: Padding(
              padding: EdgeInsets.all(3.w),
              child: CustomIconWidget(
                iconName: 'calendar_today',
                color: theme.colorScheme.onSurfaceVariant,
                size: 20,
              ),
            ),
          ),
          onChanged: _updateAge,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return l10n.profileAgeRequired;
            }
            final age = int.tryParse(value);
            if (age == null || age < 18 || age > 100) {
              return l10n.profileAgeInvalid;
            }
            return null;
          },
        ),
        SizedBox(height: 3.h),

        // Gender Selection
        Text(
          l10n.profileGenderLabel,
          style: theme.textTheme.titleMedium?.copyWith(
            color: theme.colorScheme.onSurface,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 1.h),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: theme.colorScheme.outline),
            borderRadius: BorderRadius.circular(8),
          ),
          child: RadioGroup<String>(
            groupValue: _selectedGender,
            onChanged: _updateGender,
            child: Column(
              children: [
                RadioListTile<String>(
                  title: Text(
                    l10n.profileGenderMale,
                    style: theme.textTheme.bodyLarge,
                  ),
                  value: 'Male',
                  activeColor: theme.colorScheme.primary,
                ),
                Divider(height: 1, color: theme.colorScheme.outline),
                RadioListTile<String>(
                  title: Text(
                    l10n.profileGenderFemale,
                    style: theme.textTheme.bodyLarge,
                  ),
                  value: 'Female',
                  activeColor: theme.colorScheme.primary,
                ),
                Divider(height: 1, color: theme.colorScheme.outline),
                RadioListTile<String>(
                  title: Text(
                    l10n.profileGenderOther,
                    style: theme.textTheme.bodyLarge,
                  ),
                  value: 'Other',
                  activeColor: theme.colorScheme.primary,
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 3.h),

        // Weight Input
        Text(
          l10n.profileWeightLabel,
          style: theme.textTheme.titleMedium?.copyWith(
            color: theme.colorScheme.onSurface,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 1.h),
        TextFormField(
          controller: _weightController,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
          ],
          decoration: InputDecoration(
            hintText: l10n.profileWeightHint,
            suffixIcon: Padding(
              padding: EdgeInsets.all(3.w),
              child: CustomIconWidget(
                iconName: 'monitor_weight',
                color: theme.colorScheme.onSurfaceVariant,
                size: 20,
              ),
            ),
          ),
          onChanged: _updateWeight,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return l10n.profileWeightRequired;
            }
            final weight = double.tryParse(value);
            if (weight == null || weight < 30 || weight > 200) {
              return l10n.profileWeightInvalid;
            }
            return null;
          },
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
                              iconName: 'info_outline',
                              color: theme.colorScheme.primary,
                              size: 20,
                            ),
                            SizedBox(width: 2.w),
                            Text(
                              l10n.profileUsageTitle,
                              style: theme.textTheme.titleSmall?.copyWith(
                                color: theme.colorScheme.onSurface,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 1.h),
                        Text(
                          '• ${l10n.profileUsageAge}\n\n'
                          '• ${l10n.profileUsageGender}\n\n'
                          '• ${l10n.profileUsageWeight}\n\n'
                          '• ${l10n.profileUsageSecurity}',
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

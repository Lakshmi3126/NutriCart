import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/app_export.dart';
import '../../../widgets/custom_icon_widget.dart';
import '../../../l10n/app_localizations.dart';

class HealthConditionsSection extends StatefulWidget {
  final Set<String> selectedConditions;
  final double? hba1c;
  final Function(Set<String>, {double? hba1c}) onUpdate;

  const HealthConditionsSection({
    Key? key,
    required this.selectedConditions,
    this.hba1c,
    required this.onUpdate,
  }) : super(key: key);

  @override
  State<HealthConditionsSection> createState() =>
      _HealthConditionsSectionState();
}

class _HealthConditionsSectionState extends State<HealthConditionsSection> {
  final Set<String> _selectedConditions = {};
  final _hba1cController = TextEditingController();
  bool _showWhySection = false;

  @override
  void initState() {
    super.initState();
    _selectedConditions.addAll(widget.selectedConditions);
    if (widget.hba1c != null) {
      _hba1cController.text = widget.hba1c.toString();
    }
  }

  @override
  void dispose() {
    _hba1cController.dispose();
    super.dispose();
  }

  void _toggleCondition(String condition) {
    setState(() {
      if (_selectedConditions.contains(condition)) {
        _selectedConditions.remove(condition);
        if (condition == 'Diabetes') {
          _hba1cController.clear();
        }
      } else {
        _selectedConditions.add(condition);
      }
    });

    final hba1c = _hba1cController.text.isNotEmpty
        ? double.tryParse(_hba1cController.text)
        : null;
    widget.onUpdate(_selectedConditions, hba1c: hba1c);
  }

  void _updateHba1c(String value) {
    final hba1c = double.tryParse(value);
    widget.onUpdate(_selectedConditions, hba1c: hba1c);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    
    final List<Map<String, dynamic>> localizedHealthConditions = [
      {
        'id': 'Diabetes',
        'name': l10n.profileHealthDiabetes,
        'icon': 'bloodtype',
        'description': l10n.profileHealthDiabetesDesc,
      },
      {
        'id': 'PCOS',
        'name': l10n.profileHealthPCOS,
        'icon': 'favorite',
        'description': l10n.profileHealthPCOSDesc,
      },
      {
        'id': 'Hypertension',
        'name': l10n.profileHealthHypertension,
        'icon': 'monitor_heart',
        'description': l10n.profileHealthHypertensionDesc,
      },
      {
        'id': 'Anemia',
        'name': l10n.profileHealthAnemia,
        'icon': 'water_drop',
        'description': l10n.profileHealthAnemiaDesc,
      },
      {
        'id': 'Thyroid',
        'name': l10n.profileHealthThyroid,
        'icon': 'medical_services',
        'description': l10n.profileHealthThyroidDesc,
      },
      {
        'id': 'Heart Disease',
        'name': l10n.profileHealthHeart,
        'icon': 'favorite_border',
        'description': l10n.profileHealthHeartDesc,
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.profileHealthConditions,
          style: theme.textTheme.headlineSmall?.copyWith(
            color: theme.colorScheme.onSurface,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 1.h),
        Text(
          l10n.profileHealthSubtitle,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        SizedBox(height: 3.h),

        // Health Conditions Grid
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 3.w,
            mainAxisSpacing: 2.h,
            childAspectRatio: 1.5,
          ),
          itemCount: localizedHealthConditions.length,
          itemBuilder: (context, index) {
            final condition = localizedHealthConditions[index];
            final isSelected = _selectedConditions.contains(condition['id']);

            return InkWell(
              onTap: () => _toggleCondition(condition['id'] as String),
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: EdgeInsets.all(3.w),
                decoration: BoxDecoration(
                  color: isSelected
                      ? theme.colorScheme.primary.withValues(alpha: 0.1)
                      : theme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isSelected
                        ? theme.colorScheme.primary
                        : theme.colorScheme.outline.withValues(alpha: 0.3),
                    width: isSelected ? 2 : 1,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomIconWidget(
                      iconName: condition['icon'] as String,
                      color: isSelected
                          ? theme.colorScheme.primary
                          : theme.colorScheme.onSurfaceVariant,
                      size: 28,
                    ),
                    SizedBox(height: 1.h),
                    Text(
                      condition['name'] as String,
                      style: theme.textTheme.titleSmall?.copyWith(
                        color: isSelected
                            ? theme.colorScheme.primary
                            : theme.colorScheme.onSurface,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 0.5.h),
                    Text(
                      condition['description'] as String,
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

        // HbA1c Input (shown only if Diabetes is selected)
        _selectedConditions.contains('Diabetes')
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 3.h),
                  Container(
                    padding: EdgeInsets.all(3.w),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.secondary.withValues(
                        alpha: 0.05,
                      ),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: theme.colorScheme.secondary.withValues(
                          alpha: 0.2,
                        ),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CustomIconWidget(
                              iconName: 'science',
                              color: theme.colorScheme.secondary,
                              size: 20,
                            ),
                            SizedBox(width: 2.w),
                            Text(
                              l10n.profileHbA1cLabel,
                              style: theme.textTheme.titleMedium?.copyWith(
                                color: theme.colorScheme.onSurface,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 1.h),
                        TextFormField(
                          controller: _hba1cController,
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                              RegExp(r'^\d+\.?\d{0,1}'),
                            ),
                          ],
                          decoration: InputDecoration(
                            hintText: l10n.profileHbA1cHint,
                            suffixText: '%',
                            filled: true,
                            fillColor: theme.colorScheme.surface,
                          ),
                          onChanged: _updateHba1c,
                        ),
                        SizedBox(height: 1.h),
                        Text(
                          l10n.profileHbA1cInfo,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            : const SizedBox.shrink(),

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
                              iconName: 'health_and_safety',
                              color: theme.colorScheme.primary,
                              size: 20,
                            ),
                            SizedBox(width: 2.w),
                            Text(
                              l10n.profileSafetyTitle,
                              style: theme.textTheme.titleSmall?.copyWith(
                                color: theme.colorScheme.onSurface,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 1.h),
                        Text(
                          '• ${l10n.profileSafetyCondition}\n\n'
                          '• ${l10n.profileSafetyCompliance}\n\n'
                          '• ${l10n.profileSafetyPrevention}\n\n'
                          '• ${l10n.profileSafetyBalance}\n\n'
                          '• ${l10n.profileSafetyGuidelines}',
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

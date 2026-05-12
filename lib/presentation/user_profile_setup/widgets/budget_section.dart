import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/app_export.dart';
import '../../../l10n/app_localizations.dart';

class BudgetSection extends StatefulWidget {
  final double? budget;
  final Function(double?) onUpdate;

  const BudgetSection({Key? key, this.budget, required this.onUpdate})
    : super(key: key);

  @override
  State<BudgetSection> createState() => _BudgetSectionState();
}

class _BudgetSectionState extends State<BudgetSection> {
  final _budgetController = TextEditingController();
  bool _showWhySection = false;
  double? _selectedBudget;

  final List<Map<String, dynamic>> _budgetPresets = [
    {'label': '₹5,000', 'value': 5000.0},
    {'label': '₹10,000', 'value': 10000.0},
    {'label': '₹15,000', 'value': 15000.0},
    {'label': '₹20,000', 'value': 20000.0},
  ];

  @override
  void initState() {
    super.initState();
    if (widget.budget != null) {
      _selectedBudget = widget.budget;
      _budgetController.text = widget.budget!.toStringAsFixed(0);
    }
  }

  @override
  void dispose() {
    _budgetController.dispose();
    super.dispose();
  }

  void _updateBudget(String value) {
    final budget = double.tryParse(value);
    setState(() {
      _selectedBudget = budget;
    });
    widget.onUpdate(budget);
  }

  void _selectPresetBudget(double budget) {
    setState(() {
      _selectedBudget = budget;
      _budgetController.text = budget.toStringAsFixed(0);
    });
    widget.onUpdate(budget);
  }

  String _formatIndianNumber(double number) {
    final parts = number.toStringAsFixed(0).split('.');
    final intPart = parts[0];
    final lastThree = intPart.substring(
      intPart.length > 3 ? intPart.length - 3 : 0,
    );
    final otherNumbers = intPart.substring(
      0,
      intPart.length > 3 ? intPart.length - 3 : 0,
    );

    if (otherNumbers.isNotEmpty) {
      final formatted = otherNumbers.replaceAllMapped(
        RegExp(r'(\d{1,2})(?=(\d{2})+(?!\d))'),
        (Match m) => '${m[1]},',
      );
      return '$formatted,$lastThree';
    }
    return lastThree;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.profileBudgetTitle,
          style: theme.textTheme.headlineSmall?.copyWith(
            color: theme.colorScheme.onSurface,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 1.h),
        Text(
          l10n.profileBudgetSubtitle,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        SizedBox(height: 3.h),

        // Budget Input
        Text(
          l10n.profileBudgetAmountLabel,
          style: theme.textTheme.titleMedium?.copyWith(
            color: theme.colorScheme.onSurface,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 1.h),
        TextFormField(
          controller: _budgetController,
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(6),
          ],
          decoration: InputDecoration(
            hintText: l10n.profileBudgetAmountHint,
            prefixIcon: Padding(
              padding: EdgeInsets.all(3.w),
              child: Text(
                '₹',
                style: theme.textTheme.titleMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            suffixIcon: _selectedBudget != null
                ? Padding(
                    padding: EdgeInsets.all(3.w),
                    child: CustomIconWidget(
                      iconName: 'check_circle',
                      color: AppTheme.successLight,
                      size: 20,
                    ),
                  )
                : null,
          ),
          onChanged: _updateBudget,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return l10n.profileBudgetAmountRequired;
            }
            final budget = double.tryParse(value);
            if (budget == null || budget < 1000) {
              return l10n.profileBudgetAmountMin;
            }
            if (budget > 100000) {
              return l10n.profileBudgetAmountMax;
            }
            return null;
          },
        ),
        SizedBox(height: 3.h),

        // Budget Presets
        Text(
          l10n.profileBudgetQuickSelect,
          style: theme.textTheme.titleMedium?.copyWith(
            color: theme.colorScheme.onSurface,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 1.h),
        Wrap(
          spacing: 2.w,
          runSpacing: 1.h,
          children: _budgetPresets.map((preset) {
            final isSelected = _selectedBudget == preset['value'];
            return InkWell(
              onTap: () => _selectPresetBudget(preset['value'] as double),
              borderRadius: BorderRadius.circular(8),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.5.h),
                decoration: BoxDecoration(
                  color: isSelected
                      ? theme.colorScheme.primary.withValues(alpha: 0.1)
                      : theme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: isSelected
                        ? theme.colorScheme.primary
                        : theme.colorScheme.outline.withValues(alpha: 0.3),
                    width: isSelected ? 2 : 1,
                  ),
                ),
                child: Text(
                  preset['label'] as String,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: isSelected
                        ? theme.colorScheme.primary
                        : theme.colorScheme.onSurface,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  ),
                ),
              ),
            );
          }).toList(),
        ),

        SizedBox(height: 3.h),

        // Budget Breakdown Info
        _selectedBudget != null
            ? Container(
                padding: EdgeInsets.all(3.w),
                decoration: BoxDecoration(
                  color: theme.colorScheme.tertiary.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: theme.colorScheme.tertiary.withValues(alpha: 0.2),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CustomIconWidget(
                          iconName: 'calculate',
                          color: theme.colorScheme.tertiary,
                          size: 20,
                        ),
                        SizedBox(width: 2.w),
                        Text(
                          l10n.profileBudgetBreakdownTitle,
                          style: theme.textTheme.titleSmall?.copyWith(
                            color: theme.colorScheme.onSurface,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 1.h),
                    Divider(
                      color: theme.colorScheme.outline.withValues(alpha: 0.2),
                    ),
                    SizedBox(height: 1.h),
                    _buildBudgetRow(
                      theme,
                      l10n.profileBudgetDaily,
                      '₹${_formatIndianNumber(_selectedBudget! / 30)}',
                    ),
                    SizedBox(height: 0.5.h),
                    _buildBudgetRow(
                      theme,
                      l10n.profileBudgetWeekly,
                      '₹${_formatIndianNumber(_selectedBudget! / 4)}',
                    ),
                    SizedBox(height: 0.5.h),
                    _buildBudgetRow(
                      theme,
                      l10n.profileBudgetPerMeal,
                      '₹${_formatIndianNumber(_selectedBudget! / 90)}',
                    ),
                  ],
                ),
              )
            : const SizedBox.shrink(),

        SizedBox(height: 3.h),

        // Info Card
        Container(
          padding: EdgeInsets.all(3.w),
          decoration: BoxDecoration(
            color: theme.colorScheme.secondary.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: theme.colorScheme.secondary.withValues(alpha: 0.2),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomIconWidget(
                iconName: 'savings',
                color: theme.colorScheme.secondary,
                size: 20,
              ),
              SizedBox(width: 2.w),
              Expanded(
                child: Text(
                  l10n.profileBudgetSavingsInfo,
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
                              iconName: 'account_balance_wallet',
                              color: theme.colorScheme.primary,
                              size: 20,
                            ),
                            SizedBox(width: 2.w),
                            Text(
                              l10n.profileBudgetAwareTitle,
                              style: theme.textTheme.titleSmall?.copyWith(
                                color: theme.colorScheme.onSurface,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 1.h),
                        Text(
                          '• ${l10n.profileBudgetAwareSuggest}\n\n'
                          '• ${l10n.profileBudgetAwareCost}\n\n'
                          '• ${l10n.profileBudgetAwareTrack}\n\n'
                          '• ${l10n.profileBudgetAwareOptimize}\n\n'
                          '• ${l10n.profileBudgetAwarePrevent}',
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

  Widget _buildBudgetRow(ThemeData theme, String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        Text(
          value,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurface,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

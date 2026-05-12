import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../widgets/custom_icon_widget.dart';
import './widgets/budget_section.dart';
import './widgets/dietary_preferences_section.dart';
import './widgets/health_conditions_section.dart';
import './widgets/personal_details_section.dart';
import './widgets/language_selector.dart';
import '../../l10n/app_localizations.dart';

class UserProfileSetup extends StatefulWidget {
  const UserProfileSetup({Key? key}) : super(key: key);

  @override
  State<UserProfileSetup> createState() => _UserProfileSetupState();
}

class _UserProfileSetupState extends State<UserProfileSetup> {
  final _formKey = GlobalKey<FormState>();
  final _scrollController = ScrollController();

  // Form data
  int _currentStep = 0;
  final int _totalSteps = 4;

  // Personal Details
  
  int? _age;
  String? _gender;
  double? _weight;

  // Health Conditions
  final Set<String> _healthConditions = {};
  double? _hba1c;

  // Dietary Preferences
  final Set<String> _dietaryPreferences = {};

  // Budget
  double? _monthlyBudget;

  // Validation flags
  bool _isPersonalDetailsValid = false;
  bool _isHealthConditionsValid = true; // Optional section
  bool _isDietaryPreferencesValid = false;
  bool _isBudgetValid = false;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  bool get _canProceed {
    switch (_currentStep) {
      case 0:
        return _isPersonalDetailsValid;
      case 1:
        return _isHealthConditionsValid;
      case 2:
        return _isDietaryPreferencesValid;
      case 3:
        return _isBudgetValid;
      default:
        return false;
    }
  }

  void _updatePersonalDetails({int? age, String? gender, double? weight}) {
    setState(() {
      if (age != null) _age = age;
      if (gender != null) _gender = gender;
      if (weight != null) _weight = weight;

      _isPersonalDetailsValid =
          _age != null &&
          _age! >= 18 &&
          _age! <= 100 &&
          _gender != null &&
          _weight != null &&
          _weight! >= 30 &&
          _weight! <= 200;
    });
  }

  void _updateHealthConditions(Set<String> conditions, {double? hba1c}) {
    setState(() {
      _healthConditions.clear();
      _healthConditions.addAll(conditions);
      if (hba1c != null) _hba1c = hba1c;
      _isHealthConditionsValid = true;
    });
  }

  void _updateDietaryPreferences(Set<String> preferences) {
    setState(() {
      _dietaryPreferences.clear();
      _dietaryPreferences.addAll(preferences);
      _isDietaryPreferencesValid = preferences.isNotEmpty;
    });
  }

  void _updateBudget(double? budget) {
    setState(() {
      _monthlyBudget = budget;
      _isBudgetValid = budget != null && budget >= 1000 && budget <= 100000;
    });
  }

  void _nextStep() {
    if (_canProceed) {
      if (_currentStep < _totalSteps - 1) {
        setState(() {
          _currentStep++;
        });
        _scrollController.animateTo(
          0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      } else {
        _completeSetup();
      }
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });
      _scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> _completeSetup() async {
    if (_formKey.currentState?.validate() ?? false) {
      // Save data to secure storage (implementation would go here)
      // For now, navigate to dashboard
      if (mounted) {
        Navigator.of(
          context,
          rootNavigator: true,
        ).pushReplacementNamed('/dashboard');
      }
    }
  }

  Widget _buildStepContent() {
    switch (_currentStep) {
      case 0:
        return PersonalDetailsSection(
          age: _age,
          gender: _gender,
          weight: _weight,
          onUpdate: _updatePersonalDetails,
        );
      case 1:
        return HealthConditionsSection(
          selectedConditions: _healthConditions,
          hba1c: _hba1c,
          onUpdate: _updateHealthConditions,
        );
      case 2:
        return DietaryPreferencesSection(
          selectedPreferences: _dietaryPreferences,
          onUpdate: _updateDietaryPreferences,
        );
      case 3:
        return BudgetSection(budget: _monthlyBudget, onUpdate: _updateBudget);
      default:
        return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
        leading: _currentStep > 0
            ? IconButton(
                icon: CustomIconWidget(
                  iconName: 'arrow_back',
                  color: theme.colorScheme.onSurface,
                  size: 24,
                ),
                onPressed: _previousStep,
              )
            : null,
        title: Text(
          l10n.profileSetupTitle,
          style: theme.textTheme.titleLarge?.copyWith(
            color: theme.colorScheme.onSurface,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Progress Indicator
              Container(
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                color: theme.colorScheme.surface,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          l10n.profileStepOfTotal(
                            _currentStep + 1,
                            _totalSteps,
                          ),
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          l10n.profileStepPercent(
                            ((_currentStep + 1) / _totalSteps * 100).toInt(),
                          ),
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 1.h),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: LinearProgressIndicator(
                        value: (_currentStep + 1) / _totalSteps,
                        backgroundColor: theme.colorScheme.primary.withValues(
                          alpha: 0.2,
                        ),
                        valueColor: AlwaysStoppedAnimation<Color>(
                          theme.colorScheme.primary,
                        ),
                        minHeight: 8,
                      ),
                    ),
                  ],
                ),
              ),

              // Step Content
              Expanded(
                child: SingleChildScrollView(
                  controller: _scrollController,
                  padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                  child: Column(
                    children: [
                      const LanguageSelector(),
                      SizedBox(height: 2.h),
                      _buildStepContent(),
                    ],
                  ),
                ),
              ),

              // Bottom Action Button
              Container(
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 8,
                      offset: const Offset(0, -2),
                    ),
                  ],
                ),
                child: SizedBox(
                  width: double.infinity,
                  height: 6.h,
                  child: ElevatedButton(
                    onPressed: _canProceed ? _nextStep : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.colorScheme.primary,
                      foregroundColor: theme.colorScheme.onPrimary,
                      disabledBackgroundColor: theme
                          .colorScheme
                          .onSurfaceVariant
                          .withValues(alpha: 0.12),
                      disabledForegroundColor: theme
                          .colorScheme
                          .onSurfaceVariant
                          .withValues(alpha: 0.38),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      _currentStep < _totalSteps - 1
                          ? l10n.profileContinue
                          : l10n.profileCompleteSetup,
                      style: theme.textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

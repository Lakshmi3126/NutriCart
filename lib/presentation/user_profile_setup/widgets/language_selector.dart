import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/localization/app_locale.dart';
import '../../../l10n/app_localizations.dart';

class LanguageSelector extends StatelessWidget {
  final bool isCompact;
  const LanguageSelector({super.key, this.isCompact = false});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final currentCode = appLocale.value?.languageCode ?? 'en';

    if (isCompact) {
      return SizedBox(
        width: 120, // Providing a fixed width for the header
        child: DropdownButtonHideUnderline(
          child: DropdownButtonFormField<String>(
            initialValue: currentCode,
            isDense: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                  color: theme.colorScheme.primary.withValues(alpha: 0.5),
                ),
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 3.w,
                vertical: 0.8.h,
              ),
            ),
            items: [
              DropdownMenuItem(
                value: 'en',
                child: Text('EN', style: theme.textTheme.labelLarge),
              ),
              DropdownMenuItem(
                value: 'kn',
                child: Text('KN', style: theme.textTheme.labelLarge),
              ),
              DropdownMenuItem(
                value: 'hi',
                child: Text('HI', style: theme.textTheme.labelLarge),
              ),
            ],
            onChanged: (value) {
              if (value != null) {
                updateAppLocale(value);
              }
            },
          ),
        ),
      );
    }

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: theme.colorScheme.outline.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(4.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.languageSelectorTitle,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: theme.colorScheme.onSurface,
              ),
            ),
            SizedBox(height: 0.8.h),
            Text(
              l10n.languageSelectorSubtitle,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            SizedBox(height: 1.5.h),
            DropdownButtonFormField<String>(
              initialValue: currentCode,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 3.w,
                  vertical: 1.2.h,
                ),
              ),
              items: [
                DropdownMenuItem(
                  value: 'en',
                  child: Text(l10n.languageEnglish),
                ),
                DropdownMenuItem(
                  value: 'kn',
                  child: Text(l10n.languageKannada),
                ),
                DropdownMenuItem(
                  value: 'hi',
                  child: Text(l10n.languageHindi),
                ),
              ],
              onChanged: (value) {
                if (value != null) {
                  updateAppLocale(value);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}



import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Global locale controller for the whole app.
///
/// This keeps the implementation minimal and avoids touching existing
/// navigation/state logic. The [ValueNotifier] is listened to in `MyApp`
/// and updates the `MaterialApp.locale` when it changes.
final ValueNotifier<Locale?> appLocale = ValueNotifier<Locale?>(null);

const _kLocaleStorageKey = 'app_locale_code';

Future<void> loadSavedLocale() async {
  final prefs = await SharedPreferences.getInstance();
  final code = prefs.getString(_kLocaleStorageKey);
  if (code != null && code.isNotEmpty) {
    appLocale.value = Locale(code);
  }
}

Future<void> updateAppLocale(String languageCode) async {
  final prefs = await SharedPreferences.getInstance();
  appLocale.value = Locale(languageCode);
  await prefs.setString(_kLocaleStorageKey, languageCode);
}



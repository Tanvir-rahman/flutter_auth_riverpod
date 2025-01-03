import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:resto_lite/core/localization/generated/strings.dart';

class L10n {
  const L10n();

  static const L10n instance = L10n();

  List<Locale> get supportedLocales => const [
        Locale('en'),
        Locale('bn'),
      ];

  List<LocalizationsDelegate<dynamic>> get delegates => const [
        Strings.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ];

  String getLanguageName(String code) {
    switch (code) {
      case 'en':
        return 'English';
      case 'bn':
        return 'বাংলা';
      default:
        return code;
    }
  }

  String getFlag(String code) {
    switch (code) {
      case 'en':
        return '🇺🇸';
      case 'bn':
        return '🇧🇩';
      case 'np':
        return '🇳🇵';
      default:
        return '🇧🇩';
    }
  }
}

import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';

class AppLocale {
  static AppLocalizations of(BuildContext context) {
    return AppLocalizations.of(context)!;
  }

  static String get currentLanguageCode {
    return 'es';
  }
}

extension LocalizationExtension on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this)!;
}

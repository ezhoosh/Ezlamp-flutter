import 'package:flutter/material.dart';

import 'navigation_service.dart';

class LocalizationService {
  static Locale selectedLocale =
      Localizations.localeOf(NavigationService.navigatorKey.currentState!.context);
  static bool isLocalPersian = selectedLocale.languageCode == 'fa';
}

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hr/core/di/di.dart';
import 'package:hr/core/helpers/cache/cache_keys.dart';
import 'package:hr/core/helpers/cache/shared_preferences/cache_helper.dart';

import 'app_localization.dart';

abstract class LocalizeConstants {
  static const List<String> _locale = ['en', 'ar'];

  static final _cachedLanguage = sl<CacheHelper>().getString(
    key: CacheKeys.languageCode,
  );
  static final _defaultLanguage = _cachedLanguage?.trim() ?? 'ar';

  //';

  static const _supportedLocales = [Locale('en'), Locale('ar')];

  static const List<LocalizationsDelegate> _delegates = [
    AppLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  //#region Localization Getters
  static List<String> get locale => _locale;

  static String get defaultLanguage => _defaultLanguage;

  static List<Locale> get supportedLocales => _supportedLocales;

  static List<LocalizationsDelegate> get delegates => _delegates;

  //#endregion
}

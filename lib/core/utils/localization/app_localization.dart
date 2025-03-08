import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hr/core/helpers/cache/cache_keys.dart';
import 'package:hr/core/utils/localization/localize_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppLocalizations {
  AppLocalizations(this.locale);

  final Locale locale;

  static AppLocalizations of(BuildContext context) =>
      Localizations.of<AppLocalizations>(context, AppLocalizations)!;

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  Map<String, String>? _localizedStrings;

  Future<void> load() async {
    String jsonString =
        await rootBundle.loadString('assets/localizations/${locale.languageCode}.json');

    Map<String, dynamic> jsonMap = json.decode(jsonString);
    _localizedStrings =
        jsonMap.map((key, value) => MapEntry(key, value.toString()));
  }

  String translate(String key) => _localizedStrings![key]!;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      LocalizeConstants.defaultLanguage.contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async {
    AppLocalizations localizations = AppLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalizations> old) =>
      false;
}

class AppLanguage extends ChangeNotifier{
  Locale _appLocale = Locale(LocalizeConstants.defaultLanguage);

  Locale get appLocal => _appLocale;

  Future<void> fetchLocale() async {
    var prefs = await SharedPreferences.getInstance();

    if (prefs.getString('language_code') == null) {
      _appLocale = Locale(LocalizeConstants.defaultLanguage);
      await prefs.setString('language_code', LocalizeConstants.defaultLanguage);
    } else {
      _appLocale = Locale(prefs.getString('language_code')!);
    }
  }

  void changeLanguage(Locale type) async {
    var prefs = await SharedPreferences.getInstance();
    if (_appLocale == type) {
      return;
    } else {
      _appLocale = type;
      await prefs.setString(CacheKeys.languageCode, type.languageCode);
      await prefs.setString('countryCode', '');
    }
    notifyListeners();
  }
}

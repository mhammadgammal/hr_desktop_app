import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hr/core/di/di.dart';
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
    log('AppLocalizations: load(): languageCode: ${locale.languageCode}');
    String jsonString =
    await rootBundle.loadString(
        'assets/localization/${sl<AppLanguage>().appLocal.languageCode}.json');

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
      LocalizeConstants.supportedLocales.contains(Locale(locale.languageCode));

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

    if (prefs.getString(CacheKeys.languageCode) == null) {
      _appLocale = Locale(LocalizeConstants.defaultLanguage);
      await prefs.setString(
          CacheKeys.languageCode, LocalizeConstants.defaultLanguage);
    } else {
      _appLocale = Locale(prefs.getString(CacheKeys.languageCode)!);
    }

    log('AppLanguage: fetchLocale(): languageCode: ${_appLocale.languageCode}');
  }

  void changeLanguage(Locale type) async {
    var prefs = await SharedPreferences.getInstance();
    log('AppLanguage: changeLanguage(): languageCode: ${type.languageCode}');
    log('AppLanguage: changeLanguage(): _appLocale == type: ${_appLocale ==
        type}');
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

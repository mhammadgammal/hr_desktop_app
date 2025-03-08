import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr/core/di/di.dart';
import 'package:hr/core/helpers/cache/cache_keys.dart';
import 'package:hr/core/helpers/cache/shared_preferences/cache_helper.dart';
import 'package:hr/core/utils/localization/app_localization.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());
  late AppLanguage _appLanguage;
  bool isDarkMode = sl<CacheHelper>().getBool(key: CacheKeys.isDark) ?? false;

  Locale get locale => sl.get<AppLanguage>().appLocal;

  ThemeMode get currentThemeMode =>
      isDarkMode ? ThemeMode.dark : ThemeMode.light;

  void getCurrentLocale() async {
    _appLanguage = sl.get<AppLanguage>();
    await _appLanguage.fetchLocale();
  }

  //void Function(T?)?
  void changeLanguage(Locale? locale) {
    if (locale != null) {
      log('AppCubit: changeLanguage(): languageCode: ${locale.languageCode}');
      _appLanguage.changeLanguage(locale);
      _appLanguage.fetchLocale();

      // _cacheLanguage(locale.languageCode);
      emit(AppLanguageChanged(locale));
    }
  }

  changeTheme(bool isDarkMode) {
    this.isDarkMode = isDarkMode;
    sl<CacheHelper>().putBool(CacheKeys.isDark, isDarkMode);
    emit(AppThemeChanged(isDarkMode));
  }

  static AppCubit get(BuildContext context) =>
      BlocProvider.of<AppCubit>(context);

  void _cacheLanguage(String languageCode) {
    sl<CacheHelper>().putString(
      key: CacheKeys.languageCode,
      value: languageCode,
    );
  }
}

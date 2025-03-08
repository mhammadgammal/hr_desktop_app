import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr/core/di/di.dart';
import 'package:hr/core/utils/localization/app_localization.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());
  late AppLanguage _appLanguage;
  bool isDarkMode = false;

  Locale get locale => sl.get<AppLanguage>().appLocal;

  void getCurrentLocale() async {
    _appLanguage = sl.get<AppLanguage>();
    await _appLanguage.fetchLocale();
  }

  //void Function(T?)?
  void changeLanguage(Locale? locale) {
    if (locale != null) {
      _appLanguage = sl.get<AppLanguage>();
      _appLanguage.changeLanguage(locale);
      _appLanguage.fetchLocale();
      emit(AppLanguageChanged(locale));
    }
  }

  changeTheme(bool isDarkMode) {
    this.isDarkMode = isDarkMode;
    emit(AppThemeChanged(isDarkMode));
  }

  static AppCubit get(BuildContext context) =>
      BlocProvider.of<AppCubit>(context);
}

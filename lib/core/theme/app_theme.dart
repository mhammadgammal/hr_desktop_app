import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hr/core/theme/app_colors.dart';

abstract class AppTheme {
  static double appRadius = 10.0.r;
  static double textFieldRadius = 8.0.r;

  static ThemeData lightTheme = ThemeData(
    primaryColor: AppColors.primaryColor,
    scaffoldBackgroundColor: AppColors.whiteBackground,
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.all(AppColors.primaryColor),
      trackColor: WidgetStateProperty.all(AppColors.gray),
    ),
    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.all(AppColors.primaryColor),
      overlayColor: WidgetStateProperty.all(AppColors.gray),
      splashRadius: appRadius,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.white,
      elevation: 0.0,
      toolbarHeight: 96.h,
    ),
    cardColor: AppColors.white,
    textTheme: TextTheme(
      bodyMedium: GoogleFonts.cairo(
        fontSize: 13.0.sp,
        color: AppColors.black,
        fontWeight: FontWeight.w500,
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    primaryColor: AppColors.primaryColor,
    scaffoldBackgroundColor: AppColors.black20,
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.all(AppColors.primaryColor),
      trackColor: WidgetStateProperty.all(AppColors.gray),
    ),
    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.all(AppColors.primaryColor),
      overlayColor: WidgetStateProperty.all(AppColors.gray),
      splashRadius: appRadius,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.gray2,
      elevation: 0.0,
      toolbarHeight: 96.h,
    ),
    cardColor: AppColors.gray2,
    textTheme: TextTheme(
      bodyMedium: GoogleFonts.cairo(
        fontSize: 13.0.sp,
        color: AppColors.white,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}

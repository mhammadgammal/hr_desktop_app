import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hr/core/app/cubit/app_cubit.dart';
import 'package:hr/core/router/app_router.dart';
import 'package:hr/core/router/router_keys.dart';
import 'package:hr/core/theme/app_theme.dart';
import 'package:hr/core/utils/localization/localize_constants.dart';

class InfinityHrApp extends StatelessWidget {
  const InfinityHrApp(this.isLogged, {super.key});

  final bool? isLogged;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1440, 1024),
      builder:
          (_, __) => BlocProvider(
            create: (context) => AppCubit()..getCurrentLocale(),
            child: BlocBuilder<AppCubit, AppState>(
              builder: (context, state) {
                return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  theme: AppTheme.lightTheme,
                  darkTheme: AppTheme.darkTheme,
                  themeMode: AppCubit.get(context).currentThemeMode,
                  routes: AppRouter.routes,
                  supportedLocales: LocalizeConstants.supportedLocales,
                  localizationsDelegates: LocalizeConstants.delegates,
                  initialRoute:
                      isLogged != null && isLogged!
                      ? RouterKeys.mainScreen
                      : RouterKeys.home,
                );
              },
            ),
          ),
    );
  }
}

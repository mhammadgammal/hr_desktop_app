import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hr/core/app/cubit/app_cubit.dart';
import 'package:hr/core/router/app_router.dart';
import 'package:hr/core/router/router_keys.dart';
import 'package:hr/core/theme/app_theme.dart';
import 'package:hr/core/utils/localization/app_localization.dart';
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
            create: (context) => AppCubit(),
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode: ThemeMode.dark,
              routes: AppRouter.routes,
              supportedLocales: LocalizeConstants.supportedLocales,
              localizationsDelegates: [
                AppLocalizations.delegate,
                DefaultMaterialLocalizations.delegate,
                DefaultWidgetsLocalizations.delegate,
              ],
              initialRoute:
                  isLogged != null && isLogged!
                      ? RouterKeys.mainScreen
                      : RouterKeys.home,
            ),
          ),
    );
  }
}

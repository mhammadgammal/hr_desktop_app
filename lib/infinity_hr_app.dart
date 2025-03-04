import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hr/core/router/app_router.dart';
import 'package:hr/core/theme/app_theme.dart';

class InfinityHrApp extends StatelessWidget {
  const InfinityHrApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1440, 1024),
      builder:
          (_, __) => MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: ThemeMode.dark,
            routes: AppRouter.routes,
          ),
    );
  }
}

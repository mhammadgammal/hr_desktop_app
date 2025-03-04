import 'package:flutter/cupertino.dart';
import 'package:hr/features/authentication/presentation/sign_in_screen.dart';

abstract class AppRouter {
  static Map<String, Widget Function(BuildContext)> routes = {
    '/': (context) => SignInScreen(),
  };
}

import 'package:flutter/cupertino.dart';

abstract class AppRouter {
  static Map<String, Widget Function(BuildContext)> routes = {
    '/': (context) => Center(child: Text('Home Screen')),
  };
}

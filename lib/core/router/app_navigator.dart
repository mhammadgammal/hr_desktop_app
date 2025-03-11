import 'package:flutter/material.dart';

abstract class AppNavigator {
  static void navigateTo(
    BuildContext context,
    String route, {
    Map<String, dynamic>? arguments,
  }) {
    Navigator.of(context).pushNamed(route, arguments: arguments);
  }

  static navigateAndFinishAll(
    BuildContext context,
    String route, {
    Map<String, dynamic>? arguments,
  }) async {
    Navigator.of(
      context,
    ).pushNamedAndRemoveUntil(route, (route) => false, arguments: arguments);
  }
}

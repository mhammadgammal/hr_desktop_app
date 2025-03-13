import 'package:hr/core/extensions/extensions.dart';

abstract class Validators {
  static String? validateEmail(context, String? value) {
    if (value != null && value.isEmpty) {
      return 'Email is required'.tr(context);
    }
    // if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
    //   return 'Please enter a valid email';
    // }
    return null;
  }

  static String? validatePassword(context, String? value) {
    if (value != null && value.isEmpty) {
      return 'Password is required'.tr(context);
    }

    if (value != null && value.length < 8) {
      return 'Password must be at least 8 characters'.tr(context);
    }

    return null;
  }
}

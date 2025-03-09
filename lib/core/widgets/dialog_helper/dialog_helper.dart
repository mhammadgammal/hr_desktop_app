import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hr/core/assets/app_icons.dart';

abstract class DialogHelper {
  static void showFailureDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            icon: SvgPicture.asset(AppIcons.failureIc),
            title: const Text('Error'),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK'),
              ),
            ],
          ),
    );
  }

  static void showSuccessDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            icon: SvgPicture.asset(AppIcons.successIc),
            title: const Text('Success'),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK'),
              ),
            ],
          ),
    );
  }
}

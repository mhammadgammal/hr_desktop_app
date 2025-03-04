import 'package:flutter/material.dart';
import 'package:hr/core/theme/app_colors.dart';
import 'package:hr/core/theme/app_theme.dart';

class CustomOutlinedButtonWithBorder extends StatelessWidget {
  const CustomOutlinedButtonWithBorder({
    super.key,
    required this.onPressed,
    required this.title,
  });

  final void Function() onPressed;
  final String title;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(Colors.transparent),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppTheme.appRadius),
          ),
        ),
        side: WidgetStatePropertyAll(
          BorderSide(color: AppColors.secondaryColor, width: 2),
        ),
      ),
      child: Text(title, style: TextStyle(color: Colors.black)),
    );
  }
}

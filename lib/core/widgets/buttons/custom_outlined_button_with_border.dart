import 'package:flutter/material.dart';
import 'package:hr/core/theme/app_colors.dart';
import 'package:hr/core/theme/app_theme.dart';

class CustomOutlinedButtonWithBorder extends StatelessWidget {
  const CustomOutlinedButtonWithBorder({
    super.key,
    required this.onPressed,
    required this.title,
    this.titleColor = Colors.white,
    this.borderColor,
    this.borderWidth = 2.0,
    this.icon,
  });

  final void Function() onPressed;
  final String title;
  final Color titleColor;
  final Color? borderColor;
  final double borderWidth;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(Colors.transparent),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppTheme.appRadius),
          ),
        ),
        side: WidgetStatePropertyAll(
          BorderSide(
            color: borderColor ?? AppColors.secondaryColor,
            width: borderWidth,
          ),
        ),
      ),
      label: Text(title, style: TextStyle(color: titleColor)),
      icon: icon,
    );
  }
}

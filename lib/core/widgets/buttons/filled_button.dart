import 'package:flutter/material.dart';
import 'package:hr/core/theme/app_colors.dart';
import 'package:hr/core/theme/app_theme.dart';

class FilledButton extends StatelessWidget {
  const FilledButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.disabled = false,
  });

  final String title;
  final void Function() onPressed;
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(
          disabled ? AppColors.gray : AppColors.secondaryColor,
        ),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppTheme.appRadius),
          ),
        ),
      ),
      child: Text(title),
    );
  }
}

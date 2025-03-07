import 'package:flutter/material.dart';
import 'package:hr/core/theme/app_colors.dart';
import 'package:hr/core/widgets/text_form_field/app_text_form_field.dart';

class ColumnedTextFormField extends StatelessWidget {
  const ColumnedTextFormField({
    super.key,
    required this.title,
    required this.controller,
    required this.inputType,
    this.enabled = true,
    this.titleColor = Colors.white,
    this.validate,
    this.hint,
    this.suffixIcon,
    this.maxLines = 1,
    this.textFieldTextColor = Colors.white,
    this.hintColor
  });

  final String title;
  final Color titleColor;
  final String? hint;
  final Color? hintColor;
  final bool enabled;
  final TextEditingController controller;
  final TextInputType inputType;
  final String? Function(String?)? validate;
  final IconButton? suffixIcon;
  final int maxLines;
  final Color textFieldTextColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(color: titleColor)),
        AppTextFormField(
          controller: controller,
          hintLabel: hint,
          inputType: inputType,
          isEnabled: enabled,
          validate: validate,
          suffixIcon: suffixIcon,
          maxLines: maxLines,
          hintColor: hintColor ?? AppColors.gray,
          textFieldTextColor: textFieldTextColor,
        ),
      ],
    );
  }
}

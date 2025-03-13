import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hr/core/app/cubit/app_cubit.dart';
import 'package:hr/core/theme/app_colors.dart';
import 'package:hr/core/widgets/text_form_field/app_text_form_field.dart';

class ColumnedTextFormField extends StatelessWidget {
  const ColumnedTextFormField({
    super.key,
    required this.title,
    required this.controller,
    required this.inputType,
    this.enabled = true,
    this.titleColor,
    this.validate,
    this.hint,
    this.suffixIcon,
    this.maxLines = 1,
    this.hintColor,
    this.isPassword = false,
  });

  final String title;
  final Color? titleColor;
  final String? hint;
  final Color? hintColor;
  final bool enabled;
  final TextEditingController controller;
  final TextInputType inputType;
  final String? Function(String?)? validate;
  final IconButton? suffixIcon;
  final int maxLines;
  final bool isPassword;
  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10.0.h,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontSize: 20.sp
          ),
        ),
        AppTextFormField(
          controller: controller,
          hintLabel: hint,
          inputType: inputType,
          isEnabled: enabled,
          validate: validate,
          suffixIcon: suffixIcon,
          maxLines: maxLines,
          obSecure: isPassword,
          hintColor: hintColor ?? AppColors.gray,
        ),
      ],
    );
  }
}

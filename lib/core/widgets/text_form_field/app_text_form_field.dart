import 'package:flutter/material.dart';
import 'package:hr/core/theme/app_colors.dart';

class AppTextFormField extends StatefulWidget {
  const AppTextFormField({
    super.key,
    required this.controller,
    required this.inputType,
    required this.fieldLabel,
    required this.icon,
    required this.validate,
    this.isEnabled = true,
    this.obSecure = false,
    this.inputAction,
    this.suffixIcon,
    this.initialValue,
    this.maxLines,
    this.minLines,
    this.labelColor = Colors.white,
    this.iconColor = Colors.white,
    this.textFieldTextColor = Colors.white,
    this.onChanged,
    this.cursorColor,
    this.focusNode,
    this.onSubmit,
    this.maxLength,
  });

  final TextEditingController controller;
  final TextInputType inputType;
  final TextInputAction? inputAction;
  final FocusNode? focusNode;
  final String? fieldLabel;
  final Icon? icon;
  final String? Function(String?)? validate;
  final Function(String)? onChanged;
  final bool obSecure;
  final IconButton? suffixIcon;
  final int? maxLines;
  final int? minLines;
  final bool isEnabled;
  final String? initialValue;
  final Color labelColor;
  final Color iconColor;
  final Color textFieldTextColor;
  final Color? cursorColor;
  final int? maxLength;
  final void Function(String?)? onSubmit;

  @override
  State<AppTextFormField> createState() => _AppTextFormFieldState();
}

class _AppTextFormFieldState extends State<AppTextFormField> {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        textSelectionTheme: TextSelectionThemeData(
          selectionHandleColor: AppColors.gray,
          selectionColor: AppColors.gray,
        ),
      ),
      child: TextFormField(
        controller: widget.controller,
        keyboardType: widget.inputType,
        style: TextStyle(color: widget.textFieldTextColor),
        decoration: InputDecoration(
          labelText: widget.fieldLabel,
          labelStyle: TextStyle(color: widget.labelColor),
          prefixIcon: widget.icon,
          suffixIcon: widget.suffixIcon,
          prefixIconColor: widget.iconColor,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: const BorderSide(color: Colors.grey, width: 1.5),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: const BorderSide(color: Colors.grey, width: 1.5),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: const BorderSide(color: Colors.grey, width: 1.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: BorderSide(
              color: AppColors.gray,
              style: BorderStyle.solid,
              width: 3.0,
            ),
          ),
        ),
        textInputAction: widget.inputAction,
        focusNode: widget.focusNode,
        minLines: widget.minLines ?? 1,
        maxLines: widget.obSecure ? 1 : widget.maxLines,
        cursorColor: widget.cursorColor,
        initialValue: widget.initialValue,
        enabled: widget.isEnabled,
        maxLength: widget.maxLength,
        obscureText: widget.obSecure,
        onChanged: widget.onChanged,
        validator: widget.validate,
        onSaved: widget.onSubmit,
      ),
    );
  }
}

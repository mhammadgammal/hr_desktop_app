import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hr/core/utils/validators/validators.dart';
import 'package:hr/core/widgets/text_form_field/app_text_form_field.dart';

class PasswordTextFormField extends StatefulWidget {
  const PasswordTextFormField({
    super.key,
    required this.controller,
    required this.label,
  });

  final TextEditingController controller;
  final String label;

  @override
  State<PasswordTextFormField> createState() => _PasswordTextFormFieldState();
}

class _PasswordTextFormFieldState extends State<PasswordTextFormField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Password', style: GoogleFonts.cairo(color: Colors.white)),
        AppTextFormField(
          controller: widget.controller,
          inputType: TextInputType.visiblePassword,
          hintLabel: widget.label,
          validate: Validators.validatePassword,
        ),
      ],
    );
  }
}

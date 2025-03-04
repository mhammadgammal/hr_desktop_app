import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hr/core/theme/app_colors.dart';
import 'package:hr/core/utils/validators/validators.dart';
import 'package:hr/core/widgets/text_form_field/app_text_form_field.dart';

class EmailTextFormField extends StatefulWidget {
  const EmailTextFormField({
    super.key,
    required this.controller,
    required this.label,
  });

  final TextEditingController controller;
  final String label;

  @override
  State<EmailTextFormField> createState() => _EmailTextFormFieldState();
}

class _EmailTextFormFieldState extends State<EmailTextFormField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Email', style: GoogleFonts.cairo(color: AppColors.white)),
        AppTextFormField(
          controller: widget.controller,
          inputType: TextInputType.emailAddress,
          hintLabel: widget.label,
          validate: Validators.validateEmail,
        ),
      ],
    );
  }
}

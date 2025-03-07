import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hr/core/widgets/text_form_field/columned_text_form_field.dart';

class FirstLastNameFields extends StatelessWidget {
  const FirstLastNameFields({
    super.key,
    required this.firstNameController,
    required this.lastNameController,
  });

  final TextEditingController firstNameController;
  final TextEditingController lastNameController;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10.0.w,
      children: [
        // first name text field
        Expanded(
          child: ColumnedTextFormField(
            controller: firstNameController,
            inputType: TextInputType.name,
            title: 'First Name',
            hint: 'First employee name',
            validate:
                (value) => value!.isEmpty ? 'First name is required' : null,
          ),
        ),
        // last name text field
        Expanded(
          child: ColumnedTextFormField(
            controller: lastNameController,
            inputType: TextInputType.name,
            title: 'Last Name',
            hint: 'Last employee name',
            validate:
                (value) => value!.isEmpty ? 'Last name is required' : null,
          ),
        ),
      ],
    );
  }
}

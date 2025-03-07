import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hr/core/widgets/text_form_field/columned_text_form_field.dart';
import 'package:hr/features/employees/presentation/add_employee_screen/cubit/add_employee_cubit.dart';

class EmailAndJobDescriptionFields extends StatelessWidget {
  const EmailAndJobDescriptionFields({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = AddEmployeeCubit.get(context);
    return Row(
      spacing: 10.0.w,
      children: [
        // email text field
        Expanded(
          child: ColumnedTextFormField(
            title: 'Email',
            controller: cubit.emailController,
            hint: 'example@gmail.com',
            inputType: TextInputType.emailAddress,
          ),
        ),

        // job description text field
        Expanded(
          child: ColumnedTextFormField(
            title: 'Job Description',
            controller: cubit.jobDescriptionController,
            hint: 'job title',
            inputType: TextInputType.text,
          ),
        ),
      ],
    );
  }
}

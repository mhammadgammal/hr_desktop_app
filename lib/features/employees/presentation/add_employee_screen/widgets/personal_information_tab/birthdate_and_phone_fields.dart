import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hr/core/theme/app_colors.dart';
import 'package:hr/core/widgets/date_picker.dart';
import 'package:hr/core/widgets/text_form_field/columned_text_form_field.dart';
import 'package:hr/features/employees/presentation/add_employee_screen/cubit/add_employee_cubit.dart';

class BirthdateAndPhoneFields extends StatelessWidget {
  const BirthdateAndPhoneFields({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = AddEmployeeCubit.get(context);
    return Row(
      spacing: 10.0.w,
      children: [
        // birthdate text field
        Expanded(
          child: DatePicker(
            datePickerController: cubit.birthdateController,
            datePickerLabel: 'birthday date',
            iconColor: AppColors.gray,
            dateColor: AppColors.white,
            labelColor: AppColors.white,
            validation: 'Please enter your birthdate',
          ),
        ),

        // phone text field
        Expanded(
          child: ColumnedTextFormField(
            title: 'Phone',
            controller: cubit.phoneController,
            inputType: TextInputType.phone,
          ),
        ),
      ],
    );
  }
}

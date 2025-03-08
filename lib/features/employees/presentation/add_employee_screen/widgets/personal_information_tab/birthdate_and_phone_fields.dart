import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hr/core/extensions/extensions.dart';
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
            datePickerLabel: 'birthday date'.tr(context),
            iconColor: AppColors.gray,
            validation: 'Please enter your birthdate'.tr(context),
          ),
        ),

        // phone text field
        Expanded(
          child: ColumnedTextFormField(
            title: 'Phone'.tr(context),
            controller: cubit.phoneController,
            inputType: TextInputType.phone,
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hr/core/extensions/extensions.dart';
import 'package:hr/core/widgets/text_form_field/columned_text_form_field.dart';
import 'package:hr/features/employees/presentation/add_employee_screen/cubit/add_employee_cubit.dart';

class WorkingHoursAndDaysFields extends StatelessWidget {
  const WorkingHoursAndDaysFields({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = AddEmployeeCubit.get(context);
    return Row(
      spacing: 10.0.w,
      children: [
        // Working hours text field
        Expanded(
          child: ColumnedTextFormField(
            title: 'Working hours'.tr(context),
            controller: cubit.workingHoursController,
            hint: 'Number of working hours'.tr(context),
            inputType: TextInputType.number,
          ),
        ),
        Expanded(
          child: ColumnedTextFormField(
            title: 'Working days'.tr(context),
            controller: cubit.workingDaysController,
            hint: 'Working days'.tr(context),
            inputType: TextInputType.number,
          ),
        ),
      ],
    );
  }
}

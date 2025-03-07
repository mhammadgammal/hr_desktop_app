import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hr/core/widgets/buttons/custom_filled_button.dart';
import 'package:hr/core/widgets/text_form_field/columned_text_form_field.dart';
import 'package:hr/features/employees/presentation/add_employee_screen/cubit/add_employee_cubit.dart';

class SalaryDetailsTab extends StatelessWidget {
  const SalaryDetailsTab({super.key});

  @override
  Widget build(BuildContext context) {
    AddEmployeeCubit cubit = AddEmployeeCubit.get(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 20.0.h,
      children: [
        // salary text field
        Row(
          children: [
            Expanded(
              child: ColumnedTextFormField(
                title: 'Salary',
                hint: 'monthly salary',
                controller: cubit.salaryController,
                inputType: TextInputType.number,
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: ColumnedTextFormField(
                title: 'Salary Date',
                hint: 'Write the day of salary coming down',
                controller: cubit.salaryDateController,
                inputType: TextInputType.number,
              ),
            ),
          ],
        ),

        Row(
          children: [
            Expanded(
              child: ColumnedTextFormField(
                title: 'Overtime hours(yearly)',
                hint: 'Number of hours per year',
                controller: cubit.overtimeHoursYearlyController,
                inputType: TextInputType.number,
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: ColumnedTextFormField(
                title: 'Overtime hours(monthly)',
                hint: 'Number of hours per month',
                controller: cubit.overtimeHoursMonthlyController,
                inputType: TextInputType.number,
              ),
            ),
          ],
        ),
        SizedBox(
          width: 400.0.w,
          height: 92.0.h,
          child: ColumnedTextFormField(
            title: 'Overtime price',
            hint: 'Price per hour',
            controller: cubit.overtimePrice,
            inputType: TextInputType.number,
          ),
        ),
        SizedBox(height: 20.0.h),
        CustomFilledButton(
          width: 300.0.w,
          height: 60.0.h,
          title: 'Save changes',
          onPressed: () => cubit.nextTab(),
        ),
      ],
    );
  }
}

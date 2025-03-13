import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hr/core/extensions/extensions.dart';
import 'package:hr/core/theme/app_colors.dart';
import 'package:hr/core/widgets/buttons/custom_filled_button.dart';
import 'package:hr/core/widgets/date_picker.dart';
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
                title: 'Salary'.tr(context),
                hint: 'monthly salary'.tr(context),
                controller: cubit.salaryController,
                inputType: TextInputType.number,
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: DatePicker(
                datePickerController: cubit.salaryDateController,
                datePickerLabel: 'Salary Date'.tr(context),
                iconColor: AppColors.gray,
                dateColor: AppColors.white,
                labelColor: AppColors.white,
                validation: 'Please enter your Salary Date'.tr(context),
              ),
            ),
          ],
        ),

        Row(
          children: [
            Expanded(
              child: ColumnedTextFormField(
                title: 'Overtime hours(yearly)'.tr(context),
                hint: 'Number of hours per year'.tr(context),
                controller: cubit.overtimeHoursYearlyController,
                inputType: TextInputType.number,
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: ColumnedTextFormField(
                title: 'Overtime hours(monthly)'.tr(context),
                hint: 'Number of hours per month'.tr(context),
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
            title: 'Overtime price'.tr(context),
            hint: 'Price per hour'.tr(context),
            controller: cubit.overtimePrice,
            inputType: TextInputType.number,
          ),
        ),
        SizedBox(height: 20.0.h),
        CustomFilledButton(
          width: 300.0.w,
          height: 60.0.h,
          title: 'Save changes'.tr(context),
          onPressed: () => cubit.constructEmployee(),
        ),
      ],
    );
  }
}

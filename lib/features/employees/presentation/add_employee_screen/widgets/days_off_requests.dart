import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hr/core/app/cubit/app_cubit.dart';
import 'package:hr/core/extensions/extensions.dart';
import 'package:hr/core/theme/app_colors.dart';
import 'package:hr/core/widgets/buttons/custom_filled_button.dart';
import 'package:hr/core/widgets/date_picker.dart';
import 'package:hr/core/widgets/text_form_field/columned_text_form_field.dart';
import 'package:hr/features/employees/presentation/add_employee_screen/cubit/add_employee_cubit.dart';

class DaysOffRequests extends StatelessWidget {
  const DaysOffRequests({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddEmployeeCubit, AddEmployeeState>(
      builder: (context, state) {
        var cubit = AddEmployeeCubit.get(context);
        return Column(
          spacing: 10.0.h,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              spacing: 10.0.w,
              children: [
                Expanded(
                  child: DatePicker(
                    datePickerController: cubit.dayOffStartDateController,
                    datePickerHint: 'Day Off Start'.tr(context),
                    datePickerLabel: 'Day Off date'.tr(context),
                    dateColor: AppColors.gray,
                    labelColor:
                        AppCubit.get(context).isDarkMode
                            ? AppColors.white
                            : AppColors.black,
                    validation: 'Day Off date is required'.tr(context),
                  ),
                ),
                Expanded(
                  child: DatePicker(
                    datePickerController: cubit.dayOffEndDateController,
                    datePickerLabel: 'Day Off date'.tr(context),
                    datePickerHint: 'Day Off date'.tr(context),
                    labelColor:
                        AppCubit.get(context).isDarkMode
                            ? AppColors.white
                            : AppColors.black,
                    validation: 'Day Off date is required'.tr(context),
                    dateColor: AppColors.gray,
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 300.0.w,
              child: ColumnedTextFormField(
                title: 'Remaining vacation days',
                controller: cubit.remainingVacationDays,
                inputType: TextInputType.text,
              ),
            ),
            SizedBox(
              width: 300.0.w,
              height: 60.0.h,
              child: CustomFilledButton(
                title: 'SaveChanges'.tr(context),
                onPressed: () {
                  cubit.requestVacation();
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

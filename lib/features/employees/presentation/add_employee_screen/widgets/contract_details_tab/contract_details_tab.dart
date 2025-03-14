import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hr/core/app/cubit/app_cubit.dart';
import 'package:hr/core/extensions/extensions.dart';
import 'package:hr/core/theme/app_colors.dart';
import 'package:hr/core/widgets/buttons/custom_filled_button.dart';
import 'package:hr/core/widgets/date_picker.dart';
import 'package:hr/core/widgets/drawer/cubit/navigation_drawer_cubit.dart';
import 'package:hr/features/employees/presentation/add_employee_screen/cubit/add_employee_cubit.dart';
import 'package:hr/features/employees/presentation/add_employee_screen/widgets/attach_file_button.dart';

class ContractDetailsTab extends StatelessWidget {
  const ContractDetailsTab({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = AddEmployeeCubit.get(context);
    final navCubit = NavigationDrawerCubit.get(context);
    return Column(
      spacing: 10.0.h,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          spacing: 10.0.w,
          children: [
            Expanded(
              child: DatePicker(
                datePickerController: cubit.contractStartDateController,
                datePickerHint: 'Contract start date'.tr(context),
                datePickerLabel: 'Contract start date'.tr(context),
                dateColor: AppColors.gray,
                labelColor:
                    AppCubit.get(context).isDarkMode
                        ? AppColors.white
                        : AppColors.black,
                validation: 'Contract start date is required'.tr(context),
              ),
            ),
            Expanded(
              child: DatePicker(
                datePickerController: cubit.contractEndDateController,
                datePickerLabel: 'Contract end date'.tr(context),
                datePickerHint: 'Contract end date'.tr(context),
                labelColor:
                    AppCubit.get(context).isDarkMode
                        ? AppColors.white
                        : AppColors.black,
                validation: 'Contract end date is required'.tr(context),
                dateColor: AppColors.gray,
              ),
            ),
          ],
        ),
        Text(
          'Contract Details'.tr(context),
          style: GoogleFonts.cairo(fontSize: 18.0.sp, color: AppColors.white),
        ),
        AttachFileButton(
          title: 'Download Contract',
          pickCallback: cubit.pickContract,
        ),
        SizedBox(height: 20.0.h),
        CustomFilledButton(
          width: 300.0.w,
          height: 60.0.h,
          title: 'Save changes'.tr(context),
          onPressed: () async {
            await cubit.submitData();

            navCubit.onItemTapped(0);
          },
        ),
      ],
    );
  }
}

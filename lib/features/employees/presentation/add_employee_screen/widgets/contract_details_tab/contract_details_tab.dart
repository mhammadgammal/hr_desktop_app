import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hr/core/assets/app_icons.dart';
import 'package:hr/core/extensions/extensions.dart';
import 'package:hr/core/theme/app_colors.dart';
import 'package:hr/core/widgets/buttons/custom_filled_button.dart';
import 'package:hr/core/widgets/buttons/custom_outlined_button_with_border.dart';
import 'package:hr/core/widgets/date_picker.dart';
import 'package:hr/features/employees/presentation/add_employee_screen/cubit/add_employee_cubit.dart';

class ContractDetailsTab extends StatelessWidget {
  const ContractDetailsTab({super.key});

  @override
  Widget build(BuildContext context) {
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
                datePickerController: cubit.contractStartDateController,
                datePickerLabel: 'Contract start date'.tr(context),
                validation: 'Contract start date is required'.tr(context),
              ),
            ),
            Expanded(
              child: DatePicker(
                datePickerController: cubit.contractEndDateController,
                datePickerLabel: 'Contract end date'.tr(context),
                validation: 'Contract end date is required'.tr(context),
              ),
            ),
          ],
        ),
        Text(
          'Contract Details'.tr(context),
          style: GoogleFonts.cairo(fontSize: 18.0.sp, color: AppColors.white),
        ),
        CustomOutlinedButtonWithBorder(
          onPressed: () {},
          title: 'Download Contract'.tr(context),
          titleColor: AppColors.secondaryColor,
          icon: SvgPicture.asset(AppIcons.downloadIc),
        ),

        CustomFilledButton(
          width: 300.0.w,
          height: 60.0.h,
          title: 'Save changes'.tr(context),
          onPressed: () => cubit.submitData(),
        ),
      ],
    );
  }
}

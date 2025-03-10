import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hr/core/assets/app_icons.dart';
import 'package:hr/core/extensions/extensions.dart';
import 'package:hr/core/theme/app_colors.dart';
import 'package:hr/core/widgets/buttons/custom_filled_button.dart';
import 'package:hr/core/widgets/buttons/custom_outlined_button_with_border.dart';
import 'package:hr/core/widgets/text_form_field/columned_text_form_field.dart';
import 'package:hr/features/employees/presentation/add_employee_screen/cubit/add_employee_cubit.dart';

class SecondPagePersonalInformationTab extends StatelessWidget {
  const SecondPagePersonalInformationTab({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = AddEmployeeCubit.get(context);
    return Flexible(
      fit: FlexFit.loose,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            children: [
              Expanded(
                child: ColumnedTextFormField(
                  title: 'Identity or residence'.tr(context),
                  controller: cubit.residenceController,
                  inputType: TextInputType.text,
                  enabled: false,
                  suffixIcon: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.keyboard_arrow_down),
                  ),
                  hint: 'Choose from your options'.tr(context),
                ),
              ),
              SizedBox(width: 20.0.w),
              Expanded(
                child: ColumnedTextFormField(
                  title: 'Identity number'.tr(context),
                  controller: cubit.identityNumberController,
                  inputType: TextInputType.number,
                  hint: 'xxxx-xxxx-xxxx'.tr(context),
                ),
              ),
            ],
          ),
          SizedBox(height: 20.0.h),
          Text(
            'Identity photo'.tr(context),
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: AppColors.black,
              fontSize: 18.0.sp,
            ),
          ),
          SizedBox(height: 2.0.h),
          CustomOutlinedButtonWithBorder(
            onPressed: () {
              cubit.createEmployee();
            },
            title: 'Download Identity'.tr(context),
            titleColor: AppColors.secondaryColor,
            icon: SvgPicture.asset(AppIcons.downloadIc),
          ),
          SizedBox(height: 20.0.h),

          CustomFilledButton(
            width: 300.0.w,
            height: 60.0.h,
            title: 'Save changes'.tr(context),
            onPressed: () => cubit.nextTab(),
          ),
        ],
      ),
    );
  }
}

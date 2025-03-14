import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hr/core/app/cubit/app_cubit.dart';
import 'package:hr/core/assets/app_icons.dart';
import 'package:hr/core/extensions/extensions.dart';
import 'package:hr/core/theme/app_colors.dart';
import 'package:hr/core/theme/app_theme.dart';
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 10.0.h,
                  children: [
                    Text(
                      'Identity or residence'.tr(context),
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.copyWith(fontSize: 20.sp),
                    ),
                    DropdownButtonFormField<String?>(
                      value: cubit.selectedIdentityType,
                      hint: Text(
                        'Identity or residence'.tr(context),
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: 15.0.sp,
                          color: AppColors.gray,
                        ),
                      ),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            AppTheme.appRadius,
                          ),
                          borderSide: BorderSide(
                            width: 2.w,
                            color: AppColors.black,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            AppTheme.appRadius,
                          ),
                          borderSide: BorderSide(
                            width: 2.w,
                            color:
                                AppColors
                                    .gray, // Change focus border color here
                          ),
                        ),
                      ),
                      dropdownColor:
                          AppCubit.get(context).isDarkMode
                              ? AppColors.gray
                              : AppColors.white,
                      focusColor: AppColors.secondaryColor,
                      items: List.generate(
                        cubit.identityTypes.length,
                        (index) => DropdownMenuItem(
                          value: cubit.identityTypes[index],
                          child: Text(cubit.identityTypes[index].tr(context)),
                        ),
                      ),
                      onChanged: cubit.onIdentityTypeChanged,
                    ),
                  ],
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
            style: Theme.of(
              context,
            ).textTheme.bodyMedium!.copyWith(fontSize: 18.0.sp),
          ),
          SizedBox(height: 2.0.h),
          CustomOutlinedButtonWithBorder(
            width: 250.0.w,
            height: 50.0.h,
            onPressed: () {
              cubit.pickIdentity();
            },
            title: 'Download Identity'.tr(context),
            fontSize: 16,
            fontWeight: FontWeight.bold,
            titleColor: AppColors.secondaryColor,
            icon: SvgPicture.asset(AppIcons.downloadIc),
          ),
          SizedBox(height: 20.0.h),
          CustomFilledButton(
            width: 300.0.w,
            height: 50.0.h,
            title: 'Save changes'.tr(context),
            onPressed: () => cubit.constructEmployee(),
          ),
        ],
      ),
    );
  }
}

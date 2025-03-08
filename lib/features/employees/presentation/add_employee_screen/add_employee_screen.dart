import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hr/core/app/cubit/app_cubit.dart';
import 'package:hr/core/extensions/extensions.dart';
import 'package:hr/core/theme/app_colors.dart';
import 'package:hr/core/widgets/buttons/custom_outlined_button_with_border.dart';
import 'package:hr/core/widgets/dialog_helper/dialog_helper.dart';
import 'package:hr/features/employees/presentation/add_employee_screen/cubit/add_employee_cubit.dart';
import 'package:hr/features/employees/presentation/add_employee_screen/widgets/contract_details_tab/contract_details_tab.dart';
import 'package:hr/features/employees/presentation/add_employee_screen/widgets/personal_information_tab/personal_information_tab.dart';
import 'package:hr/features/employees/presentation/add_employee_screen/widgets/salary_details_tab/salary_details_tab.dart';

import 'widgets/personal_information_tab/attach_profile_picture.dart';

class AddEmployeeScreen extends StatelessWidget {
  const AddEmployeeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tabsNames = <String>[
      'Personal Information',
      'Salary Details',
      'Contract Details',
    ];

    return BlocProvider(
      create: (context) => AddEmployeeCubit(),
      child: BlocConsumer<AddEmployeeCubit, AddEmployeeState>(
        listener: (context, state) {
          if (state is AddEmployeeSuccessState) {
            DialogHelper.showSuccessDialog(
              context,
              'Employee added successfully',
            );
          }
        },
        builder: (context, state) {
          final cubit = AddEmployeeCubit.get(context);
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _screenHeader(context),
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 231.w,
                    height: 200.h,
                    color:
                        AppCubit.get(context).isDarkMode
                            ? AppColors.gray2
                            : AppColors.white,
                    margin: EdgeInsetsDirectional.only(top: 20.0.w),
                    child: ListView.builder(
                      padding: EdgeInsetsDirectional.only(start: 10.0.w),
                      itemCount: tabsNames.length,
                      itemBuilder:
                          (context, index) => ListTile(
                            onTap: () => cubit.changeTab(index),
                            selected: cubit.selectedTabIndex == index,
                            title: Text(
                              tabsNames[index].tr(context),
                              style: GoogleFonts.cairo(
                                color:
                                    cubit.selectedTabIndex == index
                                        ? AppColors.secondaryColor
                                        : (AppCubit.get(context).isDarkMode
                                            ? AppColors.white
                                            : AppColors.black),
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            contentPadding: EdgeInsets.zero,
                          ),
                    ),
                  ),
                  Container(
                    width: 828.w,
                    height: 764.h,
                    color:
                        AppCubit.get(context).isDarkMode
                            ? AppColors.gray2
                            : AppColors.white,
                    padding: EdgeInsetsDirectional.only(
                      start: 20.0.w,
                      top: 20.0.w,
                    ),
                    margin: EdgeInsetsDirectional.only(
                      start: 20.0.w,
                      top: 20.0.w,
                    ),
                    child: Column(
                      children: [
                        AttachProfilePicture(),
                        SizedBox(height: 20.0.h),
                        _switchTabItem(context, cubit.selectedTabIndex),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  _screenHeader(BuildContext context) => Row(
    children: [
      Text(
        'Personal Information'.tr(context),
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
          fontSize: 32.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
      Spacer(),
      CustomOutlinedButtonWithBorder(
        onPressed: () {},
        title: 'Delete file'.tr(context),
      ),
    ],
  );

  _switchTabItem(BuildContext context, int selectedTabIndex) {
    switch (selectedTabIndex) {
      case 0:
        return PersonalInformationTab();
      case 1:
        return SalaryDetailsTab();
      case 2:
        return ContractDetailsTab();
    }
  }
}

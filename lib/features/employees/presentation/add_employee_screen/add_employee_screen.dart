import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hr/core/app/cubit/app_cubit.dart';
import 'package:hr/core/assets/app_icons.dart';
import 'package:hr/core/extensions/extensions.dart';
import 'package:hr/core/theme/app_colors.dart';
import 'package:hr/core/widgets/buttons/custom_outlined_button_with_border.dart';
import 'package:hr/core/widgets/dialog_helper/dialog_helper.dart';
import 'package:hr/core/widgets/drawer/cubit/navigation_drawer_cubit.dart';
import 'package:hr/features/employees/data/model/employee_model.dart';
import 'package:hr/features/employees/presentation/add_employee_screen/cubit/add_employee_cubit.dart';
import 'package:hr/features/employees/presentation/add_employee_screen/widgets/contract_details_tab/contract_details_tab.dart';
import 'package:hr/features/employees/presentation/add_employee_screen/widgets/days_off_requests.dart';
import 'package:hr/features/employees/presentation/add_employee_screen/widgets/personal_information_tab/personal_information_tab.dart';
import 'package:hr/features/employees/presentation/add_employee_screen/widgets/salary_details_tab/salary_details_tab.dart';

import 'widgets/personal_information_tab/attach_profile_picture.dart';

class AddEmployeeScreen extends StatelessWidget {
  const AddEmployeeScreen({super.key, this.emp});

  final EmployeeModel? emp;

  @override
  Widget build(BuildContext context) {
    final tabsNames = <String>[
      'Personal Information',
      'Salary Details',
      'Contract Details',
      'Day off request\'s',
    ];

    return BlocProvider(
      create: (context) => AddEmployeeCubit()..loadEmployeeContract(emp),
      child: BlocConsumer<AddEmployeeCubit, AddEmployeeState>(
        listener: (context, state) {
          if (state is AddEmployeeSuccessState) {
            DialogHelper.showSuccessDialog(
              context: context,
              header: 'Saved Successfully',
              message: 'Employee added successfully'.tr(context),
            );
            NavigationDrawerCubit.get(context).onItemTapped(0);
          }

          if (state is ConstructEmployeeState) {
            DialogHelper.showSuccessDialog(
              context: context,
              header: 'Saved Successfully',
              message: 'Employee added successfully'.tr(context),
            );
          }
          if (state is UpdateEmployeeSuccessState) {
            DialogHelper.showSuccessDialog(
              context: context,
              header: 'Changed Successfully',
              message: 'Employee updated successfully'.tr(context),
            );
            NavigationDrawerCubit.get(context).onItemTapped(0);
          }

          if (state is EmployeeDeletedSuccessfully) {
            // Navigator.pop(context);
            DialogHelper.showSuccessDialog(
              context: context,
              header: "Employee Deleted Success",
              message: 'Employee deleted successfully'.tr(context),
            );
            NavigationDrawerCubit.get(context).onItemTapped(0);
          }
        },
        builder: (context, state) {
          final cubit = AddEmployeeCubit.get(context);
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _screenHeader(context),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 231.w,
                      height: emp != null ? 300.h : 160.h,
                      color:
                          AppCubit.get(context).isDarkMode
                              ? AppColors.gray2
                              : AppColors.white,
                      margin: EdgeInsetsDirectional.only(top: 20.0.w),
                      child: ListView.builder(
                        padding: EdgeInsetsDirectional.only(start: 10.0.w),
                        itemCount:
                            emp != null
                                ? tabsNames.length
                                : (tabsNames.length - 1),
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
                        end: 20.0.w,
                        top: 20.0.w,
                          bottom: 20.0.w
                      ),
                      margin: EdgeInsetsDirectional.only(
                        start: 20.0.w,
                        top: 20.0.w,
                      ),
                      child: Column(
                        // mainAxisSize: MainAxisSize.max,
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
            ),
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
      Visibility(
        visible: AddEmployeeCubit.get(context).isEditMode,
        child: CustomOutlinedButtonWithBorder(
          width: 150.0.w,
          onPressed: () {
            DialogHelper.deleteDialog(
              context,
              () {
                AddEmployeeCubit.get(context).deleteEmp();
              },
              () {
                Navigator.of(context).pop();
              },
            );
          },
          title: 'Delete file'.tr(context),
          titleColor: AppColors.failure,
          borderColor: AppColors.failure,
          icon: SvgPicture.asset(AppIcons.deleteIc),
        ),
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
      case 3:
        return DaysOffRequests();
    }
  }
}

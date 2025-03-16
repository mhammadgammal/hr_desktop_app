import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hr/core/app/cubit/app_cubit.dart';
import 'package:hr/core/assets/app_icons.dart';
import 'package:hr/core/assets/app_images.dart';
import 'package:hr/core/extensions/extensions.dart';
import 'package:hr/core/theme/app_colors.dart';
import 'package:hr/core/widgets/dialog_helper/dialog_helper.dart';
import 'package:hr/core/widgets/drawer/cubit/navigation_drawer_cubit.dart';
import 'package:hr/core/widgets/drawer/navigation_drawer.dart' as drawer;
import 'package:hr/core/widgets/text_form_field/app_text_form_field.dart';
import 'package:hr/features/employees/presentation/add_edit_employee/employee_details/employee_details_screen.dart';
import 'package:hr/features/employees/presentation/add_employee_screen/add_employee_screen.dart';
import 'package:hr/features/employees/presentation/emplyees_screen/cubit/employees_cubit.dart';
import 'package:hr/features/employees/presentation/emplyees_screen/employee_screen.dart';
import 'package:hr/features/vacations_alarms/presentation/vacations_alarm_screen.dart';

import '../../features/settings/settings_screen.dart' show SettingsScreen;

class AppLayout extends StatelessWidget {
  const AppLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<NavigationDrawerCubit, NavigationDrawerState>(
        builder: (context, state) {
          var navCubit = NavigationDrawerCubit.get(context);
          return Row(
            children: [
              drawer.NavigationDrawer(),
              Expanded(
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 90.0.h,
                      color:
                          AppCubit.get(context).isDarkMode
                              ? AppColors.gray2
                              : AppColors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            width: 530.w,
                            height: 50.h,
                            margin: EdgeInsetsDirectional.only(start: 150.0.w),
                            child: AppTextFormField(
                              hintLabel:
                                  'Search here by the name of the employee or the job'
                                      .tr(context),
                              icon: SvgPicture.asset(AppIcons.searchIc),
                              controller:
                                  NavigationDrawerCubit.get(
                                    context,
                                  ).searchController,
                              inputType: TextInputType.text,
                              onChanged: (value) {
                                navCubit.isFiltered = value.isNotEmpty;
                              },
                              onSubmit: (_) {
                                EmployeesCubit.get(context).searchEmployees(
                                  nameOrJob: navCubit.searchController.text,
                                );
                              },
                              suffixIcon: IconButton(
                                onPressed: () {
                                  if (navCubit
                                      .searchController
                                      .text
                                      .isNotEmpty) {
                                    navCubit.searchController.clear();
                                    navCubit.isFiltered = false;
                                    EmployeesCubit.get(
                                      context,
                                    ).getAllEmployees();
                                  } else {
                                    _showFilterDialog(
                                      context,
                                      NavigationDrawerCubit.get(context),
                                    );
                                  }
                                },
                                icon:
                                    navCubit.searchController.text.isNotEmpty
                                        ? SvgPicture.asset(
                                          AppIcons.xIc,
                                          colorFilter: ColorFilter.mode(
                                            AppColors.gray2,
                                            BlendMode.srcIn,
                                          ),
                                        )
                                        : SvgPicture.asset(AppIcons.filterIc),
                              ),
                              validate: null,
                            ),
                          ),
                          SizedBox(height: 10.0.h),
                          GestureDetector(
                            onTap: () => navCubit.onItemTapped(3),
                            child: ClipRRect(
                              child: SvgPicture.asset(
                                width: 50.0.w,
                                height: 50.0.h,
                                AppImages.profilePlaceholder,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: _switchScreen(
                        context,
                        state,
                        NavigationDrawerCubit.get(context).selectedIndex,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _switchScreen(context, state, int selectedIndex) {
    switch (selectedIndex) {
      case 0:
        return state is ShowEmployeeDetailsState
            ? EmployeeDetailsScreen(emp: state.emp)
            : EmployeeScreen();
      case 1:
        return VacationsAlarmScreen();
      case 2:
        return AddEmployeeScreen();
      case 3:
        return SettingsScreen();
      default:
        return Center(child: Text('Wrong dest'));
    }
  }

  void _showFilterDialog(context, NavigationDrawerCubit cubit) {
    DialogHelper.showFilterEmployeeDialog(
      context,
      nameFilter: cubit.filterByEmployeeNameController,
      jobFilter: cubit.filterByJobController,
      workingDays: cubit.filterByWorkingHoursController,
      workingHours: cubit.filterByWorkingHoursController,
      identity: cubit.filterByIdentityNumberController,
      onFilterPressed: () async {
        Navigator.pop(context);
        await EmployeesCubit.get(context).searchEmployees(
          name: cubit.filterByEmployeeNameController.text,
          job: cubit.filterByJobController.text,
          workingDays: cubit.filterByWorkingHoursController.text,
          workingHours: cubit.filterByWorkingHoursController.text,
          identityNumber: cubit.filterByIdentityNumberController.text,
        );
      },
    );
  }
}

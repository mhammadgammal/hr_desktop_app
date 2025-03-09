import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hr/core/widgets/drawer/cubit/navigation_drawer_cubit.dart';
import 'package:hr/core/widgets/drawer/navigation_drawer.dart' as drawer;
import 'package:hr/features/employees/presentation/add_edit_employee/employee_details/employee_details_screen.dart';
import 'package:hr/features/employees/presentation/add_employee_screen/add_employee_screen.dart';
import 'package:hr/features/employees/presentation/emplyees_screen/employee_screen.dart';

import '../../features/settings/settings_screen.dart' show SettingsScreen;

class AppLayout extends StatelessWidget {
  const AppLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<NavigationDrawerCubit, NavigationDrawerState>(
        builder: (context, state) {
          return Row(
            children: [
              drawer.NavigationDrawer(),
              SizedBox(width: 30.0.w),
              Expanded(
                child: _switchScreen(
                  context,
                  state,
                  NavigationDrawerCubit.get(context).selectedIndex,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  _switchScreen(context, state, int selectedIndex) {
    switch (selectedIndex) {
      case 0:
        return state is ShowEmployeeDetailsState
            ? EmployeeDetailsScreen(emp: state.emp)
            : EmployeeScreen();
      case 1:
        return Container();
      case 2:
        return AddEmployeeScreen();
      case 3:
        return SettingsScreen();
      default:
        return Center(child: Text('Wrong dest'));
    }
  }
}

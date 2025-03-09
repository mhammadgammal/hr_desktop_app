import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr/core/widgets/drawer/cubit/navigation_drawer_cubit.dart';
import 'package:hr/features/employees/data/model/employee_model.dart';
import 'package:hr/features/employees/presentation/add_employee_screen/add_employee_screen.dart';

class EmployeeDetailsScreen extends StatelessWidget {
  const EmployeeDetailsScreen({super.key, required this.emp});

  final EmployeeModel emp;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider.value(
        value: NavigationDrawerCubit(),
        child: BlocBuilder<NavigationDrawerCubit, NavigationDrawerState>(
          builder: (context, state) {
            return AddEmployeeScreen(emp: emp);
          },
        ),
      ),
    );
  }
}

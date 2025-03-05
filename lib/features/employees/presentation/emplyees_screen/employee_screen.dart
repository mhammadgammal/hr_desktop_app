import 'package:flutter/material.dart';
import 'package:hr/core/theme/app_colors.dart';

class EmployeeScreen extends StatelessWidget {
  const EmployeeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Employee Screen',
          style: TextStyle(color: AppColors.white),
        ),
      ),
    );
  }
}

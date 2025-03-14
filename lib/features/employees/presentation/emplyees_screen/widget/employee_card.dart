import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hr/core/extensions/extensions.dart';
import 'package:hr/core/theme/app_colors.dart';
import 'package:hr/core/widgets/drawer/cubit/navigation_drawer_cubit.dart';
import 'package:hr/features/employees/data/model/employee_model.dart';
import 'package:hr/features/employees/presentation/emplyees_screen/widget/employee_picture.dart';

class EmployeeCard extends StatelessWidget {
  const EmployeeCard({super.key, required this.emp});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => NavigationDrawerCubit.get(context).showEmployeeDetails(emp),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0.h, horizontal: 15.0.w),
          child: Column(
            spacing: 10.0,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              EmployeePicture(picturePath: emp.imagePath),
              Text(
                '${emp.firstName} ${emp.lastName}',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                emp.job,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: AppColors.gray,
                  fontSize: 20.sp,
                ),
              ),
              RichText(
                text: TextSpan(
                  text: '${'Working hours'.tr(context)}: ',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: AppColors.gray,
                    fontSize: 18.sp,
                  ),
                  children: [
                    TextSpan(
                      text: '${emp.workHours}',
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium!.copyWith(fontSize: 18.sp),
                    ),
                  ],
                ),
              ),
              RichText(
                text: TextSpan(
                  text: '${'Working days'.tr(context)}: ',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: AppColors.gray,
                    fontSize: 18.sp,
                  ),
                  children: [
                    TextSpan(
                      text: emp.workingDays,
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium!.copyWith(fontSize: 18.sp),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  final EmployeeModel emp;
}

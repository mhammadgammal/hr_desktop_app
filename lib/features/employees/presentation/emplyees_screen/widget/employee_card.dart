import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hr/core/extensions/extensions.dart';
import 'package:hr/core/router/router_keys.dart';
import 'package:hr/core/widgets/profile_picture.dart';
import 'package:hr/features/employees/data/model/employee_model.dart';

class EmployeeCard extends StatelessWidget {
  const EmployeeCard({super.key, required this.emp});

  final EmployeeModel emp;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(
          context,
        ).pushNamed(RouterKeys.employeeDetailsScreen, arguments: emp);
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 15.0),
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          child: Column(
            spacing: 10.0,
            children: [
              SizedBox(
                width: 200.0.w,
                height: 200.h,
                child: ProfilePicture(imagePath: emp.imagePath),
              ),
              Text(
                '${emp.firstName} ${emp.lastName}',
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium!.copyWith(fontSize: 20.sp),
              ),
              Text(
                emp.job,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium!.copyWith(fontSize: 20.sp),
              ),
              RichText(
                text: TextSpan(
                  text: '${'Working hours'.tr(context)}: ',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium!.copyWith(fontSize: 13.sp),
                  children: [
                    TextSpan(
                      text: '${emp.workHours}',
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium!.copyWith(fontSize: 13.sp),
                    ),
                  ],
                ),
              ),
              RichText(
                text: TextSpan(
                  text: '${'Working days'.tr(context)}: ',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium!.copyWith(fontSize: 13.sp),
                  children: [
                    TextSpan(
                      text: emp.workingDays,
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium!.copyWith(fontSize: 13.sp),
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
}

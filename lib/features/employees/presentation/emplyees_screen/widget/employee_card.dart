import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hr/core/assets/app_images.dart';
import 'package:hr/core/theme/app_colors.dart';
import 'package:hr/features/employees/data/model/employee_model.dart';

class EmployeeCard extends StatelessWidget {
  const EmployeeCard({super.key, required this.emp});

  final EmployeeModel emp;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        color: AppColors.gray2,
        child: Column(
          spacing: 10.0,
          children: [
            SizedBox(
              width: 200.0.w,
              height: 200.h,
              child: SvgPicture.asset(AppImages.profile),
            ),
            Text(
              '${emp.firstName} ${emp.lastName}',
              style: GoogleFonts.cairo(
                fontSize: 20.0.sp,
                color: AppColors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              emp.job,
              style: GoogleFonts.cairo(
                fontSize: 20.0.sp,
                color: AppColors.gray,
                fontWeight: FontWeight.w500,
              ),
            ),
            RichText(
              text: TextSpan(
                text: 'Working hours: ',
                style: GoogleFonts.cairo(
                  fontSize: 13.0.sp,
                  color: AppColors.gray,
                  fontWeight: FontWeight.w500,
                ),
                children: [
                  TextSpan(
                    text: '${emp.workHours}',
                    style: GoogleFonts.cairo(
                      fontSize: 13.0.sp,
                      color: AppColors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            RichText(
              text: TextSpan(
                text: 'Working days: ',
                style: GoogleFonts.cairo(
                  fontSize: 13.0.sp,
                  color: AppColors.gray,
                  fontWeight: FontWeight.w500,
                ),
                children: [
                  TextSpan(
                    text: emp.workingDays,
                    style: GoogleFonts.cairo(
                      fontSize: 13.0.sp,
                      color: AppColors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

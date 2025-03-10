import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hr/core/assets/app_icons.dart';
import 'package:hr/core/theme/app_colors.dart';
import 'package:hr/core/theme/app_theme.dart';

class VacationItem extends StatelessWidget {
  const VacationItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0.w, vertical: 10.0.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border.all(color: AppColors.black, width: 0.5),
        borderRadius: BorderRadius.circular(AppTheme.appRadius),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                fit: FlexFit.loose,
                child: Row(
                  spacing: 10.0.w,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 24.w,
                      height: 24.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(1.0.r),
                        color: AppColors.gray,
                      ),
                      child: SvgPicture.asset(AppIcons.xIc),
                    ),
                    SizedBox(
                      width: 32.w,
                      height: 32.h,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(200.r),
                        child: Image.file(
                          File('D:\\WallPaper\\blue skyline.jpg'),
                        ),
                      ),
                    ),
                    Text(
                      'Reminder message!',
                      style: TextStyle(
                        color: AppColors.secondaryColor,
                        fontSize: 18.0.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                'The employee Ahmed Hassan will end his vacation today, please him as reminder',
              ),
            ],
          ),
          Spacer(),
          Text(
            '24/6/2025 at 5:30',
            style: TextStyle(
              color: AppColors.gray,
              fontSize: 13.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}

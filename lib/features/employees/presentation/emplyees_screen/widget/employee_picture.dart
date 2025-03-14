import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hr/core/assets/app_images.dart';
import 'package:hr/core/theme/app_colors.dart';
import 'package:hr/core/theme/app_theme.dart';
import 'package:hr/core/widgets/svg_provider/svg_image_provider.dart';

class EmployeePicture extends StatelessWidget {
  const EmployeePicture({super.key, required this.picturePath});

  final String picturePath;

  @override
  Widget build(BuildContext context) {
    log('EmployeePicture: picturePath: $picturePath');
    return Container(
      width: 200.0.w,
      height: 200.0.h,
      margin: EdgeInsets.only(top: 20.0.h),
      decoration: BoxDecoration(
        color: AppColors.gray3,
        borderRadius: BorderRadius.circular(AppTheme.appRadius),
        image: DecorationImage(
          colorFilter: ColorFilter.mode(AppColors.gray3, BlendMode.dst),
          fit: picturePath.isNotEmpty ? BoxFit.contain : null,
          image:
              picturePath.isEmpty
                  ? SvgAssetPicture(
                    SvgPicture.asset(AppImages.profilePlaceholder),
                    width: 80,
                    height: 80,
                  )
                  : FileImage(File(picturePath)),
        ),
      ),
    );
  }
}

//AssetImage(AppImages.profilePlaceholder)

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hr/core/assets/app_images.dart';

class ProfilePicture extends StatelessWidget {
  const ProfilePicture({
    super.key,
    this.width = 100,
    this.height = 100,
    required this.imagePath,
  });

  final double width;
  final double height;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return imagePath.isEmpty
        ? CircleAvatar(radius: 50.0, child: SvgPicture.asset(AppImages.profile))
        : Container(
          width: width.w,
          height: height.h,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: FileImage(File(imagePath)),
              fit: BoxFit.cover,
            ),
          ),
        );
  }
}

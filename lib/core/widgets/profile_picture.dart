import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hr/core/assets/app_images.dart';

class ProfilePicture extends StatelessWidget {
  const ProfilePicture({super.key, required this.imagePath});

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return imagePath.isEmpty
        ? CircleAvatar(radius: 50.0, child: SvgPicture.asset(AppImages.profile))
        : Container(
          width: 100.0,
          height: 100.0,
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

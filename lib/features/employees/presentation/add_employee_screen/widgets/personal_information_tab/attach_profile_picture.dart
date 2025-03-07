import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hr/core/assets/app_images.dart';
import 'package:hr/core/theme/app_colors.dart';

class AttachProfilePicture extends StatelessWidget {
  const AttachProfilePicture({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(radius: 50.0, child: SvgPicture.asset(AppImages.profile)),
        const SizedBox(width: 10),
        CircleAvatar(
          radius: 20,
          backgroundColor: AppColors.secondaryColor,
          child: Icon(Icons.mode_edit_outline_outlined, color: Colors.white),
        ),
      ],
    );
  }
}

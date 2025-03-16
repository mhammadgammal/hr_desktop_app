import 'package:flutter/material.dart';
import 'package:hr/core/theme/app_colors.dart';
import 'package:hr/core/widgets/profile_picture.dart';
import 'package:hr/features/settings/cubit/settings_cubit.dart';

class ProfilePictureWithPicker extends StatelessWidget {
  const ProfilePictureWithPicker({super.key, required this.width, required this.height});

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    var cubit = SettingsCubit.get(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProfilePicture(imagePath: cubit.profilePicPath, width: width, height: height,),
        const SizedBox(width: 10),
        GestureDetector(
          onTap: () => cubit.pickProfilePic(),
          child: CircleAvatar(
            radius: 20,
            backgroundColor: AppColors.secondaryColor,
            child: Icon(Icons.mode_edit_outline_outlined, color: Colors.white),
          ),
        ),
      ],
    );
  }
}

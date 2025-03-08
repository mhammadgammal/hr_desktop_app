import 'package:flutter/material.dart';
import 'package:hr/core/theme/app_colors.dart';
import 'package:hr/core/widgets/profile_picture.dart';
import 'package:hr/features/employees/presentation/add_employee_screen/cubit/add_employee_cubit.dart';

class AttachProfilePicture extends StatelessWidget {
  const AttachProfilePicture({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = AddEmployeeCubit.get(context);
    return Row(
      // mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProfilePicture(imagePath: cubit.profilePicPath,),
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

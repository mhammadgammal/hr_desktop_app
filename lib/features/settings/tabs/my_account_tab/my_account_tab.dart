import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hr/core/extensions/extensions.dart';
import 'package:hr/core/widgets/buttons/custom_filled_button.dart';
import 'package:hr/core/widgets/text_form_field/password_text_form_field.dart';
import 'package:hr/features/settings/cubit/settings_cubit.dart';
import 'package:hr/features/settings/tabs/my_account_tab/profile_picture_with_picker.dart';

class MyAccountTab extends StatelessWidget {
  const MyAccountTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        var cubit = SettingsCubit.get(context);
        return cubit.user == null
            ? CircularProgressIndicator()
            : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  ProfilePictureWithPicker(),
                  PasswordTextFormField(
                    label: 'Current password'.tr(context),
                    controller: cubit.currentPasswordController,
                  ),
                  PasswordTextFormField(
                    label: 'New password'.tr(context),
                    controller: cubit.newPasswordController,
                  ),
                  PasswordTextFormField(
                    label: 'Confirm password'.tr(context),
                    controller: cubit.confirmPasswordController,
                  ),
                  SizedBox(height: 10.0.h),
                  CustomFilledButton(
                    title: 'Confirm changes'.tr(context),
                    onPressed: () {
                      if (cubit.currentPasswordController.text.isNotEmpty) {
                        cubit.updatePassword();
                      } else if (cubit.profilePicPath !=
                          cubit.user?.profilePicturePath) {
                        cubit.updateProfilePic();
                      }
                    },
                  ),
                ],
              ),
            );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr/core/extensions/extensions.dart';
import 'package:hr/core/widgets/buttons/custom_filled_button.dart';
import 'package:hr/core/widgets/text_form_field/columned_text_form_field.dart';
import 'package:hr/features/settings/cubit/settings_cubit.dart';
import 'package:hr/features/settings/tabs/my_account_tab/profile_picture_with_picker.dart';

class MyAccountTab extends StatelessWidget {
  const MyAccountTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        var cubit = SettingsCubit.get(context);
        return Column(
          children: [
            ProfilePictureWithPicker(),
            ColumnedTextFormField(
              title: 'Current password'.tr(context),
              controller: cubit.currentPasswordController,
              inputType: TextInputType.visiblePassword,
            ),
            ColumnedTextFormField(
              title: 'New password'.tr(context),
              controller: cubit.newPasswordController,
              inputType: TextInputType.visiblePassword,
            ),
            ColumnedTextFormField(
              title: 'Confirm password'.tr(context),
              controller: cubit.confirmPasswordController,
              inputType: TextInputType.visiblePassword,
            ),
            CustomFilledButton(
              title: 'Confirm changes'.tr(context),
              onPressed: () {},
            ),
          ],
        );
      },
    );
  }
}

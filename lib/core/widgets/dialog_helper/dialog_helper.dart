import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hr/core/app/cubit/app_cubit.dart';
import 'package:hr/core/assets/app_icons.dart';
import 'package:hr/core/extensions/extensions.dart';
import 'package:hr/core/theme/app_colors.dart';
import 'package:hr/core/theme/app_theme.dart';
import 'package:hr/core/widgets/buttons/custom_filled_button.dart';
import 'package:hr/core/widgets/buttons/custom_outlined_button_with_border.dart';

abstract class DialogHelper {
  static void showFailureDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            icon: SvgPicture.asset(AppIcons.failureIc),
            title: const Text('Error'),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK'),
              ),
            ],
          ),
    );
  }

  static void showSuccessDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            icon: SvgPicture.asset(AppIcons.successIc),
            title: const Text('Success'),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK'),
              ),
            ],
          ),
    );
  }

  static void deleteDialog(context,
      void Function() onYes,
      void Function() onCancel,) {
    showDialog(
      context: context,
      builder:
          (context) =>
          Container(
            decoration: BoxDecoration(
              color:
              AppCubit
                  .get(context)
                  .isDarkMode
                  ? AppColors.gray2
                  : AppColors.white,
              borderRadius: BorderRadius.circular(AppTheme.appRadius),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 43.w,
                  height: 43.w,
                  child: SvgPicture.asset(AppIcons.failureIc),
                ),
                Text('Are you sure you want to delete employee'.tr(context)),
                Text(
                    'If you delete you won\'t restore data, and you will add data manually'
                        .tr(context)),
                Row(
                  children: [
                    Expanded(child: CustomFilledButton(
                        title: 'Delete'.tr(context),
                        fillColor: AppColors.failure,
                        onPressed: onYes)),
                    Expanded(child: CustomOutlinedButtonWithBorder(
                        title: 'Cancel'.tr(context), onPressed: onCancel)),
                  ],
                )
              ],
            ),
          ),
    );
  }
}

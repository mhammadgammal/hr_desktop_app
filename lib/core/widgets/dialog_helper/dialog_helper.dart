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

  static void showSuccessDialog({
    required BuildContext context,
    String header = 'Success',
    String message = '',
  }) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            backgroundColor: AppColors.white,
            icon: SvgPicture.asset(AppIcons.successIc),
            title: Text(
              header.tr(context),
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: AppColors.black,
                fontSize: 20.0.sp,
              ),
            ),
            content: Text(
              message,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: AppColors.black,
                fontSize: 15.0.sp,
              ),
            ),
            actions: [
              CustomFilledButton(
                height: 50.0.h,
                onPressed: () => Navigator.of(context).pop(),
                title: 'OK'.tr(context),
              ),
            ],
          ),
    );
  }

  static void deleteDialog(
    context,
    void Function() onYes,
    void Function() onCancel,
  ) {
    showDialog(
      context: context,
      builder:
          (context) => Dialog(
            child: Container(
              width: 600.0.w,
              height: 200.0.h,
              padding: EdgeInsets.all(20.0.w),
              decoration: BoxDecoration(
                color:
                    AppCubit.get(context).isDarkMode
                        ? AppColors.gray2
                        : AppColors.white,
                borderRadius: BorderRadius.circular(AppTheme.appRadius),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 43.w,
                    height: 43.w,
                    child: SvgPicture.asset(AppIcons.failureIc),
                  ),
                  Text(
                    'Are you sure you want to delete employee'.tr(context),
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium!.copyWith(fontSize: 24.sp),
                  ),
                  Text(
                    'If you delete you won\'t restore data, and you will add data manually'
                        .tr(context),
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium!.copyWith(fontSize: 18.sp),
                  ),
                  Row(
                    spacing: 10.0.w,
                    children: [
                      Expanded(
                        child: CustomFilledButton(
                          title: 'Delete'.tr(context),
                          fillColor: AppColors.failure,
                          onPressed: onYes,
                        ),
                      ),

                      Expanded(
                        child: CustomOutlinedButtonWithBorder(
                          title: 'Cancel'.tr(context),
                          onPressed: onCancel,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hr/core/app/cubit/app_cubit.dart';
import 'package:hr/core/extensions/extensions.dart';
import 'package:hr/core/theme/app_colors.dart';
import 'package:hr/core/utils/localization/localize_constants.dart';

class AppSettingsTab extends StatelessWidget {
  const AppSettingsTab({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = AppCubit.get(context);
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Dark Mode'.tr(context),
                  style: GoogleFonts.cairo(
                    color: AppColors.white,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(width: 10.0.w),
                Switch(value: cubit.isDarkMode, onChanged: cubit.changeTheme),
              ],
            ),
            Row(
              children: [
                Text(
                  'Language'.tr(context),
                  style: GoogleFonts.cairo(
                    color: AppColors.white,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(width: 10.0.w),
                DropdownButton(
                  value: cubit.locale,
                  onChanged: cubit.changeLanguage,
                  items:
                      LocalizeConstants.supportedLocales
                          .map(
                            (e) => DropdownMenuItem(
                              value: e,
                              child: Text(
                                e.languageCode,
                                style: GoogleFonts.cairo(
                                  color: AppColors.white,
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

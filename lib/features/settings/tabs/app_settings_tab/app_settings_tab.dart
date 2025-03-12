import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hr/core/app/cubit/app_cubit.dart';
import 'package:hr/core/extensions/extensions.dart';
import 'package:hr/core/theme/app_colors.dart';
import 'package:hr/core/theme/app_theme.dart';
import 'package:hr/core/utils/localization/localize_constants.dart';

class AppSettingsTab extends StatelessWidget {
  const AppSettingsTab({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = AppCubit.get(context);
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Dark Mode'.tr(context),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                SizedBox(width: 10.0.w),
                Switch(value: cubit.isDarkMode, onChanged: cubit.changeTheme),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Language'.tr(context),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                SizedBox(width: 10.0.w),
                SizedBox(
                  width: 200.0.w,
                  child: DropdownButtonFormField<Locale>(
                    value: cubit.locale,
                    hint: Text('Identity or residence'.tr(context)),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppTheme.appRadius),
                        borderSide: BorderSide(
                          width: 2.w,
                          color: AppColors.black,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppTheme.appRadius),
                        borderSide: BorderSide(
                          width: 2.w,
                          color:
                              AppColors.black, // Change focus border color here
                        ),
                      ),
                    ),
                    dropdownColor:
                        AppCubit.get(context).isDarkMode
                            ? AppColors.gray
                            : AppColors.white,
                    focusColor: AppColors.secondaryColor,
                    items:
                        LocalizeConstants.supportedLocales
                            .map(
                              (e) => DropdownMenuItem(
                                value: e,
                                child: Text(
                                  e.languageCode,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ),
                            )
                            .toList(),
                    onChanged: cubit.changeLanguage,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

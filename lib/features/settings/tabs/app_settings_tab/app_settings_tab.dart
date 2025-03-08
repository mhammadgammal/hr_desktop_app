import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hr/core/app/cubit/app_cubit.dart';
import 'package:hr/core/extensions/extensions.dart';
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
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                SizedBox(width: 10.0.w),
                Switch(value: cubit.isDarkMode, onChanged: cubit.changeTheme),
              ],
            ),
            Row(
              children: [
                Text(
                  'Language'.tr(context),
                  style: Theme.of(context).textTheme.bodyMedium,
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
                                style: Theme.of(context).textTheme.bodyMedium,
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

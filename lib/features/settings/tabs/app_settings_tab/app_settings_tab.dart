import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hr/core/app/cubit/app_cubit.dart';
import 'package:hr/core/extensions/extensions.dart';
import 'package:hr/core/theme/app_colors.dart';

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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Dark Mode'.tr(context),
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      'Dark Mode'.tr(context),
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium!.copyWith(fontSize: 16.sp),
                    ),
                    SizedBox(width: 10.0.w),
                    Switch(
                      value: cubit.isDarkMode,
                      onChanged: cubit.changeTheme,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 10.0.h),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Language'.tr(context),
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 20.0.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(width: 10.0.h),
                Flexible(
                  fit: FlexFit.loose,
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: cubit.supportedLanguages.length,
                    shrinkWrap: true,
                    itemBuilder:
                        (context, index) => RadioListTile(
                          title: Text(
                            cubit.supportedLanguages[index].$2,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          value: cubit.supportedLanguages[index].$1,
                          activeColor: AppColors.secondaryColor,
                          groupValue: cubit.selectedLanguage,
                          onChanged: cubit.onLanguageChanged,
                        ),
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

//DropdownButtonFormField<Locale>(
//                     value: cubit.locale,
//                     hint: Text('Identity or residence'.tr(context)),
//                     decoration: InputDecoration(
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(AppTheme.appRadius),
//                         borderSide: BorderSide(
//                           width: 2.w,
//                           color: AppColors.black,
//                         ),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(AppTheme.appRadius),
//                         borderSide: BorderSide(
//                           width: 2.w,
//                           color:
//                               AppColors.black, // Change focus border color here
//                         ),
//                       ),
//                     ),
//                     dropdownColor:
//                         AppCubit.get(context).isDarkMode
//                             ? AppColors.gray
//                             : AppColors.white,
//                     focusColor: AppColors.secondaryColor,
//                     items:
//                         LocalizeConstants.supportedLocales
//                             .map(
//                               (e) => DropdownMenuItem(
//                                 value: e,
//                                 child: Text(
//                                   e.languageCode,
//                                   style: Theme.of(context).textTheme.bodyMedium,
//                                 ),
//                               ),
//                             )
//                             .toList(),
//                     onChanged: cubit.changeLanguage,
//                   ),

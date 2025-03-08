import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hr/core/extensions/extensions.dart';
import 'package:hr/core/theme/app_colors.dart';
import 'package:hr/features/settings/cubit/settings_cubit.dart';
import 'package:hr/features/settings/tabs/my_account_tab/my_account_tab.dart';

import 'tabs/app_settings_tab/app_settings_tab.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tabsNames = <String>['My Account', 'App Settings'];
    return BlocProvider(
      create: (context) => SettingsCubit(),
      child: BlocConsumer<SettingsCubit, SettingsState>(
        listener: (context, state) {},
        builder: (context, state) {
          final cubit = SettingsCubit.get(context);
          return Column(
            children: [
              _screenHeader(context),
              Row(
                children: [
                  Container(
                    width: 231.w,
                    height: 200.h,
                    color: AppColors.gray2,
                    margin: EdgeInsetsDirectional.only(top: 20.0.w),
                    child: ListView.builder(
                      padding: EdgeInsetsDirectional.only(start: 10.0.w),
                      itemCount: tabsNames.length,
                      itemBuilder:
                          (context, index) => ListTile(
                            onTap: () => cubit.changeTab(index),
                            selected: cubit.selectedTabIndex == index,
                            title: Text(
                              tabsNames[index].tr(context),
                              style: GoogleFonts.cairo(
                                color:
                                    cubit.selectedTabIndex == index
                                        ? AppColors.secondaryColor
                                        : AppColors.white,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            contentPadding: EdgeInsets.zero,
                          ),
                    ),
                  ),
                  Container(
                    width: 828.w,
                    height: 764.h,
                    color: AppColors.gray2,
                    padding: EdgeInsetsDirectional.only(
                      start: 20.0.w,
                      top: 20.0.w,
                    ),
                    margin: EdgeInsetsDirectional.only(
                      start: 20.0.w,
                      top: 20.0.w,
                    ),
                    child: Column(
                      children: [
                        _switchTabItem(context, cubit.selectedTabIndex),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  _screenHeader(context) => Text('App Settings'.tr(context));

  _switchTabItem(BuildContext context, int selectedTabIndex) {
    switch (selectedTabIndex) {
      case 0:
        return MyAccountTab();
      case 1:
        return AppSettingsTab();
    }
  }
}

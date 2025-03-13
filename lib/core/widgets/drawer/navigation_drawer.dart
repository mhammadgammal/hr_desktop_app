import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hr/core/assets/app_icons.dart';
import 'package:hr/core/assets/app_images.dart';
import 'package:hr/core/di/di.dart';
import 'package:hr/core/extensions/extensions.dart';
import 'package:hr/core/helpers/cache/cache_keys.dart';
import 'package:hr/core/helpers/cache/shared_preferences/cache_helper.dart';
import 'package:hr/core/router/router_keys.dart';
import 'package:hr/core/theme/app_colors.dart';
import 'package:hr/core/widgets/drawer/cubit/navigation_drawer_cubit.dart';
import 'package:hr/core/widgets/drawer/entity/navigation_drawer_entity_item.dart';
import 'package:hr/core/widgets/drawer/widgets/navigation_bar_item.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationDrawerCubit, NavigationDrawerState>(
      builder: (context, state) {
        var cubit = NavigationDrawerCubit.get(context);
        return SizedBox(
          width: 245.w,
          height: MediaQuery.sizeOf(context).height,
          child: Drawer(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
            backgroundColor: AppColors.secondaryColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                HeaderSection(),
                Expanded(
                  child: ListView.builder(
                    itemCount: 4,
                    itemBuilder:
                        (context, index) => NavigationBarItem(
                          item: NavigationDrawerEntityItem(
                            title: cubit.screens[index].title.tr(context),
                            iconPath: cubit.screens[index].iconPath,
                            selectedIconPath:
                                cubit.screens[index].selectedIconPath,
                            onTap: () {
                              cubit.onItemTapped(index);
                              cubit.screens[index].onTap();
                            },
                          ),
                          isSelected: index == state.index,
                        ),
                  ),
                ),
                Divider(color: AppColors.gray, thickness: 0.5),
                NavigationBarItem(
                  item: NavigationDrawerEntityItem(
                    title: 'Sign out'.tr(context),
                    iconPath: AppIcons.logoutIc,
                    selectedIconPath: '',
                    onTap: () {
                      sl<CacheHelper>().putBool(CacheKeys.isLogged, false);
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        RouterKeys.home,
                        (route) => false,
                      );
                    },
                  ),
                  isSelected: false,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 56.w,
            height: 56.h,
            child: SvgPicture.asset(AppImages.logo, color: AppColors.white),
          ),
          Text(
            'Quick Access',
            style: GoogleFonts.cairo(
              color: AppColors.white,
              fontSize: 24.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

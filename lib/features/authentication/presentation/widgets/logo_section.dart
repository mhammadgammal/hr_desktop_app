import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hr/core/app/cubit/app_cubit.dart';
import 'package:hr/core/assets/app_images.dart';
import 'package:hr/core/theme/app_colors.dart';

class LogoSection extends StatelessWidget {
  const LogoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(AppImages.logo),
        SizedBox(height: 10.h),
        RichText(
          text: TextSpan(
            text: 'HR',
            style: GoogleFonts.kaushanScript(
              color: AppColors.secondaryColor,
              fontSize: 48.sp,
              fontWeight: FontWeight.w500,
            ),
            children: [
              TextSpan(
                text: ' infinity',
                style: GoogleFonts.kantumruyPro(
                  color:
                      AppCubit.get(context).isDarkMode
                          ? AppColors.white
                          : AppColors.black,
                  fontSize: 48.sp,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

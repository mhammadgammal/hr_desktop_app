import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hr/core/theme/app_colors.dart';
import 'package:hr/core/theme/app_theme.dart';

class CustomFilledButton extends StatelessWidget {
  const CustomFilledButton({
    super.key,
    this.width,
    this.height,
    required this.title,
    required this.onPressed,
    this.disabled = false,
    this.fillColor,
  });

  final double? width;
  final double? height;
  final String title;
  final void Function() onPressed;
  final bool disabled;
  final Color? fillColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height ?? 50.h,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(
            disabled ? AppColors.gray : fillColor ?? AppColors.secondaryColor,
          ),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppTheme.appRadius),
            ),
          ),
        ),
        child: Text(
          title,
          style: GoogleFonts.cairo(color: Colors.white, fontSize: 16.sp),
        ),
      ),
    );
  }
}

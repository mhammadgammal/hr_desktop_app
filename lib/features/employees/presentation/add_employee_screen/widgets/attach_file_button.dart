import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hr/core/assets/app_icons.dart';
import 'package:hr/core/extensions/extensions.dart';
import 'package:hr/core/theme/app_colors.dart';
import 'package:hr/core/widgets/buttons/custom_outlined_button_with_border.dart';

class AttachFileButton extends StatelessWidget {
  const AttachFileButton({
    super.key,
    this.width,
    this.height,
    required this.title,
    required this.pickCallback,
    this.fontSize = 14,
    this.fontWeight = FontWeight.normal,
  });

  final double? width;
  final double? height;
  final String title;
  final void Function() pickCallback;
  final double fontSize;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return CustomOutlinedButtonWithBorder(
      width: (width ?? 250.0).w,
      height: (height ?? 50.0).h,
      onPressed: pickCallback,
      title: title.tr(context),
      fontSize: fontSize,
      fontWeight: fontWeight,
      titleColor: AppColors.secondaryColor,
      icon: SvgPicture.asset(AppIcons.downloadIc),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hr/core/theme/app_colors.dart';
import 'package:hr/core/widgets/buttons/custom_outlined_button_with_border.dart';

class AddEmployeeScreen extends StatelessWidget {
  const AddEmployeeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final style = GoogleFonts.cairo(
      color: AppColors.white,
      fontSize: 20.sp,
      fontWeight: FontWeight.w500,
    );
    return Column(
      children: [
        _screenHeader(context),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 231.w,
              height: 224.h,
              color: AppColors.gray2,
              child: ListView(
                children: [
                  Text('Personal Information', style: style),
                  Text('Salary Details', style: style),
                  Text('Contract Details', style: style),
                  Text('Day off request\'s', style: style),
                ],
              ),
            ),
            Card(),
          ],
        ),
      ],
    );
  }

  _screenHeader(BuildContext context) => Row(
    children: [
      Text(
        'Personal Information',
        style: GoogleFonts.cairo(
          color: AppColors.white,
          fontSize: 32.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
      Spacer(),
      CustomOutlinedButtonWithBorder(onPressed: () {}, title: 'Delete file'),
    ],
  );
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hr/core/app/cubit/app_cubit.dart';
import 'package:hr/core/extensions/extensions.dart';
import 'package:hr/core/theme/app_colors.dart';
import 'package:hr/features/employees/presentation/add_employee_screen/cubit/add_employee_cubit.dart';
import 'package:hr/features/employees/presentation/add_employee_screen/widgets/personal_information_tab/first_page_personal_information_tab.dart';
import 'package:hr/features/employees/presentation/add_employee_screen/widgets/personal_information_tab/second_page_personal_information_tab.dart';

class PersonalInformationTab extends StatelessWidget {
  const PersonalInformationTab({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = AddEmployeeCubit.get(context);
    return Expanded(
      child: Column(
        crossAxisAlignment:
            cubit.firstPagePersonalTab
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Placeholder(),
          cubit.firstPagePersonalTab
              ? FirstPagePersonalInformationTab()
              : SecondPagePersonalInformationTab(),
          Spacer(),
          TextButton.icon(
            onPressed: () {
              cubit.togglePersonalModeTabs();
            },
            style: ButtonStyle(
              overlayColor: WidgetStateProperty.resolveWith<Color>(
                (states) => Colors.transparent,
              ),
            ),
            label: Text(
              cubit.firstPagePersonalTab
                  ? 'Next'.tr(context)
                  : 'Back'.tr(context),
              style: TextStyle(
                color: AppColors.secondaryColor,
                fontSize: 20.0.sp,
              ),
            ),
            iconAlignment:
                cubit.firstPagePersonalTab
                    ? IconAlignment.end
                    : IconAlignment.start,
            icon: Icon(
              AppCubit.get(context).locale.languageCode == 'en'
                  ? Icons.arrow_forward_rounded
                  : Icons.arrow_back_rounded,
              textDirection:
                  cubit.firstPagePersonalTab
                      ? TextDirection.ltr
                      : TextDirection.rtl,
              size: 30.0,
              color: AppColors.secondaryColor,
            ),
          ),
        ],
      ),
    );
  }
}

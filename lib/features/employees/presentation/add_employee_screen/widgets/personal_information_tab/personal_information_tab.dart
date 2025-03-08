import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hr/core/extensions/extensions.dart';
import 'package:hr/core/theme/app_colors.dart';
import 'package:hr/features/employees/presentation/add_employee_screen/cubit/add_employee_cubit.dart';
import 'package:hr/features/employees/presentation/add_employee_screen/widgets/personal_information_tab/birthdate_and_phone_fields.dart';
import 'package:hr/features/employees/presentation/add_employee_screen/widgets/personal_information_tab/email_and_job_description_fields.dart';
import 'package:hr/features/employees/presentation/add_employee_screen/widgets/personal_information_tab/first_last_name_fields.dart';
import 'package:hr/features/employees/presentation/add_employee_screen/widgets/personal_information_tab/working_hours_and_days_fields.dart';

class PersonalInformationTab extends StatelessWidget {
  const PersonalInformationTab({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = AddEmployeeCubit.get(context);
    return Flexible(
      fit: FlexFit.loose,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        spacing: 30.0.h,
        children: [
          FirstLastNameFields(
            firstNameController: cubit.firstNameController,
            lastNameController: cubit.lastNameController,
          ),
          EmailAndJobDescriptionFields(),
          BirthdateAndPhoneFields(),
          WorkingHoursAndDaysFields(),
          Spacer(),
          TextButton.icon(
            onPressed: () {
              cubit.nextTab();
            },
            label: Text(
              'Next'.tr(context),
              style: TextStyle(
                color: AppColors.secondaryColor,
                fontSize: 20.0.sp,
              ),
            ),
            iconAlignment: IconAlignment.end,
            icon: Icon(
              Icons.arrow_forward_rounded,
              size: 33.0,
              color: AppColors.secondaryColor,
            ),
          ),
        ],
      ),
    );
  }
}

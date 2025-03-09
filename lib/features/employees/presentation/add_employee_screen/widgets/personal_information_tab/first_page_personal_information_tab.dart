import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hr/features/employees/presentation/add_employee_screen/cubit/add_employee_cubit.dart';
import 'package:hr/features/employees/presentation/add_employee_screen/widgets/personal_information_tab/birthdate_and_phone_fields.dart';
import 'package:hr/features/employees/presentation/add_employee_screen/widgets/personal_information_tab/email_and_job_description_fields.dart';
import 'package:hr/features/employees/presentation/add_employee_screen/widgets/personal_information_tab/first_last_name_fields.dart';
import 'package:hr/features/employees/presentation/add_employee_screen/widgets/personal_information_tab/working_hours_and_days_fields.dart';

class FirstPagePersonalInformationTab extends StatelessWidget {
  const FirstPagePersonalInformationTab({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = AddEmployeeCubit.get(context);

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
        ],
      ),
    );
  }
}

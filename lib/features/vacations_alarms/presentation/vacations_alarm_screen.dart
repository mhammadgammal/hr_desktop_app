import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hr/features/vacations_alarms/presentation/widgets/vacation_item.dart';

class VacationsAlarmScreen extends StatelessWidget {
  const VacationsAlarmScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: ListView.separated(
            itemCount: 5,
            padding: EdgeInsetsDirectional.only(top: 10.0.h, end: 10.0.w),
            itemBuilder: (context, index) => VacationItem(),
            separatorBuilder: (context, index) => SizedBox(height: 10.0.h),
          ),
        ),
      ],
    );
  }
}

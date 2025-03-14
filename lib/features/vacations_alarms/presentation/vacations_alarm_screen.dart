import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hr/features/vacations_alarms/presentation/cubit/vacation_cubit.dart';
import 'package:hr/features/vacations_alarms/presentation/widgets/vacation_item.dart';

class VacationsAlarmScreen extends StatelessWidget {
  const VacationsAlarmScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => VacationCubit()..getFinishedVacation(),
      child: BlocConsumer<VacationCubit, VacationState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = VacationCubit.get(context);
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              state is GetFinishedVacationLoadingState
                  ? CircularProgressIndicator()
                  : state is GetFinishedVacationSuccessState &&
                      cubit.vacations!.isEmpty
                  ? Center(
                    child: Text(
                      'No finished vacations',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 20.0.sp,
                      ),
                    ),
                  )
                  : Flexible(
                    child: ListView.separated(
                      itemCount: cubit.vacations!.length,
                      padding: EdgeInsetsDirectional.only(
                        top: 10.0.h,
                        end: 10.0.w,
                      ),
                      itemBuilder:
                          (context, index) =>
                              VacationItem(vacation: cubit.vacations![index]),
                      separatorBuilder:
                          (context, index) => SizedBox(height: 10.0.h),
                    ),
                  ),
            ],
          );
        },
      ),
    );
  }
}

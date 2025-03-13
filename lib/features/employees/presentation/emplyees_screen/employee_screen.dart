import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hr/core/theme/app_colors.dart';
import 'package:hr/features/employees/presentation/emplyees_screen/cubit/employees_cubit.dart';
import 'package:hr/features/employees/presentation/emplyees_screen/widget/employee_card.dart'
    show EmployeeCard;

class EmployeeScreen extends StatelessWidget {
  const EmployeeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EmployeesCubit()..getAllEmployees(),
      child: BlocBuilder<EmployeesCubit, EmployeesState>(
        builder: (context, state) {
          var cubit = context.read<EmployeesCubit>();
          return state is GetAllEmployeesLoadingState || cubit.employees == null
              ? Center(
                child: CircularProgressIndicator(
                  color: AppColors.secondaryColor,
                ),
              )
              : state is GetAllEmployeesSuccessState && cubit.employees!.isEmpty
              ? Center(
                child: Text(
                  'There\'s no employees yet',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium!.copyWith(fontSize: 20.0.sp),
                ),
              )
              : GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  childAspectRatio:
                      (ScreenUtil().screenWidth / 4) /
                      (ScreenUtil().screenHeight / 1.8),
                ),
                itemCount: cubit.employees!.length,
                padding: EdgeInsetsDirectional.only(end: 10.0.w),
                itemBuilder:
                    (context, index) =>
                        EmployeeCard(emp: cubit.employees![index]),
              );
        },
      ),
    );
  }
}

import 'dart:developer';

import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr/core/di/di.dart';
import 'package:hr/core/helpers/database/table_name.dart';
import 'package:hr/features/vacations_alarms/data/vacation_model.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

part 'vacation_state.dart';

class VacationCubit extends Cubit<VacationState> {
  VacationCubit() : super(VacationInitial());

  static VacationCubit get(BuildContext context) => BlocProvider.of(context);

  List<VacationModel>? vacations;

  Future<void> getFinishedVacation() async {
    emit(GetFinishedVacationLoadingState());
    DateTime today = DateTime.now();
    String todayStr = DateTime.now().toIso8601String().substring(
      0,
      10,
    ); // 'YYYY-MM-DD'
    // vacations = await DbHelper.getDataWhere(
    //   TableName.vacationTable,
    //   VacationModel.fromJson,
    //   where: 'end_date <= ?',
    //   whereArgs: ["2025-03-13"],
    // );
    final rawVacation = await sl<Database>().rawQuery("""
        SELECT ${TableName.employeeTable}.first_name, ${TableName.employeeTable}.last_name, ${TableName.employeeTable}.image_path, ${TableName.vacationTable}.*
    FROM ${TableName.employeeTable} AS employees
    JOIN ${TableName.vacationTable}
    ON employees.id = ${TableName.vacationTable}.emp_id
    where end_date <= "2025-03-13"
    """);
    for (final vac in rawVacation) {
      log('VacationCubit: getFinishedVacation: vac key: $vac');
    }

    vacations = List.generate(
      rawVacation.length,
      (index) => VacationModel.fromJson(rawVacation[index]),
    );
    emit(GetFinishedVacationSuccessState());
  }
}

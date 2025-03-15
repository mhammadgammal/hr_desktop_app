import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr/core/helpers/database/db_helper.dart';
import 'package:hr/core/helpers/database/table_name.dart';
import 'package:hr/features/employees/data/model/employee_model.dart';

part 'employees_state.dart';

class EmployeesCubit extends Cubit<EmployeesState> {
  EmployeesCubit() : super(EmployeesInitial());

  List<EmployeeModel>? employees;

  static EmployeesCubit get(context) => BlocProvider.of(context);

  Future<void> getAllEmployees() async {
    emit(GetAllEmployeesLoadingState());
    var emps = await DbHelper.getAll(TableName.employeeTable);
    employees = List.generate(
      emps.length,
      (index) => EmployeeModel.fromJson(emps[index]),
    );
    emit(GetAllEmployeesSuccessState());
  }

  Future<void> searchEmployees({
    String? nameOrJob,
    String? name,
    String? job,
    String? workingHours,
    String? workingDays,
    String? identityNumber,
  }) async {
    emit(GetAllEmployeesLoadingState());

    var filteredEmps = await DbHelper.searchRecords(
      TableName.employeeTable,
      nameOrJobSearch: nameOrJob,
      name: name,
      job: job,
      workingDays: workingDays,
      workingHours: workingHours,
      identityNumber: identityNumber,
    );
    employees = List.generate(
      filteredEmps.length,
      (index) => EmployeeModel.fromJson(filteredEmps[index]),
    );
    emit(GetAllEmployeesSuccessState());
  }
}

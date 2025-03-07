import 'package:bloc/bloc.dart';
import 'package:hr/core/helpers/database/db_helper.dart';
import 'package:hr/core/helpers/database/table_name.dart';
import 'package:hr/features/employees/data/model/employee_model.dart';
import 'package:meta/meta.dart';

part 'employees_state.dart';

class EmployeesCubit extends Cubit<EmployeesState> {
  EmployeesCubit() : super(EmployeesInitial());

  List<EmployeeModel>? employees;

  Future<void> getAllEmployees() async {
    emit(GetAllEmployeesLoadingState());
    var emps = await DbHelper.getAll(TableName.employeeTable);
    employees = List.generate(
      emps.length,
      (index) => EmployeeModel.fromJson(emps[index]),
    );
    emit(GetAllEmployeesSuccessState());
  }
}

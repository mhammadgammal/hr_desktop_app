import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr/core/helpers/database/db_helper.dart';
import 'package:hr/core/helpers/database/table_name.dart';
import 'package:hr/features/employees/data/model/contract_model.dart';
import 'package:hr/features/employees/data/model/employee_model.dart';

part 'add_employee_state.dart';

class AddEmployeeCubit extends Cubit<AddEmployeeState> {
  AddEmployeeCubit() : super(AddEmployeeInitial());

  static AddEmployeeCubit get(context) => BlocProvider.of(context);
  int selectedTabIndex = 0;

  // personal information tab controllers
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final jobDescriptionController = TextEditingController();
  final birthdateController = TextEditingController();
  final phoneController = TextEditingController();
  final workingHoursController = TextEditingController();
  final workingDaysController = TextEditingController();

  // salary details tab controllers
  final salaryController = TextEditingController();
  final salaryDateController = TextEditingController();
  final overtimeHoursYearlyController = TextEditingController();
  final overtimeHoursMonthlyController = TextEditingController();
  final overtimePrice = TextEditingController();
  final contractStartDateController = TextEditingController();
  final contractEndDateController = TextEditingController();

  void changeTab(int index) {
    selectedTabIndex = index;
    emit(AddEmployeeTabChanged(index));
  }

  @override
  Future<void> close() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    jobDescriptionController.dispose();
    birthdateController.dispose();
    phoneController.dispose();
    workingHoursController.dispose();
    workingDaysController.dispose();
    salaryController.dispose();
    salaryDateController.dispose();
    overtimeHoursYearlyController.dispose();
    overtimeHoursMonthlyController.dispose();
    overtimePrice.dispose();
    contractStartDateController.dispose();
    contractEndDateController.dispose();
    return super.close();
  }

  void nextTab() {
    if (selectedTabIndex < 3) {
      selectedTabIndex++;
      emit(AddEmployeeTabChanged(selectedTabIndex));
    }
  }

  Future<void> addEmployeeWithContract() async {
    log(
      'AddEmployeeCubit: addEmployeeWithContract(): start insert transaction',
    );
    late final int empId;
    empId = await _addEmployeeToDB();
    log('AddEmployeeCubit: addEmployeeWithContract(): empId: $empId');
    await _addContractToDB(empId);
    log('AddEmployeeCubit: addEmployeeWithContract(): end insert transaction');
  }

  Future<int> _addEmployeeToDB() async {
    EmployeeModel employee = EmployeeModel(
      empId: -1,
      firstName: firstNameController.text,
      lastName: lastNameController.text,
      imagePath: '',
      email: emailController.text,
      job: jobDescriptionController.text,
      phone: phoneController.text,
      birthDate: birthdateController.text,
      salary: double.parse(salaryController.text),
      salaryDate: salaryDateController.text,
      workHours: int.parse(workingHoursController.text),
      workingDays: workingDaysController.text,
    );
    final empId = await DbHelper.insertData(
      TableName.employeeTable,
      employee.toJson(),
    );
    return empId;
  }

  Future<int> _addContractToDB(int empId) async {
    ContractModel contract = ContractModel(
      id: -1,
      employeeId: empId,
      startDate: contractStartDateController.text,
      endDate: contractEndDateController.text,
      overtimeYearly: int.parse(overtimeHoursYearlyController.text),
      overtimeMonthly: int.parse(overtimeHoursMonthlyController.text),
      overtimePrice: double.parse(overtimePrice.text),
    );
    final contractId = await DbHelper.insertData(
      TableName.contractTable,
      contract.toJson(),
    );
    return contractId;
  }
}

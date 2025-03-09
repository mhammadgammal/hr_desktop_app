import 'dart:developer';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr/core/helpers/database/db_helper.dart';
import 'package:hr/core/helpers/database/table_name.dart';
import 'package:hr/features/employees/data/model/contract_model.dart';
import 'package:hr/features/employees/data/model/employee_model.dart';

part 'employee_details_state.dart';

class EmployeeDetailsCubit extends Cubit<EmployeeDetailsState> {
  EmployeeDetailsCubit() : super(EmployeeDetailsInitial());

  late EmployeeModel employee;
  late ContractModel contract;
  int selectedTabIndex = 0;
  String profilePicPath = '';

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

  void loadEmployeeData(EmployeeModel employee) async {
    log('EmployeeDetailsCubit: loadEmployeeData');
    this.employee = employee;
    await _getEmployeeContract(employee.empId);
    firstNameController.text = employee.firstName;
    lastNameController.text = employee.lastName;
    emailController.text = employee.email;
    jobDescriptionController.text = employee.job;
    birthdateController.text = employee.birthDate;
    phoneController.text = employee.phone;
    workingHoursController.text = employee.workHours.toString();
    workingDaysController.text = employee.workingDays;
    salaryController.text = employee.salary.toString();
    salaryDateController.text = employee.salaryDate;
    overtimeHoursYearlyController.text = contract.overtimeYearly.toString();
    overtimeHoursMonthlyController.text = contract.overtimeMonthly.toString();
    overtimePrice.text = contract.overtimePrice.toString();
    contractStartDateController.text = contract.startDate;
    contractEndDateController.text = contract.endDate;
  }

  Future<void> _getEmployeeContract(int empId) async {
    final contract = await DbHelper.getRecordById(
      empId,
      tableName: TableName.contractTable,
    );
    this.contract = ContractModel.fromJson(contract);
  }

  void changeTab(int index) {
    selectedTabIndex = index;
    emit(EmployeeDetailsTabChanged(index));
  }

  void nextTab() {
    if (selectedTabIndex < 3) {
      selectedTabIndex++;
      emit(EmployeeDetailsTabChanged(selectedTabIndex));
    }
  }

  Future<FilePickerResult?> _openPicker() async =>
      await FilePicker.platform.pickFiles();

  Future<void> pickProfilePic() async {
    final result = await _openPicker();
    if (result != null) {
      profilePicPath = result.files.single.path!;
      log('EditEmployeeCubit: pickProfilePic: $profilePicPath');
      emit(EditEmployeeProfilePicPicked());
    }
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
}

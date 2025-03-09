import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
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

  bool editMode = false;
  late ContractModel contract;
  late EmployeeModel employee;
  int selectedTabIndex = 0;
  String profilePicPath = '';
  String identityPicPath = '';
  String contractPath = '';
  bool firstPagePersonalTab = true;

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

  final residenceController = TextEditingController();
  final identityNumberController = TextEditingController();

  void loadEmployeeContract(EmployeeModel? emp) async {
    log('AddEmployeeCubit: loadEmployeeContract');
    if (emp != null) {
      employee = emp;
      contract = await _getEmployeeContract(emp.empId);
      firstNameController.text = emp.firstName;
      lastNameController.text = emp.lastName;
      emailController.text = emp.email;
      profilePicPath = emp.imagePath;
      jobDescriptionController.text = emp.job;
      birthdateController.text = emp.birthDate;
      phoneController.text = emp.phone;
      workingHoursController.text = emp.workHours.toString();
      workingDaysController.text = emp.workingDays;
      salaryController.text = emp.salary.toString();
      salaryDateController.text = emp.salaryDate;
      overtimeHoursYearlyController.text = contract.overtimeYearly.toString();
      overtimeHoursMonthlyController.text = contract.overtimeMonthly.toString();
      overtimePrice.text = contract.overtimePrice.toString();
      contractStartDateController.text = contract.startDate;
      contractEndDateController.text = contract.endDate;
    }
  }

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

  void togglePersonalModeTabs() {
    firstPagePersonalTab = !firstPagePersonalTab;
    emit(AddEmployeePersonalTabToggled(firstPagePersonalTab));
  }

  Future<void> addEmployeeWithContract() async {
    try {
      log(
        'AddEmployeeCubit: addEmployeeWithContract(): start insert transaction',
      );
      late final int empId;
      empId = await _addEmployeeToDB();
      log('AddEmployeeCubit: addEmployeeWithContract(): empId: $empId');
      await _addContractToDB(empId);
      log(
        'AddEmployeeCubit: addEmployeeWithContract(): end insert transaction',
      );
      clearData();
      emit(AddEmployeeSuccessState());
    } catch (e) {
      log('AddEmployeeCubit: addEmployeeWithContract(): error: $e');
      emit(AddEmployeeFailureState(e.toString()));
    }
  }

  Future<int> _addEmployeeToDB() async {
    EmployeeModel employee = EmployeeModel(
      empId: -1,
      firstName: firstNameController.text,
      lastName: lastNameController.text,
      imagePath: profilePicPath,
      email: emailController.text,
      job: jobDescriptionController.text,
      phone: phoneController.text,
      birthDate: birthdateController.text,
      salary: double.parse(salaryController.text),
      salaryDate: salaryDateController.text,
      workHours: int.parse(workingHoursController.text),
      workingDays: workingDaysController.text,
      identityType: residenceController.text,
      identityNumber: identityNumberController.text,
      identityTypePicPath: '',
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

  void clearData() {
    firstNameController.text = '';
    lastNameController.text = '';
    emailController.text = '';
    jobDescriptionController.text = '';
    birthdateController.text = '';
    phoneController.text = '';
    workingHoursController.text = '';
    workingDaysController.text = '';
    salaryController.text = '';
    salaryDateController.text = '';
    overtimeHoursYearlyController.text = '';
    overtimeHoursMonthlyController.text = '';
    overtimePrice.text = '';
    contractStartDateController.text = '';
    contractEndDateController.text = '';
  }

  Future<FilePickerResult?> _openPicker() async =>
      await FilePicker.platform.pickFiles();

  Future<void> pickProfilePic() async {
    final result = await _openPicker();
    if (result != null) {
      profilePicPath = result.files.single.path!;
      log('AddEmployeeCubit: pickProfilePic: $profilePicPath');
      emit(AddEmployeeProfilePicPicked());
    }
  }

  _getEmployeeContract(int empId) async {
    final contract = await DbHelper.getRecordById(
      empId,
      tableName: TableName.contractTable,
    );
    return ContractModel.fromJson(contract);
  }
}

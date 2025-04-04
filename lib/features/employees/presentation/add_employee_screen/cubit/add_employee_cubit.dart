import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr/core/helpers/database/db_helper.dart';
import 'package:hr/core/helpers/database/table_name.dart';
import 'package:hr/features/employees/data/model/contract_model.dart';
import 'package:hr/features/employees/data/model/employee_model.dart';
import 'package:hr/features/vacations_alarms/data/vacation_model.dart';

part 'add_employee_state.dart';

class AddEmployeeCubit extends Cubit<AddEmployeeState> {
  AddEmployeeCubit() : super(AddEmployeeInitial());

  static AddEmployeeCubit get(context) => BlocProvider.of(context);

  bool isEditMode = false;
  late ContractModel contract;
  late EmployeeModel emp;
  int? newEmpId;
  int selectedTabIndex = 0;
  String profilePicPath = '';
  String profilePicFileName = '';
  String identityPicPath = '';
  String identityPicFileName = '';
  String contractPath = '';
  String contractFileName = '';
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

  final dayOffStartDateController = TextEditingController();
  final dayOffEndDateController = TextEditingController();

  final remainingVacationDays = TextEditingController();

  String? selectedIdentityType;

  void loadEmployeeContract(EmployeeModel? emp) async {
    log('AddEmployeeCubit: loadEmployeeContract');
    log('AddEmployeeCubit: loadEmployeeContract emp != null: ${emp != null}');
    if (emp != null) {
      isEditMode = true;
      this.emp = emp;
      contract = await _getEmployeeContract(emp.empId);
      log('AddEmployeeCubit: contract: ${contract.id}');
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
      residenceController.text = emp.identityType;
      identityNumberController.text = emp.identityNumber;
      identityPicPath = emp.identityTypePicPath;
      remainingVacationDays.text = emp.vacationCount.toString();
      emit(EmployeeDetailsDataLoaded());
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

  Future<void> submitData() async {
    if (isEditMode) {
      await _updateEmployeeWithContract();
    } else {
      await _addEmployeeWithContract();
    }
  }

  Future<void> _updateEmployeeWithContract() async {
    log('AddEmployeeCubit: _updateEmployeeWithContract: empId: ${emp.empId}');
    final tmpEmp = EmployeeModel(
      empId: emp.empId,
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
      identityTypePicPath: identityPicPath,
      vacationCount: int.tryParse(remainingVacationDays.text) ?? 21,
    );
    final result = await DbHelper.updateData(
      TableName.employeeTable,
      tmpEmp.toJson(),
      'id',
      [tmpEmp.empId],
    );

    log(
      'AddEmployeeCubit: _updateEmployeeWithContract: update result: $result',
    );

    emit(UpdateEmployeeSuccessState());
  }

  Future<void> _addEmployeeWithContract() async {
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
    try {
      emp;
    } catch (_) {
      constructEmployee();
    }
    final empId = await DbHelper.insertData(
      TableName.employeeTable,
      emp.toJson(),
    );
    return empId;
  }

  Future<int> _addContractToDB(int empId) async {
    ContractModel contract = ContractModel(
      id: -1,
      employeeId: empId,
      startDate: contractStartDateController.text,
      endDate: contractEndDateController.text,
      contractPicturePath: contractPath,
      overtimeYearly: int.parse(overtimeHoursYearlyController.text),
      overtimeMonthly: int.parse(overtimeHoursMonthlyController.text),
      overtimePrice: int.parse(overtimePrice.text),
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
      profilePicFileName = result.files.single.name;
      log('AddEmployeeCubit: pickProfilePic: $profilePicPath');
      emit(AddEmployeeProfilePicPicked(profilePicPath));
    }
  }

  void pickIdentity() async {
    final result = await _openPicker();
    if (result != null) {
      identityPicPath = result.files.single.path!;
      identityPicFileName = result.files.single.name;
      log('AddEmployeeCubit: pickProfilePic: $profilePicPath');
      emit(AddEmployeeProfilePicPicked(identityPicFileName));
    }
  }

  void pickContract() async {
    final result = await _openPicker();
    if (result != null) {
      contractPath = result.files.single.path!;
      contractFileName = result.files.single.name;
      log('AddEmployeeCubit: pickProfilePic: $profilePicPath');
      emit(AddEmployeeProfilePicPicked(contractFileName));
    }
  }

  _getEmployeeContract(int empId) async {
    final contract = await DbHelper.getRecordById(
      empId,
      tableName: TableName.contractTable,
    );
    return ContractModel.fromJson(contract);
  }

  void deleteEmp() async {
    emp.empId;

    await DbHelper.deleteData(TableName.employeeTable, 'id', [emp.empId]);

    emit(EmployeeDeletedSuccessfully());
  }

  Future<void> constructEmployee() async {
    newEmpId = isEditMode ? emp.empId : newEmpId;
    emp = EmployeeModel(
      empId: newEmpId ?? -1,
      firstName: firstNameController.text,
      lastName: lastNameController.text,
      imagePath: profilePicPath,
      email: emailController.text,
      job: jobDescriptionController.text,
      phone: phoneController.text,
      birthDate: birthdateController.text,
      salary:
          salaryController.text.isNotEmpty
              ? salaryController.text.contains('.')
                  ? double.parse(salaryController.text)
                  : int.parse(salaryController.text).toDouble()
              : 0.0,
      salaryDate: salaryDateController.text,
      workHours:
          workingHoursController.text.isNotEmpty
              ? int.parse(workingHoursController.text)
              : 0,
      workingDays: workingDaysController.text,
      identityType: selectedIdentityType ?? '',
      identityNumber: identityNumberController.text,
      identityTypePicPath: identityPicPath,
      vacationCount: 21,
    );

    if (isEditMode) {
      _updateEmployeeWithContract();
    } else {
      emit(ConstructEmployeeState());
    }
  }

  void requestVacation() async {
    var vacation = VacationModel(
      empId: emp.empId,
      id: -1,
      empFirstName: emp.firstName,
      empLastName: emp.lastName,
      startDate: dayOffStartDateController.text,
      empPicPath: emp.imagePath,
      endDate: dayOffEndDateController.text,
    );
    remainingVacationDays.text = _getRemainingVacDays(
      dayOffStartDateController.text,
      dayOffEndDateController.text,
    );
    await DbHelper.insertData(TableName.vacationTable, vacation.toJson());
  }

  String _getRemainingVacDays(String text, String text2) {
    DateTime parsedDate1 = DateTime.parse(text);
    DateTime parsedDate2 = DateTime.parse(text2);
    final days = parsedDate2.difference(parsedDate1).inDays;
    return (emp.vacationCount - days).toString();
  }

  List<String> identityTypes = ['Saudi', 'Iqama'];

  void onIdentityTypeChanged(String? value) {
    if (value != null) {
      selectedIdentityType = value;
      emit(IdentityTypeChangedState());
    }
  }
}

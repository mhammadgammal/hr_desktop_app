part of 'employee_details_cubit.dart';

sealed class EmployeeDetailsState {}

final class EmployeeDetailsInitial extends EmployeeDetailsState {}

final class EditEmployeeProfilePicPicked extends EmployeeDetailsState {}

final class EmployeeDetailsTabChanged extends EmployeeDetailsState {
  final int index;

  EmployeeDetailsTabChanged(this.index);
}

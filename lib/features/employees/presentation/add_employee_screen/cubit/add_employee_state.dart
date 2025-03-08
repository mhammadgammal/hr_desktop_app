part of 'add_employee_cubit.dart';

sealed class AddEmployeeState extends Equatable {
  const AddEmployeeState();

  @override
  List<Object> get props => [];
}

final class AddEmployeeInitial extends AddEmployeeState {}

final class AddEmployeeSuccessState extends AddEmployeeState {}

final class AddEmployeeFailureState extends AddEmployeeState {
  final String message;

  const AddEmployeeFailureState(this.message);
}

final class AddEmployeeTabChanged extends AddEmployeeState {
  final int index;

  const AddEmployeeTabChanged(this.index);

  @override
  List<Object> get props => [index];
}

final class AddEmployeeProfilePicPicked extends AddEmployeeState {}
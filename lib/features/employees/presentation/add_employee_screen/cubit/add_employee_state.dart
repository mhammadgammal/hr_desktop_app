part of 'add_employee_cubit.dart';

sealed class AddEmployeeState extends Equatable {
  const AddEmployeeState();

  @override
  List<Object> get props => [];
}

final class AddEmployeeInitial extends AddEmployeeState {}

final class AddEmployeeSuccessState extends AddEmployeeState {}

final class EmployeeDetailsDataLoaded extends AddEmployeeState {}

final class UpdateEmployeeSuccessState extends AddEmployeeState {}

final class EmployeeCreateLoadingState extends AddEmployeeState {}

final class EmployeeCreateSuccessState extends AddEmployeeState {}

final class IdentityTypeChangedState extends AddEmployeeState {}

final class AddEmployeePersonalTabToggled extends AddEmployeeState {
  final bool firstPagePersonalTab;

  const AddEmployeePersonalTabToggled(this.firstPagePersonalTab);

  @override
  List<Object> get props => [firstPagePersonalTab];
}

final class AddEmployeeFailureState extends AddEmployeeState {
  final String message;

  const AddEmployeeFailureState(this.message);
}

final class EmployeeCreateFailureState extends AddEmployeeState {
  final String message;

  const EmployeeCreateFailureState(this.message);
}

final class AddEmployeeTabChanged extends AddEmployeeState {
  final int index;

  const AddEmployeeTabChanged(this.index);

  @override
  List<Object> get props => [index];
}

final class AddEmployeeProfilePicPicked extends AddEmployeeState {}

final class EmployeeDeletedSuccessfully extends AddEmployeeState {}

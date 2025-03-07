part of 'employees_cubit.dart';

@immutable
sealed class EmployeesState {}

final class EmployeesInitial extends EmployeesState {}

final class GetAllEmployeesLoadingState extends EmployeesState {}

final class GetAllEmployeesSuccessState extends EmployeesState {}

part of 'vacation_cubit.dart';

@immutable
sealed class VacationState {}

final class VacationInitial extends VacationState {}

final class GetFinishedVacationLoadingState extends VacationState {}

final class GetFinishedVacationSuccessState extends VacationState {}

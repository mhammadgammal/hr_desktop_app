part of 'navigation_drawer_cubit.dart';

sealed class NavigationDrawerState extends Equatable {
  final int index;

  const NavigationDrawerState({this.index = 0});

  @override
  List<Object> get props => [];
}

final class NavigationDrawerInitial extends NavigationDrawerState {}

final class ShowEmployeeDetailsState extends NavigationDrawerState {
  final EmployeeModel emp;

  const ShowEmployeeDetailsState(this.emp);
}

final class NavigationDrawerItemTapped extends NavigationDrawerState {
  const NavigationDrawerItemTapped({super.index});

  @override
  List<Object> get props => [index];
}

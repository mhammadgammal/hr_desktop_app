import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr/core/assets/app_icons.dart';
import 'package:hr/core/widgets/drawer/entity/navigation_drawer_entity_item.dart';
import 'package:hr/features/employees/data/model/employee_model.dart';

part 'navigation_drawer_state.dart';

class NavigationDrawerCubit extends Cubit<NavigationDrawerState> {
  NavigationDrawerCubit() : super(NavigationDrawerInitial());

  static NavigationDrawerCubit get(context) => BlocProvider.of(context);

  int selectedIndex = 0;
  bool isEmpDetails = false;

  void onItemTapped(int index) {
    if (index == 0) {
      isEmpDetails = false;
    }
    selectedIndex = index;
    emit(NavigationDrawerItemTapped(index: index));
  }

  List<NavigationDrawerEntityItem> screens = [
    NavigationDrawerEntityItem(
      title: 'Home',
      iconPath: AppIcons.homeIc,
      onTap: () {},
    ),
    NavigationDrawerEntityItem(
      title: 'Alarms',
      iconPath: AppIcons.bellIc,
      onTap: () {},
    ),
    NavigationDrawerEntityItem(
      title: 'Add Employee',
      iconPath: AppIcons.addDocumentIc,
      onTap: () {},
    ),
    NavigationDrawerEntityItem(
      title: 'Settings',
      iconPath: AppIcons.settingsIc,
      onTap: () {},
    ),
  ];

  void showEmployeeDetails(EmployeeModel emp) {
    isEmpDetails = true;
    emit(ShowEmployeeDetailsState(emp));
  }
}

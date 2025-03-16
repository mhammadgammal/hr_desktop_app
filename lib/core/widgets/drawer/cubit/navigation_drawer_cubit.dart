import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart' show TextEditingController;
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

  final searchController = TextEditingController();

  final filterByEmployeeNameController = TextEditingController();

  final filterByJobController = TextEditingController();

  final filterByWorkingHoursController = TextEditingController();

  final filterByWorkingDaysController = TextEditingController();

  final filterByIdentityNumberController = TextEditingController();

  void onItemTapped(int index) {
    if (index == 0) {
      isEmpDetails = false;
    }
    selectedIndex = index;
    emit(NavigationDrawerItemTapped(index: index));
  }

  List<NavigationDrawerEntityItem> get screens => [
    NavigationDrawerEntityItem(
      title: 'Home',
      iconPath: AppIcons.homeIc,
      selectedIconPath: AppIcons.homeFilledIc,
      onTap: (index) {
        if (index != null) {
          onItemTapped(index);
        }
      },
    ),
    NavigationDrawerEntityItem(
      title: 'Alarms',
      iconPath: AppIcons.bellIc,
      selectedIconPath: AppIcons.bellFilledIc,
      onTap: (index) {
        if (index != null) {
          onItemTapped(index);
        }
      },
    ),
    NavigationDrawerEntityItem(
      title: 'Add Employee',
      iconPath: AppIcons.addDocumentIc,
      selectedIconPath: AppIcons.addDocumentFilledIc,
      onTap: (index) {
        if (index != null) {
          onItemTapped(index);
        }
      },
    ),
    NavigationDrawerEntityItem(
      title: 'Settings',
      iconPath: AppIcons.settingsIc,
      selectedIconPath: AppIcons.settingsFilledIc,
      onTap: (index) {
        if (index != null) {
          onItemTapped(index);
        }
      },
    ),
  ];

  void showEmployeeDetails(EmployeeModel emp) {
    isEmpDetails = true;
    emit(ShowEmployeeDetailsState(emp));
  }

  set isFiltered(bool isNotEmpty) {
    onItemTapped(0);
    emit(IsFilteredState(isNotEmpty));
  }
}

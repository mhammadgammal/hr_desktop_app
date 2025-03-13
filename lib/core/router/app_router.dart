import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr/core/app/app_layout.dart';
import 'package:hr/core/router/router_keys.dart';
import 'package:hr/core/widgets/drawer/cubit/navigation_drawer_cubit.dart';
import 'package:hr/features/authentication/presentation/cubit/sign_in_cubit.dart';
import 'package:hr/features/authentication/presentation/sign_in_screen.dart';

abstract class AppRouter {
  static Map<String, Widget Function(BuildContext)> routes = {
    RouterKeys.home:
        (context) => BlocProvider(
          create: (context) => SignInCubit()..createUser(),
          child: SignInScreen(),
        ),
    RouterKeys.mainScreen:
        (_) => BlocProvider(
          create: (context) => NavigationDrawerCubit(),
          child: AppLayout(),
        ),
    // RouterKeys.employeeDetailsScreen:
    //     (context) {
    //   var args = ModalRoute.settingsOf(context)!.arguments as Map<
    //       String,
    //       dynamic>;
    //
    //   return BlocProvider(
    //       create: (context) => AddEmployeeCubit(),
    //     child: EmployeeDetailsScreen(emp: args['emp'],),
    //   );
    // },
  };
}

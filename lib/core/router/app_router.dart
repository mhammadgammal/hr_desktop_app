import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr/features/authentication/presentation/cubit/sign_in_cubit.dart';
import 'package:hr/features/authentication/presentation/sign_in_screen.dart';

abstract class AppRouter {
  static Map<String, Widget Function(BuildContext)> routes = {
    '/':
        (context) => BlocProvider(
          create: (context) => SignInCubit(),
          child: SignInScreen(),
        ),
  };
}

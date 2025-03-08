import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr/core/extensions/extensions.dart';
import 'package:hr/core/router/app_navigator.dart';
import 'package:hr/core/router/router_keys.dart';
import 'package:hr/core/theme/app_colors.dart';
import 'package:hr/core/widgets/dialog_helper/dialog_helper.dart';
import 'package:hr/features/authentication/presentation/cubit/sign_in_cubit.dart';
import 'package:hr/features/authentication/presentation/widgets/logo_section.dart';
import 'package:hr/features/authentication/presentation/widgets/sign_in_form.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<SignInCubit, SignInState>(
        listener: (context, state) {
          if (state is SignInSuccessState) {
            'Navigate to home screen'.logg();
            AppNavigator.navigateTo(context, RouterKeys.mainScreen);
          } else if (state is SignInFailureState) {
            DialogHelper.showFailureDialog(context, state.message);
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.sizeOf(context).height,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(child: LogoSection()),
                  VerticalDivider(
                    color: AppColors.gray,
                    indent: 10.0,
                    endIndent: 10.0,
                    thickness: 1.0,
                  ),
                  SizedBox(width: 20.0),
                  Expanded(child: SignInForm()),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

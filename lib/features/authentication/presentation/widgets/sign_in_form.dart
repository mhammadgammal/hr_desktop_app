import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hr/core/app/cubit/app_cubit.dart';
import 'package:hr/core/assets/app_images.dart';
import 'package:hr/core/extensions/extensions.dart';
import 'package:hr/core/widgets/buttons/custom_filled_button.dart';
import 'package:hr/core/widgets/text_form_field/email_text_form_field.dart';
import 'package:hr/core/widgets/text_form_field/password_text_form_field.dart';
import 'package:hr/features/authentication/presentation/cubit/sign_in_cubit.dart';

class SignInForm extends StatelessWidget {
  const SignInForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInCubit, SignInState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = SignInCubit.get(context);
        return SizedBox(
          width: 550.w,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: Form(
              key: GlobalKey<FormState>(),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    AppCubit.get(context).isDarkMode
                        ? AppImages.loginBackgroundDark
                        : AppImages.loginBackground,
                  ),
                  EmailTextFormField(
                    controller: cubit.emailController,
                    label: 'Email'.tr(context),
                  ),
                  SizedBox(height: 10.0.h),
                  PasswordTextFormField(
                    controller: cubit.passwordController,
                    label: 'Password'.tr(context),
                  ),
                  SizedBox(height: 20.0.h),
                  CustomFilledButton(
                    width: double.infinity,
                    onPressed: cubit.signIn,
                    title: 'Sign In'.tr(context),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

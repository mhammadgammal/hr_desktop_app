import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hr/core/app/cubit/app_cubit.dart';
import 'package:hr/core/assets/app_images.dart';
import 'package:hr/core/di/di.dart';
import 'package:hr/core/extensions/extensions.dart';
import 'package:hr/core/helpers/cache/cache_keys.dart';
import 'package:hr/core/helpers/cache/shared_preferences/cache_helper.dart';
import 'package:hr/core/theme/app_colors.dart';
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
              key: cubit.formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextButton.icon(
                    onPressed: () {
                      final nextLocale =
                          sl<CacheHelper>().getString(
                                    key: CacheKeys.languageCode,
                                  ) ==
                                  'en'
                              ? 'ar'
                              : 'en';
                      log("SignInForm: change language to $nextLocale");
                      AppCubit.get(context).changeLanguage(Locale(nextLocale));
                    },
                    label: Text(
                      AppCubit.get(context).locale.languageCode == 'en'
                          ? "العربيه"
                          : "English",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    icon: Icon(Icons.public, color: AppColors.gray),
                    iconAlignment: IconAlignment.end,
                  ),
                  Center(
                    child: SvgPicture.asset(
                      width: 550.0.w,
                      height: 412.0.h,
                      AppCubit.get(context).isDarkMode
                          ? AppImages.loginBackgroundDark
                          : AppImages.loginBackground,
                    ),
                  ),
                  SizedBox(
                    child: EmailTextFormField(
                      controller: cubit.emailController,
                      label: 'Email'.tr(context),
                    ),
                  ),
                  SizedBox(height: 10.0.h),
                  PasswordTextFormField(
                    controller: cubit.passwordController,
                    label: 'Password'.tr(context),
                  ),
                  SizedBox(height: 20.0.h),
                  CustomFilledButton(
                    width: double.infinity,
                    height: 50.0.h,
                    onPressed: () {
                      if (cubit.formKey.currentState!.validate()) {
                        cubit.signIn();
                      }
                    },
                    title: 'Sign In'.tr(context),
                    fontSize: 18,
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

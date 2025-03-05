import 'package:flutter/material.dart';
import 'package:hr/features/authentication/presentation/widgets/logo_section.dart';
import 'package:hr/features/authentication/presentation/widgets/sign_in_form.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.sizeOf(context).height,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(child: LogoSection()),
              VerticalDivider(
                color: Colors.white,
                indent: 10.0,
                endIndent: 10.0,
                thickness: 1.0,
              ),
              SizedBox(width: 20.0),
              Expanded(child: SignInForm()),
            ],
          ),
        ),
      ),
    );
  }
}

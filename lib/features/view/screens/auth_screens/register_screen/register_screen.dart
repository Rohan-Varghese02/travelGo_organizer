import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelgo_organizer/features/logic/auth/auth_bloc.dart';
import 'package:travelgo_organizer/features/view/screens/auth_screens/register_screen/register_profile_screen.dart';
import 'package:travelgo_organizer/features/view/screens/auth_screens/register_screen/widgets/register_button.dart';
import 'package:travelgo_organizer/features/view/screens/auth_screens/register_screen/widgets/register_footer.dart';
import 'package:travelgo_organizer/features/view/screens/auth_screens/register_screen/widgets/register_header.dart';
import 'package:travelgo_organizer/features/view/screens/auth_screens/register_screen/widgets/register_info.dart';
import 'package:travelgo_organizer/features/view/screens/auth_screens/register_screen/widgets/register_tpc.dart';
import 'package:travelgo_organizer/features/view/screens/auth_screens/register_screen/widgets/register_validator.dart';
import 'package:travelgo_organizer/features/view/widgets/auth%20widgets/heading_password_field.dart';
import 'package:travelgo_organizer/features/view/widgets/heading_text_field.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailRegController = TextEditingController();
    final TextEditingController passRegController = TextEditingController();
    final TextEditingController confirmpassRegController =
        TextEditingController();
    final key = GlobalKey<FormState>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 8),
            child: BlocListener<AuthBloc, AuthState>(
              listener: (context, state) {
                log(state.runtimeType.toString());
                if (state is ReturnToLogin) {
                  Navigator.of(context).pop();
                } else if (state is PasswordConfirmedPassDifferent) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Password and Confirm Password doesn\'t match',
                      ),
                    ),
                  );
                } else if (state is ContinueRegisteration) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder:
                          (context) => RegisterProfileScreen(
                            email: state.email,
                            password: state.password,
                          ),
                    ),
                  );
                }
              },
              child: Form(
                key: key,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RegisterHeader(),
                    SizedBox(height: 20),
                    HeadingTextField(
                      headline: 'Email',
                      controller: emailRegController,
                      hint: 'Enter your email address',
                      validator: (value) {
                        return validateEmail(value);
                      },
                    ),
                    SizedBox(height: 20),
                    BlocBuilder<AuthBloc, AuthState>(
                      buildWhen:
                          (previous, current) => current is AuthActionState,
                      builder: (context, state) {
                        bool isVisible = true;
                        if (state is VisibleState) {
                          isVisible = state.isVisible;
                        }
                        return HeadingPasswordField(
                          validator: (value) {
                            return validatePassword(value);
                          },
                          headline: 'Password',
                          hint: 'Enter your password',
                          controller: passRegController,
                          onPressed: () {
                            context.read<AuthBloc>().add(
                              VisibillityButtonClicked(isVisible: isVisible),
                            );
                          },
                          isVisible: isVisible,
                        );
                      },
                    ),
                    RegisterInfo(),
                    SizedBox(height: 20),

                    BlocBuilder<AuthBloc, AuthState>(
                      buildWhen:
                          (previous, current) => current is AuthActionState,
                      builder: (context, state) {
                        bool isVisible = true;
                        if (state is VisibleState) {
                          isVisible = state.isVisible;
                        }
                        return HeadingPasswordField(
                          validator: (p0) {
                            if (p0 == null || p0.isEmpty) {
                              return 'Enter Confirm Password';
                            }
                            return null;
                          },
                          headline: 'Confirm Password',
                          hint: 'Confirm your password',
                          controller: confirmpassRegController,
                          onPressed: () {
                            context.read<AuthBloc>().add(
                              VisibillityButtonClicked(isVisible: isVisible),
                            );
                          },
                          isVisible: isVisible,
                        );
                      },
                    ),
                    SizedBox(height: 20),
                    RegisterTpc(),
                    SizedBox(height: 20),
                    RegisterButton(
                      text: 'Continue',
                      onPressed: () {
                        if (key.currentState!.validate()) {
                          log('pressed');
                          context.read<AuthBloc>().add(
                            RegisterButtonEvent(
                              email: emailRegController.text,
                              password: passRegController.text,
                              confirmPassword: confirmpassRegController.text,
                            ),
                          );
                        }
                      },
                      emailController: emailRegController,
                      passController: passRegController,
                      confirmPassController: confirmpassRegController,
                    ),
                    SizedBox(height: 20),
                    // DividerWithOr(),
                    // SizedBox(height: 20),
                    // GoogleButton(
                    //   onTap: () {
                    //     Navigator.pop(context);
                    //     context.read<AuthBloc>().add(GoogleSignInEvent());
                    //   },
                    // ),
                    SizedBox(height: 80),
                    RegisterFooter(
                      onTap: () {
                        context.read<AuthBloc>().add(AlreadyMemeber());
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

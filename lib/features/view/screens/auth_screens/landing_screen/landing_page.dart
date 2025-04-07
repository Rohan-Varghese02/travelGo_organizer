import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:travelgo_organizer/features/logic/auth/auth_bloc.dart';
import 'package:travelgo_organizer/features/view/screens/auth_screens/landing_screen/widgets/landing_header.dart';
import 'package:travelgo_organizer/features/view/screens/auth_screens/login_screen/login_screen.dart';
import 'package:travelgo_organizer/features/view/widgets/long_button.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              LandingHeader(),
              Lottie.asset('assets/logo.json'),
              Divider(),
              SizedBox(height: 45),
              BlocListener<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is LoginPageNavigationState) {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  }
                },

                child: LongButton(
                  text: 'Get Started',
                  onPressed: () {
                    context.read<AuthBloc>().add(GetStartedNavigationEvent());
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelgo_organizer/core/services/auth/auth_gate.dart';
import 'package:travelgo_organizer/features/logic/auth/auth_bloc.dart';
import 'package:travelgo_organizer/features/view/screens/auth_screens/landing_screen/landing_page.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(IntialSplashEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        log(state.runtimeType.toString());
        if (state is FirstTimeLoading) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => LandingPage()),
          );
        } else if (state is OnceLoadedState) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => AuthGate()),
          );
        }
      },
      child: Scaffold(
        //body: //Center(child: Image(image: AssetImage('assets/logo3.png'))),
      ),
    );
  }
}

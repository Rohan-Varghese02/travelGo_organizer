import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelgo_organizer/core/services/auth/auth_gate.dart';
import 'package:travelgo_organizer/features/logic/auth/auth_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: Center(
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is LogoutState) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => AuthGate()),
              );
            }
          },
          child: ElevatedButton(
            onPressed: () {
              context.read<AuthBloc>().add(LogOutButtonClicked());
            },
            child: Text('Logout'),
          ),
        ),
      ),
    );
  }
}

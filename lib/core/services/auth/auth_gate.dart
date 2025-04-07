import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:travelgo_organizer/features/view/screens/auth_screens/pending_screen.dart/pending_screen.dart';
import 'package:travelgo_organizer/features/view/screens/home_screen/home_screen.dart';
import 'package:travelgo_organizer/features/view/screens/auth_screens/login_screen/login_screen.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  Future<Widget> checkUserRole(User user) async {
    final docSnapshot =
        await FirebaseFirestore.instance
            .collection('Organizers')
            .doc(user.uid)
            .get();

    if (docSnapshot.exists) {
      final role = docSnapshot.data()!['role'];

      if (role == 'pending-organizer') {
        return PendingScreen();
      } else {
        return HomeScreen();
      }
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Access Denied: You are not an organizer."),
            backgroundColor: Colors.red,
          ),
        );
        await FirebaseAuth.instance.signOut();
      });
      return LoginScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasData && snapshot.data != null) {
            return FutureBuilder<Widget>(
              future: checkUserRole(snapshot.data!),
              builder: (context, roleSnapshot) {
                if (roleSnapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (roleSnapshot.hasData) {
                  return roleSnapshot.data!;
                } else {
                  return const LoginScreen(); // Fallback
                }
              },
            );
          } else {
            return const LoginScreen();
          }
        },
      ),
    );
  }
}

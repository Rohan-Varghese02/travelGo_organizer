import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:travelgo_organizer/core/services/stream_services.dart';
import 'package:travelgo_organizer/data/models/organizer_data.dart';
import 'package:travelgo_organizer/features/view/screens/auth_screens/pending_screen.dart/pending_screen.dart';
import 'package:travelgo_organizer/features/view/screens/auth_screens/login_screen/login_screen.dart';
import 'package:travelgo_organizer/features/view/screens/auth_screens/reject_screen/reject_screen.dart';
import 'package:travelgo_organizer/features/view/screens/main_screens/main_screen.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  // Future<Widget> checkUserRole(User user) async {
  //   final docSnapshot =
  //       await FirebaseFirestore.instance
  //           .collection('Organizers')
  //           .doc(user.uid)
  //           .get();

  //   if (docSnapshot.exists) {
  //     final data = docSnapshot.data()!;
  //     final role = docSnapshot.data()!['role'];

  //     if (role == 'pending-organizer') {
  //       final organizerData = OrganizerDataModel.fromMap(data);
  //       return PendingScreen(organizerData: organizerData);
  //     } else if (role == 'not-organizer') {
  //       return RejectScreen();
  //     } else if (role == 'organizer') {
  //       final data = docSnapshot.data()!;
  //       final organizerData = OrganizerDataModel.fromMap(data);
  //       return MainScreen(organizerData: organizerData);
  //     } else {
  //       return LoginScreen();
  //     }
  //   } else {
  //     WidgetsBinding.instance.addPostFrameCallback((_) async {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(
  //           content: Text("Access Denied: You are not an organizer."),
  //           backgroundColor: Colors.red,
  //         ),
  //       );
  //       await FirebaseAuth.instance.signOut();
  //     });
  //     return LoginScreen();
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, authSnapshot) {
          if (authSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final user = authSnapshot.data;
          if (user == null) {
            return const LoginScreen();
          }
          return StreamBuilder<DocumentSnapshot>(
            stream:StreamServices().getOrganizerStream(user.uid),
            builder: (context, userSnapshot) {
              if (userSnapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (!userSnapshot.hasData || !userSnapshot.data!.exists) {
                WidgetsBinding.instance.addPostFrameCallback((_) async {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Access Denied: You are not an organizer."),
                      backgroundColor: Colors.red,
                    ),
                  );
                  await FirebaseAuth.instance.signOut();
                });
                return const LoginScreen();
              }
              final data = userSnapshot.data!.data() as Map<String, dynamic>;
              final role = data['role'];
              if (role == 'pending-organizer') {
                final organizerData = OrganizerDataModel.fromMap(data);
                return PendingScreen(organizerData: organizerData);
              } else if (role == 'not-organizer') {
                return const RejectScreen();
              } else if (role == 'organizer') {
                final organizerData = OrganizerDataModel.fromMap(data);
                return MainScreen(organizerData: organizerData);
              } else {
                return const LoginScreen();
              }
            },
          );
        },
      ),
    );
  }
}

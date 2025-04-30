import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelgo_organizer/core/constants/colors.dart';
import 'package:travelgo_organizer/core/services/auth/auth_gate.dart';
import 'package:travelgo_organizer/data/models/organizer_data.dart';
import 'package:travelgo_organizer/features/logic/auth/auth_bloc.dart';
import 'package:travelgo_organizer/features/view/widgets/style_text.dart';

class PendingScreen extends StatelessWidget {
  final OrganizerDataModel organizerData;
  const PendingScreen({super.key, required this.organizerData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: themeColor,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage(organizerData.imageUrl),
                ),
               StyleText(text: organizerData.name, color: white,fontWeight: FontWeight.bold,),
              ],
            ),
          ),
          SizedBox(width: 20),
        ],
      ),
      body: Center(
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is LogoutState) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => AuthGate()),
              );
            }
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/hourglass.png'),
              SizedBox(height: 20),
              StyleText(text: 'Request Pending',size: 30, fontWeight: FontWeight.normal,),
              SizedBox(height: 20),
              StyleText(text: 'Your request is being reviewed please wait until verified',size: 14, fontWeight: FontWeight.w300,),
              StyleText(text: 'keep refreshing to know the status', size: 14, fontWeight: FontWeight.w300,),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  backgroundColor: themeColor,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  context.read<AuthBloc>().add(LogOutButtonClicked());
                },
                child: Text('Logout'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

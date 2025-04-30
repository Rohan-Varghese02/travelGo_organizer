import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelgo_organizer/core/constants/colors.dart';
import 'package:travelgo_organizer/features/logic/auth/auth_bloc.dart';
import 'package:travelgo_organizer/features/view/widgets/style_text.dart';

void logoutDailog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        title: StyleText(text: 'Logout',color: themeColor,),
        content: StyleText(text: 'Do you really wish to logout from your account',),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: StyleText(text: 'Cancel',color: black,),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: themeColor,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () async {
              context.read<AuthBloc>().add(LogOutButtonClicked());
              Navigator.of(context).pop();
            },
            child: StyleText(text: 'Logout'),
          ),
        ],
      );
    },
  );
}

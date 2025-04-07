import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travelgo_organizer/core/constants/colors.dart';

class RegisterDailog extends StatelessWidget {
  final void Function()? onPressed;
  const RegisterDailog({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Email already in use', style: GoogleFonts.poppins()),
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            backgroundColor: themeColor,
            foregroundColor: Colors.white,
          ),
          onPressed: onPressed,
          child: Text('Go back'),
        ),
      ],
    );
  }
}

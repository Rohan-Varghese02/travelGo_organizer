import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travelgo_organizer/core/constants/colors.dart';

class RegisterInfo extends StatelessWidget {
  const RegisterInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 2),

        Text(
          'Password should contain minimum eight letters',
          style: GoogleFonts.poppins(color: grey50, fontSize: 10),
        ),
        SizedBox(height: 2),
        Text(
          'Password should contain atleast one uppercase',
          style: GoogleFonts.poppins(color: grey50, fontSize: 10),
        ),
        SizedBox(height: 2),

        Text(
          'Password should contain atleast one special character',
          style: GoogleFonts.poppins(color: grey50, fontSize: 10),
        ),
      ],
    );
  }
}

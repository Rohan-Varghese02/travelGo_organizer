import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travelgo_organizer/core/constants/colors.dart';

class RegisterHeader extends StatelessWidget {
  const RegisterHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Create an',
          style: GoogleFonts.poppins(fontSize: 32, fontWeight: FontWeight.w500),
        ),
        Text(
          'account',
          style: GoogleFonts.poppins(
            fontSize: 32,
            fontWeight: FontWeight.w500,
            color: themeColor,
          ),
        ),
      ],
    );
  }
}

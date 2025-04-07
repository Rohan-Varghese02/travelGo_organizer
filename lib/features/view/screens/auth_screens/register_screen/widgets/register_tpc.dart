import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travelgo_organizer/core/constants/colors.dart';

class RegisterTpc extends StatelessWidget {
  const RegisterTpc({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Text.rich(
          TextSpan(
            text: 'By signing up you agree to our ',
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: black,
              fontWeight: FontWeight.w300,
            ),
            children: [
              TextSpan(
                text: 'Terms, ',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  decoration: TextDecoration.underline,
                  decorationColor: black,
                  fontWeight: FontWeight.w700,
                ),
              ),
              TextSpan(
                text: 'Privacy Policy, ',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  decoration: TextDecoration.underline,
                  decorationColor: black,
                  fontWeight: FontWeight.w700,
                ),
              ),
              TextSpan(
                text: 'and ',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: black,
                  fontWeight: FontWeight.w300,
                ),
              ),

              TextSpan(
                text: 'Cookie Use',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  decoration: TextDecoration.underline,
                  decorationColor: black,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

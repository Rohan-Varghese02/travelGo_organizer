import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travelgo_organizer/core/constants/colors.dart';

class LoginFooter extends StatelessWidget {
  final void Function()? onTap;
  const LoginFooter({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: 'Don\'t have an account? ',
        style: GoogleFonts.poppins(fontSize: 16, color: grey99),
        children: [
          TextSpan(
            text: 'Join',
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: black,
              decoration: TextDecoration.underline,
            ),
            recognizer: TapGestureRecognizer()..onTap = onTap
          ),
        ],
      ),
    );
  }
}

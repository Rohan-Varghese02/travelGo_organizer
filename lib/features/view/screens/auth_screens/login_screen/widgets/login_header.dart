import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travelgo_organizer/core/constants/colors.dart';
import 'package:travelgo_organizer/features/view/widgets/style_text.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
            text: 'Login to your ',
            style: GoogleFonts.poppins(
              fontSize: 32,
              fontWeight: FontWeight.w600,
              color: black,
            ),
            children: [
              TextSpan(
                text: 'account',
                style: GoogleFonts.poppins(
                  fontSize: 32,
                  fontWeight: FontWeight.w600,
                  color: themeColor,
                ),
              ),
            ],
          ),
        ),
        StyleText(text: 'It\'s great to see you again', size: 16, color: grey50,)  
      ],
    );
  }
}

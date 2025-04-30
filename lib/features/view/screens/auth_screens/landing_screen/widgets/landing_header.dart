import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travelgo_organizer/core/constants/colors.dart';
import 'package:travelgo_organizer/features/view/widgets/style_text.dart';

class LandingHeader extends StatelessWidget {
  const LandingHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        StyleText(text: 'Plan it',size: 55, fontWeight: FontWeight.w500,),
        StyleText(text: 'Post it.Let Them ', size: 55,fontWeight: FontWeight.w500,),
        Text.rich(
          TextSpan(
            text: 'TravL',
            style: GoogleFonts.poppins(
              fontSize: 60,
              fontWeight: FontWeight.w500,
            ),
            children: [
              TextSpan(
                text: 'GO"',
                style: GoogleFonts.poppins(
                  fontSize: 55,
                  fontWeight: FontWeight.w500,
                  color: themeColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

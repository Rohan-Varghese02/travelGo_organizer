import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travelgo_organizer/core/constants/colors.dart';

class DividerWithOr extends StatelessWidget {
  const DividerWithOr({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Divider(color: Colors.grey, thickness: 1),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          color: Colors.white,
          child: Text(
            "Or",
            style: GoogleFonts.poppins(fontSize: 16, color: grey50),
          ),
        ),
      ],
    );
  }
}

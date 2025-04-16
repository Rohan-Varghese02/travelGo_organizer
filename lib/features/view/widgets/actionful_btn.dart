import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travelgo_organizer/core/constants/colors.dart';

class ActionfulBtn extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  const ActionfulBtn({super.key, required this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: themeColor,
        foregroundColor: whiteBg,
      ),
      onPressed: onPressed,
      child: Text(text, style: GoogleFonts.poppins()),
    );
  }
}

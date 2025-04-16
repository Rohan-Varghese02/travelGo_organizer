import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeHeading extends StatelessWidget {
  final String text;
  const HomeHeading({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        fontSize: 20,
        decoration: TextDecoration.underline,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

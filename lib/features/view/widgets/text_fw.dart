import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextFw extends StatelessWidget {
  final String firstword;
  final double? fontSize;
  final String secondWord;
  final TextOverflow? overflow;
  const TextFw({
    super.key,
    required this.firstword,
    required this.secondWord,
    this.fontSize,
    this.overflow,
  });

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      overflow: overflow,
      TextSpan(
        text: firstword,
        style: GoogleFonts.poppins(
          fontSize: fontSize ?? 13,
          fontWeight: FontWeight.bold,
        ),
        children: [
          TextSpan(
            text: secondWord,
            style: GoogleFonts.poppins(fontSize: fontSize ?? 13),
          ),
        ],
      ),
      softWrap: true,
    );
  }
}

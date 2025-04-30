import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextFw extends StatelessWidget {
  final String firstword;
  final String secondWord;
  const TextFw({super.key, required this.firstword, required this.secondWord});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      overflow: TextOverflow.ellipsis,
      TextSpan(
        text: firstword,
        style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.bold),
        children: [
          TextSpan(text: secondWord, style: GoogleFonts.poppins(fontSize: 13)),
        ],
      ),
    );
  }
}

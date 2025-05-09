import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travelgo_organizer/core/constants/colors.dart';
class StyleText extends StatelessWidget {
  final TextDecoration? decoration;
  final String text;
  final Color? color;
    final bool? softWrap;

  final double? size;
  final FontWeight? fontWeight;
  final TextOverflow? overflow;
  final int? maxLines;
  final TextAlign? textAlign;
  const StyleText({
    super.key,
    required this.text,
    this.color,
    this.size,
    this.fontWeight,
    this.decoration, this.overflow, this.maxLines, this.textAlign, this.softWrap,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
      softWrap: softWrap,
      style: GoogleFonts.poppins(
        color: color ?? black,
        fontSize: size,
        fontWeight: fontWeight,
        decoration: decoration,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travelgo_organizer/core/constants/colors.dart';

class HeadingTextField extends StatelessWidget {
  final String hint;
  final String headline;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final bool? readOnly;
  final Color? colortext;
  final Color? borderColor;
  const HeadingTextField({
    super.key,
    required this.headline,
    required this.controller,
    required this.hint,
    this.validator,
    this.readOnly,
    this.colortext,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          headline,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: colortext ?? Colors.black,
          ),
        ),
        TextFormField(
          minLines: 1,
          maxLines: 20,
          readOnly: readOnly ?? false,
          validator: validator,
          controller: controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: borderColor ?? grey20),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: black),
            ),
            hintText: hint,
            hintStyle: GoogleFonts.poppins(color: grey99, fontSize: 16),
          ),
        ),
      ],
    );
  }
}

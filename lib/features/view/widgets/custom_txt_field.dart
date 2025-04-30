import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travelgo_organizer/core/constants/colors.dart';

class CustomTxtField extends StatelessWidget {
  final String hint;

  final TextEditingController controller;
  final String? Function(String?)? validator;
  final bool? readOnly;
  final Color? colortext;
  final Color? borderColor;
  final double radius;
  const CustomTxtField({
    super.key,
    required this.controller,
    this.validator,
    this.readOnly,
    this.colortext,
    this.borderColor,
    required this.hint,
    required this.radius,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
    
      readOnly: readOnly ?? false,
      validator: validator,
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(radius)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: BorderSide(color: borderColor ?? grey20),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: BorderSide(color: black),
        ),
        hintText: hint,
        hintStyle: GoogleFonts.poppins(color: grey99, fontSize: 16),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travelgo_organizer/core/constants/colors.dart';

class RegisterButton extends StatelessWidget {
  final String text;
  final void Function() onPressed;
  final TextEditingController emailController;
  final TextEditingController passController;
  final TextEditingController confirmPassController;
  const RegisterButton({super.key, required this.text, required this.onPressed, required this.emailController, required this.passController, required this.confirmPassController});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width * 0.95;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: Size(width, 60),
        backgroundColor: themeColor,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500),
      ),
    );
  }
}
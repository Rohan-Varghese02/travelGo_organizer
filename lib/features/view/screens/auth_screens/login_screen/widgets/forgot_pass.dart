import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travelgo_organizer/features/logic/auth/auth_bloc.dart';

class ForgotPass extends StatelessWidget {
  const ForgotPass({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'Forgot your password? ',
          style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w200),
        ),
        GestureDetector(
          onTap: () {
            context.read<AuthBloc>().add(ForgotPasswordEvent());
          },
          child: Text(
            'Reset your password',
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }
}
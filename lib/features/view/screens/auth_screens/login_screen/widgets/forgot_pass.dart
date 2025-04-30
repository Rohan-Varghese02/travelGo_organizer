import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelgo_organizer/features/logic/auth/auth_bloc.dart';
import 'package:travelgo_organizer/features/view/widgets/style_text.dart';

class ForgotPass extends StatelessWidget {
  const ForgotPass({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        StyleText(text: 'Forgot your password? ',size: 14, fontWeight: FontWeight.w200,),
        GestureDetector(
          onTap: () {
            context.read<AuthBloc>().add(ForgotPasswordEvent());
          },
          child: StyleText(text:   'Reset your password', size: 14,fontWeight: FontWeight.bold,decoration: TextDecoration.underline,),
        ),
      ],
    );
  }
}
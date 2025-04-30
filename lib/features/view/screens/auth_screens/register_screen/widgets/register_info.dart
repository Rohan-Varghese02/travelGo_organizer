import 'package:flutter/material.dart';
import 'package:travelgo_organizer/core/constants/colors.dart';
import 'package:travelgo_organizer/features/view/widgets/style_text.dart';

class RegisterInfo extends StatelessWidget {
  const RegisterInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 2),

        StyleText(
          text: 'Password should contain minimum eight letters',
          color: grey50,
          size: 10,
        ),
        SizedBox(height: 2),
        StyleText(
          text: 'Password should contain atleast one uppercase',
          color: grey50,
          size: 10,
        ),
        SizedBox(height: 2),
        StyleText(
          text: 'Password should contain atleast one special character',
          color: grey50,
          size: 10,
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:travelgo_organizer/core/constants/colors.dart';
import 'package:travelgo_organizer/features/view/widgets/style_text.dart';

class RegisterHeader extends StatelessWidget {
  const RegisterHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StyleText(text: 'Create an', size: 32, fontWeight: FontWeight.w500),
        StyleText(
          text: 'account',
          size: 32,
          fontWeight: FontWeight.w500,
          color: themeColor,
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:travelgo_organizer/core/constants/colors.dart';
import 'package:travelgo_organizer/features/view/widgets/style_text.dart';

class LoginButton extends StatelessWidget {
  final String text;
  final void Function() onPressed;

  const LoginButton({super.key, required this.text, required this.onPressed});

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
      child: StyleText(text: text, size: 16, fontWeight: FontWeight.w500,),
    );
  }
}

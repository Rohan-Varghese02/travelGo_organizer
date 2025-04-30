import 'package:flutter/material.dart';
import 'package:travelgo_organizer/features/view/widgets/style_text.dart';

class HomeHeading extends StatelessWidget {
  final String text;
  const HomeHeading({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return StyleText(text: text, size: 20,fontWeight: FontWeight.bold,decoration: TextDecoration.underline,)
    ;
  }
}

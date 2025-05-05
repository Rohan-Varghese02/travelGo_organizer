import 'package:flutter/material.dart';
import 'package:travelgo_organizer/core/constants/colors.dart';
import 'package:travelgo_organizer/features/view/widgets/style_text.dart';

class SquareElevatedBtn extends StatelessWidget {
  final String text;
  final Function()? onPressed;
  final double radius;
  final Color? color;
  final Color? backgroundColor;
  const SquareElevatedBtn({
    super.key,
    required this.text,
    this.onPressed,
    required this.radius,
    this.color,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? themeColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
      onPressed: onPressed,
      child: StyleText(text: text, color: color),
    );
  }
}

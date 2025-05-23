import 'package:flutter/material.dart';
import 'package:travelgo_organizer/core/constants/colors.dart';
import 'package:travelgo_organizer/features/view/widgets/style_text.dart';

class RejectBtn extends StatelessWidget {
  final String text;
  final Color? color;
  final void Function()? onPressed;
  const RejectBtn({super.key, this.onPressed, required this.text, this.color});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        backgroundColor: color ?? errorred,
        foregroundColor: white,
      ),
      onPressed: onPressed,
      child: StyleText(text: text),
    );
  }
}

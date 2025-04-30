import 'package:flutter/material.dart';
import 'package:travelgo_organizer/core/constants/colors.dart';
import 'package:travelgo_organizer/features/view/widgets/style_text.dart';

class RegisterDailog extends StatelessWidget {
  final void Function()? onPressed;
  const RegisterDailog({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: StyleText(text:'Email already in use',),
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            backgroundColor: themeColor,
            foregroundColor: Colors.white,
          ),
          onPressed: onPressed,
          child: StyleText(text: 'Go back'),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:travelgo_organizer/features/view/widgets/actionful_btn.dart';

class EditEventFooter extends StatelessWidget {
  final String text;
  final Function()? nextonPressed;
  final Function()? prevonPressed;
  const EditEventFooter({
    super.key,
    required this.text,
    this.nextonPressed,
    this.prevonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ActionfulBtn(text: 'Prev', onPressed: prevonPressed),
        ActionfulBtn(text: text, onPressed: nextonPressed),
      ],
    );
  }
}

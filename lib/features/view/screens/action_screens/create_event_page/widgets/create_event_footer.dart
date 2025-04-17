import 'package:flutter/material.dart';
import 'package:travelgo_organizer/features/view/widgets/actionful_btn.dart';

class CreateEventFooter extends StatelessWidget {
  final Function()? nextonPressed;
  final Function()? prevonPressed;
  const CreateEventFooter({super.key, this.nextonPressed, this.prevonPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ActionfulBtn(text: 'Prev', onPressed: prevonPressed),
        ActionfulBtn(text: 'Next', onPressed: nextonPressed),
      ],
    );
  }
}

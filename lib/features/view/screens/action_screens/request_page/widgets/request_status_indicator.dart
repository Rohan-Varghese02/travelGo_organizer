import 'package:flutter/material.dart';
import 'package:travelgo_organizer/core/constants/colors.dart';
import 'package:travelgo_organizer/features/view/widgets/style_text.dart';

class RequestStatusIndicator extends StatelessWidget {
  final String status;
  const RequestStatusIndicator({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    if (status == 'Approved') {
      return container(status, success, white);
    } else if (status == 'Declined') {
      return container(status, errorred, black);
    } else {
      return container(status, amberYellow, black);
    }
  }

  Widget container(String status, Color color, Color textColor) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: StyleText(text: status, color: textColor),
    );
  }
}

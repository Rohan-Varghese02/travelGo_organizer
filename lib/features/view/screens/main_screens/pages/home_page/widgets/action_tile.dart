import 'package:flutter/material.dart';
import 'package:travelgo_organizer/core/constants/colors.dart';
import 'package:travelgo_organizer/features/view/widgets/style_text.dart';

class ActionTile extends StatelessWidget {
  final String assetImage;
  final String text;
  const ActionTile({super.key, required this.text, required this.assetImage});

  @override
  Widget build(BuildContext context) {
    return GridTile(
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              border: Border.all(color: grey20),
            ),
            child: CircleAvatar(
              backgroundColor: whiteBg,
              radius: 40,
              child: Image(
                image: AssetImage(assetImage),
                width: 25,
                height: 25,
                color: themeColor,
              ),
            ),
          ),
          SizedBox(height: 5),
          StyleText(text: text, color: grey99,),
        ],
      ),
    );
  }
}

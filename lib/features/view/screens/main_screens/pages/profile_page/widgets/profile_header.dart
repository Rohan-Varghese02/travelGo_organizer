import 'package:flutter/material.dart';
import 'package:travelgo_organizer/core/constants/colors.dart';
import 'package:travelgo_organizer/features/view/widgets/style_text.dart';

class ProfileHeader extends StatelessWidget {
  final int? folowers;
  final int? post;
  const ProfileHeader({super.key, required this.folowers, required this.post});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              StyleText(
                text: 'Members Following',
                size: 16,
                color: grey50,
                fontWeight: FontWeight.normal,
              ),
              StyleText(
                text: folowers.toString(),
                size: 22,
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
          Column(
            children: [
              StyleText(
                text: 'Events Hosted',
                size: 16,
                fontWeight: FontWeight.normal,
                color: grey50,
              ),
              StyleText(
                text: post.toString(),
                size: 22,
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

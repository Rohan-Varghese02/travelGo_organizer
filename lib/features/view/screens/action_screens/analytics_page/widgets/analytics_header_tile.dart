import 'package:flutter/material.dart';
import 'package:travelgo_organizer/core/constants/colors.dart';
import 'package:travelgo_organizer/features/view/widgets/style_text.dart';

class AnalyticsHeaderTile extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  const AnalyticsHeaderTile({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 190,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: black.withOpacity(0.1),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              StyleText(text: title, color: grey50, size: 12),
              SizedBox(height: 4),

              StyleText(text: value, fontWeight: FontWeight.bold, size: 18),
            ],
          ),
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: iconOuter,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(
              icon,
              color: iconViolet, // Deep Purple 600
              size: 20,
            ),
          ),
        ],
      ),
    );
  }
}

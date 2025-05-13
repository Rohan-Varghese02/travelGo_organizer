import 'package:flutter/material.dart';
import 'package:travelgo_organizer/core/constants/colors.dart';
import 'package:travelgo_organizer/data/models/revenue_data.dart';
import 'package:travelgo_organizer/features/view/widgets/style_text.dart';

class AnalyticsTile extends StatelessWidget {
  final RevenueModel revenueData;
  const AnalyticsTile({super.key, required this.revenueData});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(10),
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
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image(
                  image: NetworkImage(revenueData.postImage),
                  width: 100,
                  height: 120,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  StyleText(
                    text: revenueData.postName,
                    size: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(height: 5),
                  StyleText(
                    text: 'Ticket Sold: ${revenueData.totalTicketsSold}',
                    size: 13,
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(height: 5),

                  StyleText(
                    text:
                        'Ticket Variants: ${revenueData.revenueByTicketType.length}',
                    size: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
            ],
          ),
          StyleText(
            text: '₹ ${revenueData.totalRevenue.toString()}',
            size: 20,
            color: revenueData.totalRevenue == 0 ? black : iconViolet,
          ),
        ],
      ),
    );
  }
}

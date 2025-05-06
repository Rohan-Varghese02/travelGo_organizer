import 'dart:math';

import 'package:flutter/material.dart';
import 'package:travelgo_organizer/core/constants/colors.dart';
import 'package:travelgo_organizer/data/models/revenue_data.dart';
import 'package:travelgo_organizer/features/view/widgets/style_text.dart';

class TicketAnalytics extends StatelessWidget {
  final RevenueModel revenue;
  const TicketAnalytics({super.key, required this.revenue});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    final List<Color> lightColors = [
      Color(0xFFE0BBE4), // Light Violet
      Color(0xFFFFD1DC), // Light Red/Pink
      Color(0xFFADD8E6), // Light Blue
      Color(0xFFFFFFB3), // Light Yellow
    ];

    final _random = Random();

    Color getRandomLightColor() {
      return lightColors[_random.nextInt(lightColors.length)];
    }

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
            revenue.revenueByTicketType.entries.map((entry) {
              final ticketType = entry.key;
              final revenueData = entry.value as Map<String, dynamic>;
              final ticketRevenue = revenueData['revenue'] ?? 0;
              final soldCount = revenueData['soldCount'] ?? 0;

              return Container(
                width: width,
                margin: const EdgeInsets.symmetric(vertical: 6),
                padding: const EdgeInsets.all(10),
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
                // decoration: BoxDecoration(
                //   //color: getRandomLightColor(),
                //   borderRadius: BorderRadius.circular(8),
                // ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 10,
                          height: 40,
                          decoration: BoxDecoration(
                            color: getRandomLightColor(),
                            borderRadius: BorderRadiusDirectional.only(
                              topStart: Radius.circular(10),
                              bottomStart: Radius.circular(10),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        StyleText(
                          text: ticketType,
                          size: 24,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        StyleText(
                          text: '₹$ticketRevenue',
                          size: 20,
                          fontWeight: FontWeight.bold,
                          color: themeColor,
                        ),
                        StyleText(
                          text: '$soldCount sold',
                          size: 15,
                          fontWeight: FontWeight.w500,
                          color: grey99,
                        ),
                      ],
                    ),
                    // StyleText(
                    //   text:
                    //       '$ticketType - Sold: $soldCount | Revenue: ₹$ticketRevenue',
                    //   size: 16,
                    //   fontWeight: FontWeight.w600,
                    // ),
                  ],
                ),
              );
            }).toList(),
      ),
    );
  }
}

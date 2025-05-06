import 'package:flutter/material.dart';
import 'package:travelgo_organizer/core/constants/colors.dart';
import 'package:travelgo_organizer/data/models/revenue_data.dart';
import 'package:travelgo_organizer/features/view/screens/action_screens/analytics_page/widgets/analytics_header.dart';
import 'package:travelgo_organizer/features/view/screens/action_screens/analytics_page/widgets/ticket_analytics.dart';
import 'package:travelgo_organizer/features/view/widgets/custom_app_bar.dart';

class AnalyticsDetailed extends StatelessWidget {
  final RevenueModel revenue;
  const AnalyticsDetailed({super.key, required this.revenue});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Event Analytics',
        color: white,
        backgroundColor: themeColor,
        center: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image(
              image: NetworkImage(revenue.postImage),
              width: width,
              height: height * 0.3,
              fit: BoxFit.cover,
            ),
            AnalyticsHeader(
              name: revenue.postName,
              totalRevenue: revenue.totalRevenue.toString(),
              totalBookings: revenue.totalTicketsSold.toString(),
            ),
            TicketAnalytics(revenue: revenue),
          ],
        ),
      ),
    );
  }
}

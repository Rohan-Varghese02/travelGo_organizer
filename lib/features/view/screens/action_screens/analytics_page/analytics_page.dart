import 'package:flutter/material.dart';
import 'package:travelgo_organizer/core/constants/colors.dart';
import 'package:travelgo_organizer/core/services/stream_services.dart';
import 'package:travelgo_organizer/data/models/organizer_data.dart';
import 'package:travelgo_organizer/features/view/screens/action_screens/analytics_page/analytics_detailed.dart';
import 'package:travelgo_organizer/features/view/screens/action_screens/analytics_page/widgets/analytics_header_tile.dart';
import 'package:travelgo_organizer/features/view/screens/action_screens/analytics_page/widgets/analytics_tile.dart';
import 'package:travelgo_organizer/features/view/widgets/custom_app_bar.dart';
import 'package:travelgo_organizer/features/view/widgets/style_text.dart';

class AnalyticsPage extends StatelessWidget {
  final OrganizerDataModel organizerData;
  const AnalyticsPage({super.key, required this.organizerData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Analytics',
        color: white,
        center: true,
        backgroundColor: themeColor,
      ),
      body: StreamBuilder(
        stream: StreamServices().getRevenue(organizerData.uid),
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: StyleText(text: 'No Events Posted...'));
          }
          final revenues = snapshot.data!;
          // Total revenue and total bookings
          final revenueList = snapshot.data!;

          int totalRevenue = 0;
          int totalBookings = 0;

          for (var revenue in revenueList) {
            totalRevenue += revenue.totalRevenue;
            totalBookings += revenue.totalTicketsSold;
          }

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      AnalyticsHeaderTile(
                        title: 'Total Revenue',
                        value: totalRevenue.toString(),
                        icon: Icons.attach_money,
                      ),
                      SizedBox(width: 10),
                      AnalyticsHeaderTile(
                        title: 'Total Bookings',
                        value: totalBookings.toString(),
                        icon: Icons.attach_money,
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  StyleText(text: 'Events Revenue'),
                  SizedBox(height: 10),
                  ListView.separated(
                    shrinkWrap: true,
                    itemCount: revenues.length,
                    itemBuilder: (context, index) {
                      final revenue = revenues[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder:
                                  (context) =>
                                      AnalyticsDetailed(revenue: revenue),
                            ),
                          );
                        },
                        child: AnalyticsTile(revenueData: revenue),
                      );
                    },
                    separatorBuilder: (context, index) => SizedBox(height: 10),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

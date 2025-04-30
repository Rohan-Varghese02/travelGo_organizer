import 'package:flutter/material.dart';
import 'package:travelgo_organizer/core/constants/colors.dart';
import 'package:travelgo_organizer/data/models/post_data.dart';
import 'package:travelgo_organizer/features/view/screens/main_screens/pages/detailed_page/widgets/about_benefits.dart';
import 'package:travelgo_organizer/features/view/screens/main_screens/pages/detailed_page/widgets/detailed_app_bar.dart';
import 'package:travelgo_organizer/features/view/screens/main_screens/pages/detailed_page/widgets/event_pic.dart';
import 'package:travelgo_organizer/features/view/screens/main_screens/pages/detailed_page/widgets/geo_date.dart';
import 'package:travelgo_organizer/features/view/screens/main_screens/pages/detailed_page/widgets/ticket_price.dart';
import 'package:travelgo_organizer/features/view/widgets/long_button.dart';

class DetailedPage extends StatelessWidget {
  final PostDataModel post;
  const DetailedPage({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: DetailedAppBar(
        title: post.name,
        subtitle: post.category,
        backgroundColor: themeColor,
        showBack: true,
        color: white,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            EventPic(pic: post.imageUrl),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                width: width,
                decoration: BoxDecoration(
                  border: Border.all(color: themeColor),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AboutBenefits(
                        about: post.description,
                        benefits: post.benefits,
                      ),
                      SizedBox(height: 5),
                      TicketPrice(post: post),
                      GeoDate(
                        lat: post.latitude,
                        lon: post.longitude,
                        date: post.registrationDeadline,
                      ),
                      SizedBox(height: 20),
                      LongButton(
                        text: 'Clicked here to see registered clients',
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

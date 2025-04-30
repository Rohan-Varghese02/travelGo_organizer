import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travelgo_organizer/core/constants/colors.dart';
import 'package:travelgo_organizer/data/models/organizer_data.dart';
import 'package:travelgo_organizer/features/view/widgets/style_text.dart';

class HomePageHeader extends StatelessWidget {
  final OrganizerDataModel organizerData;
  const HomePageHeader({super.key, required this.organizerData});

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StyleText(text: 'Hello,', color: grey99, size: 18),
                SizedBox(height: 5),
                StyleText(
                  text: 'Hi ${organizerData.name}',
                  color: themeColor,
                  size: 20,
                ),
              ],
            ),
            CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(organizerData.imageUrl),
            ),
          ],
        ),
        SizedBox(height: 10),
        Container(
          width: size,
          decoration: BoxDecoration(
            color: themeColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StyleText(
                  text: organizerData.name,
                  color: white,
                  fontWeight: FontWeight.w700,
                  size: 16,
                ),
                SizedBox(height: 5),
                StyleText(text: '${organizerData.designation} at ${organizerData.company}', color: lightblue,size: 16,),
                SizedBox(height: 5),
                Divider(thickness: 0),
                SizedBox(height: 5),
                Row(
                  children: [
                    Icon(FontAwesomeIcons.user, size: 13, color: Colors.white),
                    SizedBox(width: 5),
                    StyleText(text: '${organizerData.followersCount} Followers', color: white,),
                  ],
                ),
                SizedBox(height: 15),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

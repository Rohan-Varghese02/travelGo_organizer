import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travelgo_organizer/core/constants/colors.dart';
import 'package:travelgo_organizer/data/models/organizer_data.dart';

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
                Text(
                  'Hello,',
                  style: GoogleFonts.poppins(color: grey99, fontSize: 18),
                ),
                SizedBox(height: 5),
                Text(
                  'Hi ${organizerData.name}',
                  style: GoogleFonts.poppins(color: themeColor, fontSize: 20),
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
                Text(
                  organizerData.name,
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  '${organizerData.designation} at ${organizerData.company}',
                  style: GoogleFonts.poppins(color: lightblue, fontSize: 16),
                ),
                SizedBox(height: 5),
                Divider(thickness: 0),
                SizedBox(height: 5),
                Row(
                  children: [
                    Icon(FontAwesomeIcons.user, size: 13, color: Colors.white),
                    SizedBox(width: 5),
                    Text(
                      '${organizerData.followersCount} Followers',
                      style: GoogleFonts.poppins(color: Colors.white),
                    ),
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

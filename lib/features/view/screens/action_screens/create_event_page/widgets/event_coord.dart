import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travelgo_organizer/core/constants/colors.dart';
import 'package:travelgo_organizer/features/view/widgets/custom_txt_field.dart';

class EventCoord extends StatelessWidget {
  final TextEditingController longitude;
  final TextEditingController lattitude;
  final String? Function(String?)? validator;
  const EventCoord({
    super.key,
    required this.longitude,
    required this.lattitude,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Event Coordinates',
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: width * 0.4,
              child: CustomTxtField(
                controller: lattitude,
                hint: 'Lattitude',
                radius: 30,
                borderColor: themeColor,
                validator: validator,
              ),
            ),
            SizedBox(
              width: width * 0.4,
              child: CustomTxtField(
                controller: longitude,
                hint: 'Longitude',
                radius: 30,
                borderColor: themeColor,
                validator: validator,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

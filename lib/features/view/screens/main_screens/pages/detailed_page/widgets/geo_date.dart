import 'package:flutter/material.dart';
import 'package:travelgo_organizer/core/constants/colors.dart';
import 'package:travelgo_organizer/features/view/widgets/style_text.dart';

class GeoDate extends StatelessWidget {
  final double lat;
  final double lon;
  final String date;
  const GeoDate({
    super.key,
    required this.lat,
    required this.lon,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StyleText(text: 'Geographic Location:',size: 18,fontWeight: FontWeight.w500,color: grey99,),
        StyleText(text: 'Lattitude : $lat', size: 16,),
        StyleText(text: 'Longitude : $lon', size: 16,),
        StyleText(text: 'Event Date : $date', size: 16,),
      ],
    );
  }
}

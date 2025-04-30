import 'package:flutter/material.dart';
import 'package:travelgo_organizer/core/constants/colors.dart';
import 'package:travelgo_organizer/features/view/widgets/style_text.dart';

class AboutBenefits extends StatelessWidget {
  final String about;
  final String benefits;
  const AboutBenefits({super.key, required this.about, required this.benefits});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StyleText(text:  'About Event',fontWeight: FontWeight.bold,size: 20,color: themeColor,),
        StyleText(text: about),
        SizedBox(height: 5),
        StyleText(text: 'Benefits:',size: 18,color: grey99,),
        StyleText(text: benefits),

        
      ],
    );
  }
}

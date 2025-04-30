import 'package:flutter/material.dart';
import 'package:travelgo_organizer/core/constants/colors.dart';
import 'package:travelgo_organizer/data/models/post_data.dart';
import 'package:travelgo_organizer/features/view/widgets/style_text.dart';

class TicketPrice extends StatelessWidget {
  final PostDataModel post;
  const TicketPrice({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StyleText(text: 'Tickets', size: 18,fontWeight: FontWeight.w500,color: grey99,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:
              post.tickets.entries.map((ticketEntry) {
                final ticketType = ticketEntry.key;
                final price = ticketEntry.value['price']; 
                return StyleText(text: '$ticketType : $price',size: 16,);
              }).toList(),
        ),
      ],
    );
  }
}

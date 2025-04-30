import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelgo_organizer/core/constants/colors.dart';
import 'package:travelgo_organizer/features/logic/action/action_bloc.dart';
import 'package:travelgo_organizer/features/view/widgets/style_text.dart';

class TicketHeader extends StatelessWidget {
  const TicketHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        StyleText(
          text: 'Tickets',
          size: 16,
          fontWeight: FontWeight.w500,
          color: black,
        ),
        IconButton(
          onPressed: () {
            context.read<ActionBloc>().add(AddTicket());
          },
          icon: Icon(Icons.add),
        ),
      ],
    );
  }
}

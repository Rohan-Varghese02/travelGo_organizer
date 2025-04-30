import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelgo_organizer/core/constants/colors.dart';
import 'package:travelgo_organizer/features/logic/action/action_bloc.dart';
import 'package:travelgo_organizer/features/view/widgets/style_text.dart';

class EditTicketHeader extends StatelessWidget {
  const EditTicketHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        StyleText(text: 'Tickets',size: 16,fontWeight: FontWeight.w500,color: black,),
        IconButton(
          onPressed: () {
            context.read<ActionBloc>().add(AddEditTicket());
          },
          icon: Icon(Icons.add),
        ),
      ],
    );
  }
}
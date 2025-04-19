import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travelgo_organizer/features/logic/action/action_bloc.dart';

class EditTicketHeader extends StatelessWidget {
  const EditTicketHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Tickets',
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
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
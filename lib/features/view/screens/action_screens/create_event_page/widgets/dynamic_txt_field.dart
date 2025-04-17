import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travelgo_organizer/core/constants/colors.dart';
import 'package:travelgo_organizer/features/logic/action/action_bloc.dart';

class DynamicTxtField extends StatelessWidget {
  final int index;
  final Map<String, String>? ticket;
  final String? Function(String?)? validator;
  const DynamicTxtField({super.key, required this.index, required this.ticket, this.validator});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Ticket Type Field
        Expanded(
          flex: 2,
          child: TextFormField(
            validator: validator,
            initialValue: ticket!["type"],
            onChanged: (val) {
              context.read<ActionBloc>().add(UpdateTicketType(index, val));
            },
            decoration: InputDecoration(
              hintText: 'Ticket Type',
              hintStyle: GoogleFonts.poppins(),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(40),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(40),
                borderSide: BorderSide(color: themeColor),
              ),
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Text(':'),
        ),
        // Ticket Count Field
        Expanded(
          flex: 1,
          child: TextFormField(
            validator: validator,
            initialValue: ticket!["count"],
            onChanged: (val) {
              context.read<ActionBloc>().add(UpdateTicketCount(index, val));
            },
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: 'Count',
              hintStyle: GoogleFonts.poppins(),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(40),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(40),
                borderSide: BorderSide(color: themeColor),
              ),
            ),
          ),
        ),
        // Delete Button (Only if more than 1 ticket exists)
        if (ticket != null)
          IconButton(
            icon: Icon(Icons.delete, color: themeColor),
            onPressed: () {
              context.read<ActionBloc>().add(RemoveTicket(index));
            },
          ),
      ],
    );
  }
}

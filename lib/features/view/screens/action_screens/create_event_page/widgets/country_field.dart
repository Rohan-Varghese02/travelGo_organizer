import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travelgo_organizer/core/constants/colors.dart';
import 'package:travelgo_organizer/features/logic/action/action_bloc.dart';

class CountryField extends StatelessWidget {
  const CountryField({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Destination of Event',
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        BlocBuilder<ActionBloc, ActionState>(
          buildWhen: (previous, current) => current is CountryLoaded,
          builder: (context, state) {
            if (state is CountryLoaded) {
              return DropdownButtonFormField<String>(
                value: state.selectedCountry,
                onChanged: (value) {
                  if (value != null) {
                    context.read<ActionBloc>().add(CategorySelected(value));
                  }
                },
                items:
                    state.countries
                        .map(
                          (cat) =>
                              DropdownMenuItem(value: cat, child: Text(cat)),
                        )
                        .toList(),
                decoration: InputDecoration(
                  hintText: 'Select Country',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: themeColor),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              );
            } else {
              return const CircularProgressIndicator(); // or SizedBox.shrink();
            }
          },
        ),
      ],
    );
  }
}

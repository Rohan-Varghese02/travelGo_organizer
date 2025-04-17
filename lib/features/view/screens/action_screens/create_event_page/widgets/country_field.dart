import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travelgo_organizer/core/constants/colors.dart';
import 'package:travelgo_organizer/features/logic/action/action_bloc.dart';

class CountryField extends StatelessWidget {
  final String? Function(String?)? validator;

  const CountryField({super.key, this.validator});

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
        const SizedBox(height: 8),
        BlocBuilder<ActionBloc, ActionState>(
          buildWhen: (previous, current) => current is CountryLoaded,
          builder: (context, state) {
            log(state.runtimeType.toString());
            if (state is CountryLoaded) {
              log('Working here');

              final uniqueCountries =
                  state.countries.map((e) => e.trim()).toSet().toList();

              final selected =
                  uniqueCountries.contains(state.selectedCountry)
                      ? state.selectedCountry
                      : null;

              return DropdownButtonFormField<String>(
                value: selected,
                validator: validator,
                onChanged: (value) {
                  if (value != null) {
                    context.read<ActionBloc>().add(
                      CountrySelected(selectedCountry: value),
                    );
                  }
                },
                items:
                    uniqueCountries
                        .map(
                          (country) => DropdownMenuItem(
                            value: country,
                            child: Text(country),
                          ),
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
              return const CircularProgressIndicator();
            }
          },
        ),
      ],
    );
  }
}

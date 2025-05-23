import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelgo_organizer/core/constants/colors.dart';
import 'package:travelgo_organizer/features/logic/action/action_bloc.dart';
import 'package:travelgo_organizer/features/view/widgets/style_text.dart';

class EditCountry extends StatelessWidget {
  final String? Function(String?)? validator;
  final String country;

  const EditCountry({super.key, this.validator, required this.country});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StyleText(text: 'Destination of Event',size: 16,fontWeight: FontWeight.w500,color: black,),
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
                      : country;

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

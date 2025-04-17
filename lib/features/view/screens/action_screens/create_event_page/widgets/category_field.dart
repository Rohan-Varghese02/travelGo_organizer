import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travelgo_organizer/core/constants/colors.dart';
import 'package:travelgo_organizer/features/logic/action/action_bloc.dart';

class CategoryField extends StatelessWidget {
  const CategoryField({super.key, this.validator});
  final String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Category of Event',
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        BlocBuilder<ActionBloc, ActionState>(
          buildWhen: (previous, current) => current is CategoriesLoaded,
          builder: (context, state) {
            if (state is CategoriesLoaded) {
              return DropdownButtonFormField<String>(
                validator: validator,
                value: state.selectedCategory,
                onChanged: (value) {
                  if (value != null) {
                    context.read<ActionBloc>().add(CategorySelected(value));
                  }
                },
                items:
                    state.categories
                        .map(
                          (cat) =>
                              DropdownMenuItem(value: cat, child: Text(cat)),
                        )
                        .toList(),
                decoration: InputDecoration(
                  hintText: 'Select Category',
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

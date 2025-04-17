import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travelgo_organizer/core/constants/colors.dart';

class LastDatePicker extends StatelessWidget {
  final TextEditingController lastDateController;
  final String? Function(String?)? validator;

  const LastDatePicker({super.key, required this.lastDateController, this.validator});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Last Date of Registeration',
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
          
        ),
        GestureDetector(
          onTap: () async {
            final DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime(2100),
            );

            if (pickedDate != null) {
              final formatted =
                  "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
              lastDateController.text = formatted;
            }
          },
          child: AbsorbPointer(
            child: TextFormField(
              validator: validator,
              controller: lastDateController,
              decoration: InputDecoration(
                labelText: 'Last Date of Event',
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: themeColor),
                  borderRadius: BorderRadius.circular(8),
                ),
                suffixIcon: Icon(Icons.calendar_today, color: themeColor),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

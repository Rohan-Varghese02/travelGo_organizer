import 'package:flutter/material.dart';
import 'package:travelgo_organizer/core/constants/colors.dart';
import 'package:travelgo_organizer/features/view/widgets/style_text.dart';

class LastDatePicker extends StatelessWidget {
  final TextEditingController lastDateController;
  final String? Function(String?)? validator;

  const LastDatePicker({
    super.key,
    required this.lastDateController,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StyleText(
          text: 'Date of Event',
          size: 16,
          fontWeight: FontWeight.w500,
          color: black,
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
                hintText: 'Event Date',
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

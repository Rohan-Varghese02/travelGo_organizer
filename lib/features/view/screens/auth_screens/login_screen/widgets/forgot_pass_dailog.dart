import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travelgo_organizer/core/constants/colors.dart';
import 'package:travelgo_organizer/features/logic/auth/auth_bloc.dart';
import 'package:travelgo_organizer/features/view/widgets/style_text.dart';

void forgotPasswordDailog(BuildContext context) {
  final TextEditingController controller = TextEditingController();
  final keystate = GlobalKey<FormState>();

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        title: StyleText(text: "Forgot password",color: themeColor,),
        content: Form(
          key: keystate,
          child: SizedBox(
            height: 130,
            child: Column(
              children: [
                TextFormField(
                  controller: controller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    hintText: "Enter your email address",
                    hintStyle: GoogleFonts.poppins(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter the field';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                StyleText(
                  text:
                      'Link will be sent to the given email address to reset the password',
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: StyleText(text: 'Cancel', color: black),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: themeColor,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () async {
              if (keystate.currentState!.validate()) {
                context.read<AuthBloc>().add(
                  ResetPasswordEvent(email: controller.text),
                );
                Navigator.of(context).pop();
              }
            },
            child: StyleText(text: 'Send'),
          ),
        ],
      );
    },
  );
}

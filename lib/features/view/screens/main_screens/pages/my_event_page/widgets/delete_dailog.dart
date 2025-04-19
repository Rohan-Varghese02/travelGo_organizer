import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travelgo_organizer/core/constants/colors.dart';
import 'package:travelgo_organizer/data/models/post_data.dart';
import 'package:travelgo_organizer/features/logic/action/action_bloc.dart';

void deleteDailog(BuildContext context, PostDataModel post) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        title: Text("Delete", style: GoogleFonts.poppins(color: themeColor)),
        content: Text.rich(
          TextSpan(
            text: 'Do you really wish to delete the event ',
            style: GoogleFonts.poppins(),
            children: [
              TextSpan(
                text: post.name,
                style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              "Cancel",
              style: GoogleFonts.poppins(color: Colors.black),
            ),
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
              context.read<ActionBloc>().add(DeletePostIntiated(post: post));
              Navigator.of(context).pop();
            },
            child: Text("Delete", style: GoogleFonts.poppins()),
          ),
        ],
      );
    },
  );
}

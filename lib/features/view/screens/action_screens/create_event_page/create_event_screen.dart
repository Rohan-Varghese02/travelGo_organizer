import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travelgo_organizer/core/constants/colors.dart';
import 'package:travelgo_organizer/features/logic/action/action_bloc.dart';
import 'package:travelgo_organizer/features/view/screens/action_screens/create_event_page/widgets/cover_photo.dart';
import 'package:travelgo_organizer/features/view/screens/action_screens/create_event_page/widgets/event_coord.dart';
import 'package:travelgo_organizer/features/view/widgets/heading_text_field.dart';

class CreateEventScreen extends StatefulWidget {
  const CreateEventScreen({super.key});

  @override
  State<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();
    TextEditingController venueController = TextEditingController();
    TextEditingController destinationController = TextEditingController();
    TextEditingController benefitsController = TextEditingController();
    TextEditingController organizerGrpController = TextEditingController();
    TextEditingController lattitudeController = TextEditingController();
    TextEditingController longitudeController = TextEditingController();
    return BlocBuilder<ActionBloc, ActionState>(
      builder: (context, state) {
        String? imagePath;
        // String? imageUrl;
        // String? imagePublicId;
        if (state is CoverImagePicked) {
          imagePath = state.imagePath;
          log(imagePath);
        }
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Create Event',
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: themeColor,
              ),
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HeadingTextField(
                    headline: 'Event Name:',
                    controller: nameController,
                    hint: 'Name of Event',
                    borderColor: themeColor,
                  ),
                  SizedBox(height: 20),
                  CoverPhoto(imagePath: imagePath),
                  SizedBox(height: 20),
                  HeadingTextField(
                    headline: 'Description of Event:',
                    controller: descriptionController,
                    hint: 'Event Description',
                    borderColor: themeColor,
                  ),
                  SizedBox(height: 20),

                  HeadingTextField(
                    headline: 'Venue of Event:',
                    controller: venueController,
                    hint: 'Event Venue',
                    borderColor: themeColor,
                  ),
                  SizedBox(height: 20),

                  HeadingTextField(
                    headline: 'Destination of Event:',
                    controller: destinationController,
                    hint: 'Event Destination',
                    borderColor: themeColor,
                  ),
                  SizedBox(height: 20),

                  HeadingTextField(
                    headline: 'Benefits of Each ticket:',
                    controller: benefitsController,
                    hint: 'Ticket Benefits',
                    borderColor: themeColor,
                  ),
                  SizedBox(height: 20),

                  HeadingTextField(
                    headline: 'Organizer Group Name:',
                    controller: organizerGrpController,
                    hint: 'Organizer Group',
                    borderColor: themeColor,
                  ),
                  SizedBox(height: 20),

                  EventCoord(lattitude: lattitudeController, longitude: longitudeController,),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

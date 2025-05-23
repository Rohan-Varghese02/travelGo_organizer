import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelgo_organizer/core/constants/colors.dart';
import 'package:travelgo_organizer/features/logic/action/action_bloc.dart';
import 'package:travelgo_organizer/features/view/screens/action_screens/create_event_page/create_next_page.dart';
import 'package:travelgo_organizer/features/view/screens/action_screens/create_event_page/widgets/country_field.dart';
import 'package:travelgo_organizer/features/view/screens/action_screens/create_event_page/widgets/cover_photo.dart';
import 'package:travelgo_organizer/features/view/screens/action_screens/create_event_page/widgets/create_event_footer.dart';
import 'package:travelgo_organizer/features/view/widgets/custom_app_bar.dart';

import 'package:travelgo_organizer/features/view/widgets/heading_text_field.dart';

class CreateEventScreen extends StatefulWidget {
  const CreateEventScreen({super.key});

  @override
  State<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ActionBloc>().add(LoadCountries());
  }

  @override
  Widget build(BuildContext context) {
    String? country;
    TextEditingController nameController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();
    TextEditingController venueController = TextEditingController();

    final keystate = GlobalKey<FormState>();
    return BlocConsumer<ActionBloc, ActionState>(
      listenWhen:
          (previous, current) =>
              current is NoCoverImage ||
              current is CountryLoaded ||
              current is CountryChoosed,
      listener: (BuildContext context, ActionState state) {
        log(state.runtimeType.toString());
        if (state is NoCoverImage) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('No Cover Image'),
              backgroundColor: errorred,
            ),
          );
        }
        if (state is CountryChoosed) {
          country = state.selectedCountry;
        }
      },
      buildWhen:
          (previous, current) =>
              current is CoverImagePicked || current is CountryLoaded,
      builder: (context, state) {
        log(state.runtimeType.toString());
        String? imagePath;
        if (state is CoverImagePicked) {
          imagePath = state.imagePath;
          log(imagePath);
        }
        return Scaffold(
          appBar: CustomAppBar(
            title: 'Create Event',
            color: themeColor,
            center: true,
            showBack: false,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                key: keystate,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HeadingTextField(
                      headline: 'Event Name:',
                      controller: nameController,
                      hint: 'Name of Event',
                      borderColor: themeColor,
                      validator: (p0) {
                        return validator(p0, 'Name');
                      },
                    ),
                    SizedBox(height: 20),
                    CoverPhoto(imagePath: imagePath),
                    SizedBox(height: 20),
                    HeadingTextField(
                      headline: 'Description of Event:',
                      controller: descriptionController,
                      hint: 'Event Description',
                      borderColor: themeColor,
                      validator: (p0) {
                        return validator(p0, 'Description');
                      },
                    ),
                    SizedBox(height: 20),

                    HeadingTextField(
                      headline: 'Venue of Event:',
                      controller: venueController,
                      hint: 'Event Venue',
                      borderColor: themeColor,
                      validator: (p0) {
                        return validator(p0, 'Venue');
                      },
                    ),
                    SizedBox(height: 20),
                    CountryField(
                      validator: (p0) {
                        return validator(p0, 'Country');
                      },
                    ),
                    SizedBox(height: 10),

                    SizedBox(height: 20),

                    CreateEventFooter(
                      nextonPressed: () {
                        if (keystate.currentState!.validate()) {
                          if (imagePath == null) {
                            context.read<ActionBloc>().add(
                              CoverImageNotFound(),
                            );
                          } else {
                            log(nameController.text);
                            log(descriptionController.text);
                            log(venueController.text);
                            log(country.toString());
                            log(imagePath);

                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder:
                                    (context) => CreateNextPage(
                                      name: nameController.text,
                                      imagePath: imagePath!,
                                      description: descriptionController.text,
                                      venue: venueController.text,
                                      country: country!,
                                    ),
                              ),
                            );
                          }
                        }
                      },
                      prevonPressed: () {
                        Navigator.of(context).pop();
                      },
                      text: 'Next',
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  String? validator(value, String message) {
    if (value == null || value.isEmpty) {
      return 'Enter $message';
    }
    return null;
  }
}

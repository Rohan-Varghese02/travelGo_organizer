import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travelgo_organizer/core/constants/colors.dart';
import 'package:travelgo_organizer/data/models/post_data.dart';
import 'package:travelgo_organizer/features/logic/action/action_bloc.dart';
import 'package:travelgo_organizer/features/view/screens/main_screens/pages/my_event_page/edit_page/edit_next_page.dart';
import 'package:travelgo_organizer/features/view/screens/main_screens/pages/my_event_page/edit_page/widgets/edit_country.dart';
import 'package:travelgo_organizer/features/view/screens/main_screens/pages/my_event_page/edit_page/widgets/edit_cover_pic.dart';
import 'package:travelgo_organizer/features/view/screens/main_screens/pages/my_event_page/edit_page/widgets/edit_event_footer.dart';
import 'package:travelgo_organizer/features/view/widgets/heading_text_field.dart';

class EditPage extends StatefulWidget {
  final PostDataModel post;
  const EditPage({super.key, required this.post});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  @override
  void initState() {
    super.initState();
    context.read<ActionBloc>().add(LoadCountries());
  }

  String? country;
  final keystate = GlobalKey<FormState>();

  String? imagePath;

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController(
      text: widget.post.name,
    );
    TextEditingController descriptionController = TextEditingController(
      text: widget.post.description,
    );
    TextEditingController venueController = TextEditingController(
      text: widget.post.venue,
    );

    return BlocConsumer<ActionBloc, ActionState>(
      listener: (context, state) {
        log(state.runtimeType.toString());
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
          appBar: AppBar(
            //automaticallyImplyLeading: false,
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
                        return validator(p0);
                      },
                    ),
                    SizedBox(height: 20),
                    EditCoverPic(
                      imagePath: imagePath,
                      url: widget.post.imageUrl,
                    ),
                    SizedBox(height: 20),
                    HeadingTextField(
                      headline: 'Description of Event:',
                      controller: descriptionController,
                      hint: 'Event Description',
                      borderColor: themeColor,
                      validator: (p0) {
                        return validator(p0);
                      },
                    ),
                    SizedBox(height: 20),

                    HeadingTextField(
                      headline: 'Venue of Event:',
                      controller: venueController,
                      hint: 'Event Venue',
                      borderColor: themeColor,
                      validator: (p0) {
                        return validator(p0);
                      },
                    ),
                    SizedBox(height: 20),

                    EditCountry(
                      country: widget.post.country,
                      validator: (p0) {
                        return validator(p0);
                      },
                    ),
                    SizedBox(height: 10),
                    EditEventFooter(
                      text: 'Next',
                      prevonPressed: () {
                        Navigator.of(context).pop();
                      },
                      nextonPressed: () {
                        if (keystate.currentState!.validate()) {
                          log(nameController.text);
                          log(imagePath.toString());
                          log(descriptionController.text);
                          log(venueController.text);
                          country ??= widget.post.country;
                          log(country.toString());
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder:
                                  (context) => EditNextPage(
                                    name: nameController.text,
                                    imagePath: imagePath ?? 'default',
                                    description: descriptionController.text,
                                    venue: venueController.text,
                                    country: country!,
                                    post: widget.post,
                                  ),
                            ),
                          );
                        }
                      },
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  String? validator(value) {
    if (value == null || value.isEmpty) {
      return 'Fill the TextField';
    }
    return null;
  }
}

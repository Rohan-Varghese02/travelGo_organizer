import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travelgo_organizer/core/constants/colors.dart';
import 'package:travelgo_organizer/features/logic/action/action_bloc.dart';
import 'package:travelgo_organizer/features/view/screens/action_screens/create_event_page/widgets/category_field.dart';
import 'package:travelgo_organizer/features/view/screens/action_screens/create_event_page/widgets/country_field.dart';
import 'package:travelgo_organizer/features/view/screens/action_screens/create_event_page/widgets/cover_photo.dart';
import 'package:travelgo_organizer/features/view/screens/action_screens/create_event_page/widgets/create_event_footer.dart';
import 'package:travelgo_organizer/features/view/screens/action_screens/create_event_page/widgets/dynamic_txt_field.dart';
import 'package:travelgo_organizer/features/view/screens/action_screens/create_event_page/widgets/event_coord.dart';
import 'package:travelgo_organizer/features/view/screens/action_screens/create_event_page/widgets/last_date_picker.dart';
import 'package:travelgo_organizer/features/view/screens/action_screens/create_event_page/widgets/ticket_header.dart';
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
    context.read<ActionBloc>().add(LoadCategories());
    context.read<ActionBloc>().add(LoadCountries());
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();
    TextEditingController venueController = TextEditingController();
    TextEditingController benefitsController = TextEditingController();
    TextEditingController organizerGrpController = TextEditingController();
    TextEditingController lattitudeController = TextEditingController();
    TextEditingController longitudeController = TextEditingController();
    final TextEditingController lastDateController = TextEditingController();

    String? category;
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
                  CountryField(),
                  SizedBox(height: 10),
                  TicketHeader(),
                  BlocBuilder<ActionBloc, ActionState>(
                    builder: (context, state) {
                      if (state is TicketsUpdated) {
                        return ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: state.tickets.length,
                          itemBuilder: (context, index) {
                            return DynamicTxtField(
                              index: index,
                              ticket: state.tickets[index],
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return SizedBox(height: 10);
                          },
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
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
                  SizedBox(height: 10),

                  EventCoord(
                    lattitude: lattitudeController,
                    longitude: longitudeController,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      final state = context.read<ActionBloc>().state;
                      if (state is CategoriesLoaded &&
                          state.selectedCategory != null) {
                        category = state.selectedCategory;
                        log('Selected Category: $category');
                      }
                      if (state is TicketsUpdated) {
                        final Map<String, int> ticketMap = {};

                        for (var ticket in state.tickets) {
                          final type = ticket['type']?.trim();
                          final countStr = ticket['count']?.trim();

                          if (type != null &&
                              countStr != null &&
                              type.isNotEmpty &&
                              int.tryParse(countStr) != null) {
                            ticketMap[type] = int.parse(countStr);
                          }
                        }

                        log('Tickets Map: $ticketMap');
                        log(category.toString());
                      } else {
                        log('No ticket data available.');
                      }
                    },
                    child: const Text('Log Tickets'),
                  ),
                  CategoryField(),
                  SizedBox(height: 20),
                  LastDatePicker(lastDateController: lastDateController),
                  SizedBox(height: 20),

                  CreateEventFooter(nextonPressed: () {}, prevonPressed: () {}),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

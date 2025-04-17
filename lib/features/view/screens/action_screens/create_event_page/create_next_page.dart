import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travelgo_organizer/core/constants/colors.dart';
import 'package:travelgo_organizer/features/logic/action/action_bloc.dart';
import 'package:travelgo_organizer/features/view/screens/action_screens/create_event_page/widgets/category_field.dart';
import 'package:travelgo_organizer/features/view/screens/action_screens/create_event_page/widgets/create_event_footer.dart';
import 'package:travelgo_organizer/features/view/screens/action_screens/create_event_page/widgets/dynamic_txt_field.dart';
import 'package:travelgo_organizer/features/view/screens/action_screens/create_event_page/widgets/event_coord.dart';
import 'package:travelgo_organizer/features/view/screens/action_screens/create_event_page/widgets/last_date_picker.dart';
import 'package:travelgo_organizer/features/view/screens/action_screens/create_event_page/widgets/ticket_header.dart';
import 'package:travelgo_organizer/features/view/widgets/heading_text_field.dart';

class CreateNextPage extends StatefulWidget {
  final String name;
  final String imagePath;
  final String description;
  final String venue;
  final String country;

  const CreateNextPage({
    super.key,
    required this.name,
    required this.imagePath,
    required this.description,
    required this.venue,
    required this.country,
  });

  @override
  State<CreateNextPage> createState() => _CreateNextPageState();
}

class _CreateNextPageState extends State<CreateNextPage> {
  @override
  void initState() {
    super.initState();
    context.read<ActionBloc>().add(LoadCategories());
    log(widget.name);
    log(widget.imagePath);
    log(widget.description);
    log(widget.venue);
    log(widget.country);
  }

  TextEditingController benefitsController = TextEditingController();
  TextEditingController organizerGrpController = TextEditingController();
  TextEditingController lattitudeController = TextEditingController();
  TextEditingController longitudeController = TextEditingController();
  final TextEditingController lastDateController = TextEditingController();
  final keyState = GlobalKey<FormState>();
  final Map<String, int> ticketMap = {};
  String? category;

  @override
  Widget build(BuildContext context) {
    return BlocListener<ActionBloc, ActionState>(
      listener: (context, state) {
        if (state is CategoryChoosed) {
          category = state.selectedCategory;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          // automaticallyImplyLeading: false,
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
              key: keyState,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TicketHeader(),
                  BlocBuilder<ActionBloc, ActionState>(
                    buildWhen: (previous, current) => current is TicketsUpdated,
                    builder: (context, state) {
                      if (state is TicketsUpdated) {
                        ticketMap.clear(); // Optional: clear before updating
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

                        return ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: state.tickets.length,
                          itemBuilder: (context, index) {
                            return DynamicTxtField(
                              validator: (p0) => validator(p0),
                              index: index,
                              ticket: state.tickets[index],
                            );
                          },
                          separatorBuilder:
                              (context, index) => const SizedBox(height: 10),
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
                    validator: (p0) {
                      return validator(p0);
                    },
                  ),
                  SizedBox(height: 20),

                  HeadingTextField(
                    headline: 'Organizer Group Name:',
                    controller: organizerGrpController,
                    hint: 'Organizer Group',
                    borderColor: themeColor,
                    validator: (p0) {
                      return validator(p0);
                    },
                  ),
                  SizedBox(height: 10),

                  EventCoord(
                    validator: (p0) {
                      return validator(p0);
                    },
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
                      } else {
                        log(category.toString());
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
                      } else {
                        log('No ticket data available.');
                      }
                    },
                    child: const Text('Log Tickets'),
                  ),
                  CategoryField(
                    validator: (p0) {
                      return validator(p0);
                    },
                  ),
                  SizedBox(height: 20),
                  LastDatePicker(
                    lastDateController: lastDateController,
                    validator: (p0) {
                      return validator(p0);
                    },
                  ),
                  SizedBox(height: 20),

                  CreateEventFooter(
                    nextonPressed: () {
                      if (keyState.currentState!.validate()) {
                        log(ticketMap.toString());
                        log(benefitsController.text);
                        log(organizerGrpController.text);
                        log(lastDateController.text);
                        log(lattitudeController.text);
                        log(longitudeController.text);
                        log(category.toString());
                      }
                    },
                    prevonPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String? validator(value) {
    if (value == null || value.isEmpty) {
      return 'Fill the TextField';
    }
    return null;
  }
}

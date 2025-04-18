import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travelgo_organizer/core/constants/colors.dart';
import 'package:travelgo_organizer/core/services/auth/authservice.dart';
import 'package:travelgo_organizer/data/models/post_data.dart';
import 'package:travelgo_organizer/features/logic/action/action_bloc.dart';
import 'package:travelgo_organizer/features/view/screens/action_screens/create_event_page/widgets/dynamic_txt_field.dart';
import 'package:travelgo_organizer/features/view/screens/action_screens/create_event_page/widgets/event_coord.dart';
import 'package:travelgo_organizer/features/view/screens/action_screens/create_event_page/widgets/last_date_picker.dart';
import 'package:travelgo_organizer/features/view/screens/action_screens/create_event_page/widgets/ticket_header.dart';
import 'package:travelgo_organizer/features/view/widgets/heading_text_field.dart';

class EditNextPage extends StatefulWidget {
  final String name;
  final String imagePath;
  final String description;
  final String venue;
  final String country;
  final PostDataModel post;
  const EditNextPage({
    super.key,
    required this.name,
    required this.imagePath,
    required this.description,
    required this.venue,
    required this.country,
    required this.post,
  });

  @override
  State<EditNextPage> createState() => _EditNextPageState();
}

class _EditNextPageState extends State<EditNextPage> {
  String uid = '';
  final keyState = GlobalKey<FormState>();
  final Map<String, Map<String, int>> ticketMap = {};
  String? category;
  @override
  void initState() {
    super.initState();
    uid = Authservice().getUserUid();
    context.read<ActionBloc>().add(LoadCategories());

    final tickets =
        widget.post.tickets.entries.map((entry) {
          return {
            'type': entry.key,
            'price': entry.value['price'].toString(),
            'count': entry.value['count'].toString(),
          };
        }).toList();

    context.read<ActionBloc>().add(UpdateTicketList(tickets));
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController benefitsController = TextEditingController(
      text: widget.post.benefits,
    );
    TextEditingController organizerGrpController = TextEditingController(
      text: widget.post.group,
    );
    TextEditingController lattitudeController = TextEditingController(
      text: widget.post.latitude.toString(),
    );
    TextEditingController longitudeController = TextEditingController(
      text: widget.post.longitude.toString(),
    );
    final TextEditingController lastDateController = TextEditingController(
      text: widget.post.registrationDeadline,
    );
    log(widget.post.tickets.toString());
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        title: Text(
          'Edit Event',
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
                      ticketMap.clear();
                      for (var ticket in state.tickets) {
                        final type = ticket['type']?.trim();
                        final priceStr = ticket['price']?.trim();
                        final countStr = ticket['count']?.trim();

                        if (type != null &&
                            priceStr != null &&
                            countStr != null &&
                            type.isNotEmpty &&
                            int.tryParse(countStr) != null &&
                            int.tryParse(priceStr) != null) {
                          ticketMap[type] = {
                            'price': int.parse(priceStr),
                            'count': int.parse(countStr),
                          };
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
                // CategoryField(
                //   validator: (p0) {
                //     return validator(p0);
                //   },
                // ),
                SizedBox(height: 20),
                LastDatePicker(
                  lastDateController: lastDateController,
                  validator: (p0) {
                    return validator(p0);
                  },
                ),
                SizedBox(height: 20),

                // CreateEventFooter(
                //   nextonPressed: () {
                //     if (keyState.currentState!.validate()) {
                //       double? lat = double.tryParse(lattitudeController.text);
                //       double? lon = double.tryParse(longitudeController.text);
                //       log(uid);
                //       log(ticketMap.toString());
                //       log(benefitsController.text);
                //       log(organizerGrpController.text);
                //       log(lastDateController.text);
                //       print(lat);
                //       print(lon);
                //       log(category.toString());
                //       context.read<ActionBloc>().add(
                //         UploadCoverPhoto(
                //           uid: uid,
                //           name: widget.name,
                //           description: widget.description,
                //           venue: widget.venue,
                //           imagePath: widget.imagePath!,
                //           country: widget.country,
                //           tickets: ticketMap,
                //           benefits: benefitsController.text,
                //           group: organizerGrpController.text,
                //           registrationDeadline: lastDateController.text,
                //           latitude: lat!,
                //           longitude: lon!,
                //           category: category!,
                //         ),
                //       );
                //     }
                //   },
                //   prevonPressed: () {
                //     Navigator.of(context).pop();
                //   },
                //   text: 'Host',
                // ),
              ],
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

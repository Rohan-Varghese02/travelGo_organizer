import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelgo_organizer/core/constants/colors.dart';
import 'package:travelgo_organizer/core/services/auth/authservice.dart';
import 'package:travelgo_organizer/data/models/post_data.dart';
import 'package:travelgo_organizer/features/logic/action/action_bloc.dart';
import 'package:travelgo_organizer/features/view/screens/action_screens/create_event_page/widgets/event_coord.dart';
import 'package:travelgo_organizer/features/view/screens/action_screens/create_event_page/widgets/last_date_picker.dart';
import 'package:travelgo_organizer/features/view/screens/main_screens/pages/my_event_page/edit_page/widgets/dynamic_txt_field_edit.dart';
import 'package:travelgo_organizer/features/view/screens/main_screens/pages/my_event_page/edit_page/widgets/edit_country_field.dart';
import 'package:travelgo_organizer/features/view/screens/main_screens/pages/my_event_page/edit_page/widgets/edit_event_footer.dart';
import 'package:travelgo_organizer/features/view/screens/main_screens/pages/my_event_page/edit_page/widgets/edit_ticket_header.dart';
import 'package:travelgo_organizer/features/view/widgets/heading_text_field.dart';
import 'package:travelgo_organizer/features/view/widgets/style_text.dart';

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

    context.read<ActionBloc>().add(LoadEditTickets(tickets));
  }

  final logMap = <String, Map<String, int>>{};
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
    return BlocListener<ActionBloc, ActionState>(
      listener: (context, state) {
        if (state is CategoryChoosed) {
          category = state.selectedCategory;
        }
        if (state is UpdatePostIntiateState) {
          context.read<ActionBloc>().add(UpdatePostIntiated(post: state.post));
        }
        if (state is UpdatePostSuccess) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Edited Post Successfuly'),
                backgroundColor: success,
              ),
            );
          });
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          // automaticallyImplyLeading: false,
          title: StyleText(text: 'Edit Event', size: 24,color: themeColor,fontWeight: FontWeight.w600,),
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
                  EditTicketHeader(),
                  BlocBuilder<ActionBloc, ActionState>(
                    buildWhen: (prev, curr) => curr is EditTicketsUpdated,
                    builder: (context, state) {
                      if (state is EditTicketsUpdated) {
                        logMap.clear(); // <--- Add this line

                        for (var ticket in state.tickets) {
                          final type = ticket['type']?.trim();
                          final price = ticket['price']?.trim();
                          final count = ticket['count']?.trim();
                          if (type != null &&
                              price != null &&
                              count != null &&
                              type.isNotEmpty &&
                              int.tryParse(price) != null &&
                              int.tryParse(count) != null) {
                            logMap[type] = {
                              'price': int.parse(price),
                              'count': int.parse(count),
                            };
                          }
                        }
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListView.separated(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: state.tickets.length,
                              itemBuilder: (context, index) {
                                return DynamicTxtFieldEdit(
                                  validator: (p0) => validator(p0),
                                  index: index,
                                  ticket: state.tickets[index],
                                  isEdit: true,
                                );
                              },
                              separatorBuilder:
                                  (context, index) => SizedBox(height: 10),
                            ),
                          ],
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
                  EditCategoryField(
                    validator: (p0) {
                      return validator(p0);
                    },
                    text: widget.post.category,
                  ),
                  SizedBox(height: 20),
                  LastDatePicker(
                    lastDateController: lastDateController,
                    validator: (p0) {
                      return validator(p0);
                    },
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      log(logMap.toString());
                    },
                    child: Text('test'),
                  ),
                  EditEventFooter(
                    text: 'Update',
                    nextonPressed: () {
                      if (keyState.currentState!.validate()) {
                        double? lat = double.tryParse(lattitudeController.text);
                        double? lon = double.tryParse(longitudeController.text);
                        category ??= widget.post.category;
                        context.read<ActionBloc>().add(
                          UpdateCoverPhotoEvent(
                            post: widget.post,
                            uid: uid,
                            name: widget.name,
                            description: widget.description,
                            venue: widget.venue,
                            imagePath: widget.imagePath,
                            country: widget.country,
                            tickets: logMap,
                            benefits: benefitsController.text,
                            group: organizerGrpController.text,
                            registrationDeadline: lastDateController.text,
                            latitude: lat!,
                            longitude: lon!,
                            category: category!,
                            imageUrl: widget.post.imageUrl,
                            imagePublicId: widget.post.imagePublicId,
                          ),
                        );
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

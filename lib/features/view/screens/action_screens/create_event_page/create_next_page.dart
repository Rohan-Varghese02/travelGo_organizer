import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelgo_organizer/core/constants/colors.dart';
import 'package:travelgo_organizer/core/services/auth/authservice.dart';
import 'package:travelgo_organizer/data/models/post_data.dart';
import 'package:travelgo_organizer/features/logic/action/action_bloc.dart';
import 'package:travelgo_organizer/features/view/screens/action_screens/create_event_page/widgets/category_field.dart';
import 'package:travelgo_organizer/features/view/screens/action_screens/create_event_page/widgets/create_event_footer.dart';
import 'package:travelgo_organizer/features/view/screens/action_screens/create_event_page/widgets/dynamic_txt_field.dart';
import 'package:travelgo_organizer/features/view/screens/action_screens/create_event_page/widgets/event_coord.dart';
import 'package:travelgo_organizer/features/view/screens/action_screens/create_event_page/widgets/last_date_picker.dart';
import 'package:travelgo_organizer/features/view/screens/action_screens/create_event_page/widgets/ticket_header.dart';
import 'package:travelgo_organizer/features/view/widgets/custom_app_bar.dart';
import 'package:travelgo_organizer/features/view/widgets/heading_text_field.dart';

class CreateNextPage extends StatefulWidget {
  final String name;
  final String? imagePath;
  final String description;
  final String venue;
  final String country;

  const CreateNextPage({
    super.key,
    required this.name,
    this.imagePath,
    required this.description,
    required this.venue,
    required this.country,
  });

  @override
  State<CreateNextPage> createState() => _CreateNextPageState();
}

class _CreateNextPageState extends State<CreateNextPage> {
  String uid = '';
  @override
  void initState() {
    super.initState();
    uid = Authservice().getUserUid();
    context.read<ActionBloc>().add(LoadCategories());
  }

  TextEditingController benefitsController = TextEditingController();
  TextEditingController organizerGrpController = TextEditingController();
  TextEditingController lattitudeController = TextEditingController();
  TextEditingController longitudeController = TextEditingController();
  final TextEditingController lastDateController = TextEditingController();
  final keyState = GlobalKey<FormState>();
  final Map<String, Map<String, int>> ticketMap = {};
  String? category;

  @override
  Widget build(BuildContext context) {
    return BlocListener<ActionBloc, ActionState>(
      listener: (context, state) {
        if (state is CategoryChoosed) {
          category = state.selectedCategory;
        }
        if (state is SuccessfullyUploadedPhoto) {
          final post = PostDataModel(
            timestamp: DateTime.now(),
            uid: uid,
            name: state.name,
            description: state.description,
            venue: state.venue,
            country: state.country,
            imageUrl: state.imageUrl,
            imagePublicId: state.imagePublicId,
            tickets: state.tickets,
            benefits: state.benefits,
            group: state.group,
            registrationDeadline: state.registrationDeadline,
            latitude: state.latitude,
            longitude: state.longitude,
            category: state.category,
            postId: '',
          );
          context.read<ActionBloc>().add(UploadPostEvent(post: post));
        }
        if (state is UploadPostSuccess) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Created Post Successfuly'),
                backgroundColor: success,
              ),
            );
          });
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'Create Event',
          color: themeColor,
          showBack: false,
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
                              typevalidator: (p0) => validator(p0, 'type'),
                              pricevalidator: (p0) => validator(p0, 'price'),
                              countvalidator: (p0) => validator(p0, 'count'),
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
                      return validator(p0, 'Benefits');
                    },
                  ),
                  SizedBox(height: 20),

                  HeadingTextField(
                    headline: 'Organizer Group Name:',
                    controller: organizerGrpController,
                    hint: 'Organizer Group',
                    borderColor: themeColor,
                    validator: (p0) {
                      return validator(p0, 'Organization Name');
                    },
                  ),
                  SizedBox(height: 10),

                  EventCoord(
                    validator: (p0) {
                      return validator(p0, 'Coordiantes');
                    },
                    lattitude: lattitudeController,
                    longitude: longitudeController,
                  ),
                  CategoryField(
                    validator: (p0) {
                      return validator(p0, 'category');
                    },
                  ),
                  SizedBox(height: 20),
                  LastDatePicker(
                    lastDateController: lastDateController,
                    validator: (p0) {
                      return validator(p0, 'Event Date');
                    },
                  ),
                  SizedBox(height: 20),

                  CreateEventFooter(
                    nextonPressed: () {
                      if (keyState.currentState!.validate()) {
                        double? lat = double.tryParse(lattitudeController.text);
                        double? lon = double.tryParse(longitudeController.text);
                        context.read<ActionBloc>().add(
                          UploadCoverPhoto(
                            uid: uid,
                            name: widget.name,
                            description: widget.description,
                            venue: widget.venue,
                            imagePath: widget.imagePath!,
                            country: widget.country,
                            tickets: ticketMap,
                            benefits: benefitsController.text,
                            group: organizerGrpController.text,
                            registrationDeadline: lastDateController.text,
                            latitude: lat!,
                            longitude: lon!,
                            category: category!,
                          ),
                        );
                      }
                    },
                    prevonPressed: () {
                      Navigator.of(context).pop();
                    },
                    text: 'Host',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String? validator(value, String message) {
    if (value == null || value.isEmpty) {
      return 'Enter $message';
    }
    return null;
  }
}

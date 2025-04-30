import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:travelgo_organizer/core/constants/colors.dart';
import 'package:travelgo_organizer/core/services/auth/authservice.dart';
import 'package:travelgo_organizer/core/services/stream_services.dart';
import 'package:travelgo_organizer/data/models/post_data.dart';
import 'package:travelgo_organizer/features/logic/action/action_bloc.dart';
import 'package:travelgo_organizer/features/view/screens/main_screens/pages/detailed_page/detailed_page.dart';
import 'package:travelgo_organizer/features/view/screens/main_screens/pages/my_event_page/edit_page/edit_page.dart';
import 'package:travelgo_organizer/features/view/screens/main_screens/pages/my_event_page/widgets/delete_dailog.dart';
import 'package:travelgo_organizer/features/view/widgets/custom_app_bar.dart';
import 'package:travelgo_organizer/features/view/widgets/style_text.dart';

class MyEventPage extends StatefulWidget {
  const MyEventPage({super.key});

  @override
  State<MyEventPage> createState() => _MyEventPageState();
}

class _MyEventPageState extends State<MyEventPage> {
  String uid = '';
  @override
  void initState() {
    super.initState();
    uid = Authservice().getUserUid();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ActionBloc, ActionState>(
      listener: (context, state) {
        if (state is NavigateToEditPage) {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => EditPage(post: state.post)),
          );
        }
        if (state is DeletePostAlertBox) {
          deleteDailog(context, state.post);
        }
      },
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'My Events',
          color: themeColor,
          center: true,
          showBack: false,
        ),
        body: StreamBuilder<List<PostDataModel>>(
          stream: StreamServices().getPostsByOrganizer(uid),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: const CircularProgressIndicator());
            }

            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: const Text('No posts found.'));
            }

            final posts = snapshot.data!;
            return ListView.separated(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                final post = posts[index];
                final date = DateTime.parse(post.registrationDeadline);
                final formattedDate = DateFormat('MMMM dd, yy').format(date);
                return ListTile(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => DetailedPage(post: post),
                      ),
                    );
                  },
                  leading: SizedBox(
                    width: 72,
                    height: 200,
                    child: Image(
                      image: NetworkImage(post.imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: StyleText(
                    text: post.name,
                    fontWeight: FontWeight.bold,
                  ),
                  subtitle: StyleText(
                    text: 'Time : $formattedDate',
                    fontWeight: FontWeight.w300,
                  ),
                  trailing: PopupMenuButton<String>(
                    onSelected: (value) {
                      log(post.toString());
                      if (value == 'edit') {
                        context.read<ActionBloc>().add(
                          EditButtonPressed(post: post),
                        );
                      } else if (value == 'delete') {
                        context.read<ActionBloc>().add(
                          DeletePostEvent(post: post),
                        );
                      }
                    },
                    itemBuilder:
                        (context) => [
                          const PopupMenuItem(
                            value: 'edit',
                            child: Text('Edit'),
                          ),
                          const PopupMenuItem(
                            value: 'delete',
                            child: Text('Delete'),
                          ),
                        ],
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) => Divider(),
            );
          },
        ),
      ),
    );
  }
}

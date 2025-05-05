import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelgo_organizer/core/constants/colors.dart';
import 'package:travelgo_organizer/core/services/stream_services.dart';
import 'package:travelgo_organizer/data/models/organizer_data.dart';
import 'package:travelgo_organizer/features/logic/action/action_bloc.dart';
import 'package:travelgo_organizer/features/view/screens/action_screens/my_blog_page/my_blog_edit_page.dart';
import 'package:travelgo_organizer/features/view/screens/action_screens/my_blog_page/widgets/my_blog_tile.dart';
import 'package:travelgo_organizer/features/view/widgets/custom_app_bar.dart';
import 'package:travelgo_organizer/features/view/widgets/style_text.dart';

class MyBlogPage extends StatelessWidget {
  final OrganizerDataModel organizerData;
  const MyBlogPage({super.key, required this.organizerData});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ActionBloc, ActionState>(
      listenWhen:
          (previous, current) =>
              current is NavigateToEditBlog ||
              current is DeleteBlogSuccess ||
              current is DeleteBlogFailed,
      listener: (context, state) {
        log(state.runtimeType.toString());
        if (state is NavigateToEditBlog) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => MyBlogEditPage(blogData: state.blogData),
            ),
          );
        } else if (state is DeleteBlogSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: StyleText(text: 'Successfully Deleted', color: white),
              backgroundColor: success,
            ),
          );
        }
      },
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'My Blogs',
          color: themeColor,
          center: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: StreamBuilder(
            stream: StreamServices().getBlog(),
            builder: (context, snapshot) {
              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: StyleText(text: 'No Blogs Posted'));
              }
              final blogs = snapshot.data;
              return ListView.separated(
                itemCount: blogs!.length,
                itemBuilder: (context, index) {
                  final blog = blogs[index];
                  return MyBlogTile(blogData: blog);
                },
                separatorBuilder: (context, index) => SizedBox(height: 10),
              );
            },
          ),
        ),
      ),
    );
  }
}

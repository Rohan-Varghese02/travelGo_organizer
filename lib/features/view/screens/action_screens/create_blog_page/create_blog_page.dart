import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelgo_organizer/core/constants/colors.dart';
import 'package:travelgo_organizer/data/models/organizer_data.dart';
import 'package:travelgo_organizer/features/logic/action/action_bloc.dart';
import 'package:travelgo_organizer/features/view/screens/action_screens/create_blog_page/widgets/blog_footer.dart';
import 'package:travelgo_organizer/features/view/screens/action_screens/create_blog_page/widgets/blog_pic.dart';

import 'package:travelgo_organizer/features/view/widgets/custom_app_bar.dart';
import 'package:travelgo_organizer/features/view/widgets/style_text.dart';

class CreateBlogPage extends StatelessWidget {
  final OrganizerDataModel organizerData;
  const CreateBlogPage({super.key, required this.organizerData});

  @override
  Widget build(BuildContext context) {
    String? imagePath;

    return BlocConsumer<ActionBloc, ActionState>(
      listenWhen:
          (previous, current) =>
              current is BlogPhotoUploadSucess ||
              current is BlogPhotoUploadError ||
              current is BlogUploadSuccess ||
              current is BlogUploadFailed,
      listener: (context, state) {
        log(state.runtimeType.toString());
        if (state is BlogPhotoUploadSucess) {
          context.read<ActionBloc>().add(UploadBlog(blogData: state.blogData));
        }
        if (state is BlogUploadSuccess) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: StyleText(text: 'Blog Posted Successfully'),
              backgroundColor: success,
            ),
          );
        }
      },
      buildWhen:
          (previous, current) =>
              current is CoverImagePicked || current is CoverImageCleared,
      builder: (context, state) {
        log(state.runtimeType.toString());
        if (state is CoverImagePicked) {
          imagePath = state.imagePath;
          log(imagePath!);
        }

        return Scaffold(
          appBar: CustomAppBar(
            title: 'Create Blog',
            color: themeColor,
            center: true,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  BlogPic(imagePath: imagePath),
                  imagePath != null
                      ? BlogFooter(
                        organizerUid: organizerData.uid,
                        imagePath: imagePath,
                      )
                      : SizedBox(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

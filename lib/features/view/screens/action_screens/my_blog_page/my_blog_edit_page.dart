import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelgo_organizer/core/constants/colors.dart';
import 'package:travelgo_organizer/data/models/blog_data.dart';
import 'package:travelgo_organizer/features/logic/action/action_bloc.dart';
import 'package:travelgo_organizer/features/view/screens/action_screens/my_blog_page/widgets/edit_blog_pic.dart';
import 'package:travelgo_organizer/features/view/widgets/custom_app_bar.dart';
import 'package:travelgo_organizer/features/view/widgets/heading_text_field.dart';
import 'package:travelgo_organizer/features/view/widgets/square_elevated_btn.dart';
import 'package:travelgo_organizer/features/view/widgets/style_text.dart';

class MyBlogEditPage extends StatefulWidget {
  final BlogData blogData;
  const MyBlogEditPage({super.key, required this.blogData});

  @override
  State<MyBlogEditPage> createState() => _MyBlogEditPageState();
}

class _MyBlogEditPageState extends State<MyBlogEditPage> {
  late TextEditingController detailsController;
  String? imagePath;

  @override
  void initState() {
    super.initState();
    detailsController = TextEditingController(
      text: widget.blogData.blogDetails,
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    String? imagePath;

    return BlocConsumer<ActionBloc, ActionState>(
      listenWhen:
          (previous, current) =>
              current is EditPartialDone ||
              current is EditPartialFailed ||
              current is EditBlogSuccessful ||
              current is EditBlogFailed,
      listener: (context, state) {
        log(state.runtimeType.toString());
        if (state is EditPartialDone) {
          context.read<ActionBloc>().add(
            UploadEditBlog(editedBlogData: state.editedBlog),
          );
        }
        if (state is EditBlogSuccessful) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: StyleText(text: 'Edit Successful', color: white),
              backgroundColor: success,
            ),
          );
          Navigator.of(context).pop();
        }
      },
      buildWhen: (previous, current) => current is CoverImagePicked,
      builder: (context, state) {
        if (state is CoverImagePicked) {
          imagePath = state.imagePath;
        }
        return Scaffold(
          appBar: CustomAppBar(
            title: 'Edit Blog',
            color: themeColor,
            center: true,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                height: height * 0.85,
                width: width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        EditBlogPic(
                          imageUrl: widget.blogData.imageUrl,
                          imagePath: imagePath,
                        ),
                        SizedBox(height: 20),
                        HeadingTextField(
                          headline: 'Blog Details',
                          controller: detailsController,
                          hint: 'Enter details',
                          validator: (p0) {
                            return validator(p0);
                          },
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SquareElevatedBtn(
                          text: 'Cancel',
                          color: white,
                          radius: 10,
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        SquareElevatedBtn(
                          text: 'Edit',
                          radius: 10,
                          color: white,
                          onPressed: () {
                            log(widget.blogData.blogID.toString());
                            final editedBlogData = BlogData(
                              imageUrl: widget.blogData.imageUrl,
                              imageID: widget.blogData.imageID,
                              blogDetails: detailsController.text,
                              organizerUID: widget.blogData.organizerUID,
                              blogID: widget.blogData.blogID,
                            );
                            context.read<ActionBloc>().add(
                              EditBlog(
                                imagePath: imagePath,
                                blogdata: editedBlogData,
                              ),
                            );
                          },
                        ),
                      ],
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
}

String? validator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Enter post details';
  }
  return null;
}

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelgo_organizer/core/constants/colors.dart';
import 'package:travelgo_organizer/features/logic/action/action_bloc.dart';
import 'package:travelgo_organizer/features/view/widgets/heading_text_field.dart';
import 'package:travelgo_organizer/features/view/widgets/square_elevated_btn.dart';

class BlogFooter extends StatelessWidget {
  final String organizerUid;
  final String? imagePath;

  const BlogFooter({super.key, this.imagePath, required this.organizerUid});

  @override
  Widget build(BuildContext context) {
    final keyState = GlobalKey<FormState>();
    TextEditingController blogDescription = TextEditingController();
    return Form(
      key: keyState,
      child: Column(
        children: [
          SizedBox(height: 20),
          HeadingTextField(
            headline: 'Blog Details',
            controller: blogDescription,
            hint: 'Enter the details',
            validator: (p0) {
              return validator(p0);
            },
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SquareElevatedBtn(
                color: white,
                text: 'Cancel',
                radius: 10,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              SquareElevatedBtn(
                text: 'Post',
                radius: 10,
                color: white,
                onPressed: () {
                  if (keyState.currentState!.validate()) {
                    context.read<ActionBloc>().add(
                      UploadBlogPhoto(
                        imagePath: imagePath!,
                        postDetails: blogDescription.text,
                        organizerUID: organizerUid,
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

String? validator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Enter post details';
  }
  return null;
}

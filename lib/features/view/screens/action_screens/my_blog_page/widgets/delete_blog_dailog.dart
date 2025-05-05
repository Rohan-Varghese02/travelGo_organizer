import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelgo_organizer/core/constants/colors.dart';
import 'package:travelgo_organizer/data/models/blog_data.dart';
import 'package:travelgo_organizer/features/logic/action/action_bloc.dart';
import 'package:travelgo_organizer/features/view/widgets/square_elevated_btn.dart';
import 'package:travelgo_organizer/features/view/widgets/style_text.dart';

void deleteBlogDailog(BuildContext context, BlogData blogdata) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: StyleText(text: 'Blog Deletion'),
        content: StyleText(text: 'Do you really want to delete this blog'),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SquareElevatedBtn(
                text: 'Cancel',
                radius: 10,
                color: black,
                backgroundColor: white,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              SquareElevatedBtn(
                text: 'Delete',
                radius: 10,
                color: white,
                onPressed: () {
                  context.read<ActionBloc>().add(
                    DeleteBlog(blogData: blogdata),
                  );
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ],
      );
    },
  );
}

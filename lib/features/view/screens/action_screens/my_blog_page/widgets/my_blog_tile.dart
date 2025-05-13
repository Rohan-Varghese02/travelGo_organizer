import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelgo_organizer/core/constants/colors.dart';
import 'package:travelgo_organizer/data/models/blog_data.dart';
import 'package:travelgo_organizer/features/logic/action/action_bloc.dart';
import 'package:travelgo_organizer/features/view/screens/action_screens/my_blog_page/widgets/delete_blog_dailog.dart';
import 'package:travelgo_organizer/features/view/widgets/style_text.dart';

class MyBlogTile extends StatelessWidget {
  final BlogData blogData;
  const MyBlogTile({super.key, required this.blogData});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(border: Border.all(color: themeColor)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: width,
            height: 500,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(blogData.imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: width * 0.7,
                child: StyleText(
                  text: blogData.blogDetails,
                  fontWeight: FontWeight.bold,
                  size: 20,
                  softWrap: true,
                ),
              ),
              PopupMenuButton(
                onSelected: (value) {
                  if (value == 'edit') {
                    context.read<ActionBloc>().add(
                      EditBlogButton(blogData: blogData),
                    );
                  }
                  if (value == 'delete') {
                    deleteBlogDailog(context, blogData);
                  }
                },
                itemBuilder: (context) {
                  return [
                    PopupMenuItem(
                      value: 'edit',
                      child: Row(
                        children: [Icon(Icons.edit), StyleText(text: ' Edit')],
                      ),
                    ),
                    PopupMenuItem(
                      value: 'delete',
                      child: Row(
                        children: [
                          Icon(Icons.delete),
                          StyleText(text: ' Delete'),
                        ],
                      ),
                    ),
                  ];
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelgo_organizer/core/constants/colors.dart';
import 'package:travelgo_organizer/features/logic/action/action_bloc.dart';

class EditBlogPic extends StatelessWidget {
  final String imageUrl;
  final String? imagePath;

  const EditBlogPic({super.key, this.imagePath, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        context.read<ActionBloc>().add(PickCoverImageEvent());
      },
      child: Container(
        width: width,
        height: 200,
        decoration: BoxDecoration(
          border: Border.all(color: themeColor),
          image:
              imagePath != null
                  ? DecorationImage(
                    image: FileImage(File(imagePath!)),
                    fit: BoxFit.cover,
                  )
                  : DecorationImage(
                    image: NetworkImage(imageUrl),
                    fit: BoxFit.cover,
                  ),
        ),
      ),
    );
  }
}

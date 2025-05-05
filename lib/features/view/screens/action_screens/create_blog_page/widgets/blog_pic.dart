import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelgo_organizer/core/constants/colors.dart';
import 'package:travelgo_organizer/features/logic/action/action_bloc.dart';

class BlogPic extends StatelessWidget {
  final String? imagePath;

  const BlogPic({super.key, this.imagePath});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        context.read<ActionBloc>().add(PickCoverImageEvent());
      },
      child: Container(
        width: width,
        height: 500,
        decoration: BoxDecoration(
          border: Border.all(color: themeColor),
          image:
              imagePath != null
                  ? DecorationImage(
                    image: FileImage(File(imagePath!)),
                    fit: BoxFit.contain,
                  )
                  : null,
        ),
    
        child:
            (imagePath == null)
                ? Center(child: Icon(Icons.camera_alt, size: 30))
                : null,
      ),
    );
  }
}

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelgo_organizer/core/constants/colors.dart';
import 'package:travelgo_organizer/data/models/organizer_data.dart';
import 'package:travelgo_organizer/data/models/request_data.dart';
import 'package:travelgo_organizer/features/logic/action/action_bloc.dart';
import 'package:travelgo_organizer/features/view/widgets/heading_text_field.dart';
import 'package:travelgo_organizer/features/view/widgets/square_elevated_btn.dart';
import 'package:travelgo_organizer/features/view/widgets/style_text.dart';

void requestDailog(
  BuildContext context,
  OrganizerDataModel organizerData,
) async {
  TextEditingController subjectController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  final formState = GlobalKey<FormState>();
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: StyleText(
          text: 'Generate Request',
          color: themeColor,
          fontWeight: FontWeight.bold,
          size: 24,
        ),
        content: SingleChildScrollView(
          child: Form(
            key: formState,
            child: Column(
              children: [
                HeadingTextField(
                  headline: 'Request Subject',
                  controller: subjectController,
                  hint: 'Enter subject',
                  validator: (p0) => textValidator(p0, 'subject'),
                ),
                HeadingTextField(
                  headline: 'Request Content',
                  controller: contentController,
                  hint: 'Enter content',
                  validator: (p0) => textValidator(p0, 'content'),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: StyleText(text: 'Cancel'),
                    ),
                    SquareElevatedBtn(
                      color: white,
                      text: 'Submit',
                      radius: 15,
                      onPressed: () {
                        if (formState.currentState!.validate()) {
                          RequestData request = RequestData(
                            subject: subjectController.text,
                            content: contentController.text,
                            response: 'Pending',
                            organizerUid: organizerData.uid,
                          );
                          context.read<ActionBloc>().add(
                            CreateRequest(request: request),
                          );
                          Navigator.of(context).pop();
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

String? textValidator(String? value, String message) {
  if (value == null || value.isEmpty) {
    return 'Enter $message';
  }
  return null;
}

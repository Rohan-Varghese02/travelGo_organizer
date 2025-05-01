import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:travelgo_organizer/core/constants/colors.dart';
import 'package:travelgo_organizer/core/services/stream_services.dart';
import 'package:travelgo_organizer/data/models/post_data.dart';
import 'package:travelgo_organizer/features/view/widgets/heading_text_field.dart';
import 'package:travelgo_organizer/features/view/widgets/style_text.dart';

void showCouponCreationDialog(BuildContext context, String organizerUid) async {
  List<PostDataModel> posts =
      await StreamServices().getPostsByOrganizer(organizerUid).first;

  PostDataModel? selectedPost;
  final formState = GlobalKey<FormState>();
  TextEditingController codenameController = TextEditingController();
  TextEditingController discountController = TextEditingController();
  TextEditingController redeemController = TextEditingController();
  showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        // Needed to update dropdown inside the dialog
        builder: (context, setState) {
          return AlertDialog(
            title: StyleText(
              text: 'Generate Coupon',
              color: themeColor,
              fontWeight: FontWeight.bold,
            ),
            content: SingleChildScrollView(
              child: Form(
                key: formState,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HeadingTextField(
                      headline: 'Code Name:',
                      controller: codenameController,
                      hint: 'Enter code name',
                      validator: (p0) {
                        return textValidator(p0, 'code name');
                      },
                    ),
                    SizedBox(height: 10),
                    HeadingTextField(
                      headline: 'Code Discount(%):',
                      controller: discountController,
                      hint: 'Enter discount',
                      validator: (p0) {
                        return textValidator(p0, 'code name');
                      },
                    ),
                    SizedBox(height: 10),
                    HeadingTextField(
                      headline: 'Number of Redeem:',
                      controller: redeemController,
                      hint: 'Enter how much reedem',
                      validator: (p0) {
                        return textValidator(p0, 'code name');
                      },
                    ),
                    SizedBox(height: 10),
                    StyleText(
                      text: 'Post to Redeem',
                      size: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    DropdownButtonFormField<PostDataModel>(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                      ),
                      validator: (value) {
                        if (value == null) {
                          return 'Please select a post';
                        }
                        return null;
                      },
                      isExpanded: true,
                      value: selectedPost,
                      hint: const Text('Choose a post'),
                      items:
                          posts.map((post) {
                            return DropdownMenuItem<PostDataModel>(
                              value: post,
                              child: Text(post.name),
                            );
                          }).toList(),
                      onChanged: (PostDataModel? newValue) {
                        setState(() {
                          selectedPost = newValue;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Cancel
                    },
                    child: StyleText(text: 'Cancel'),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: white,
                      backgroundColor: themeColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      if (formState.currentState!.validate()) {
                        log(codenameController.text);
                        log(discountController.text);
                        log(redeemController.text);
                        log(selectedPost!.name);
                        log(selectedPost!.uid);
                      } else {
                        log('failed');
                      }
                    },
                    child: StyleText(text: 'Enter', color: white),
                  ),
                ],
              ),
            ],
          );
        },
      );
    },
  );
  // .then((selected) {
  //   if (selected != null && selected is PostDataModel) {
  //     print('Selected Post UID: ${selected.uid}');
  //     print('Selected Post Title: ${selected.name}');
  //     // You can now use selected.uid wherever needed
  //   }
  // });
}

String? textValidator(String? value, String message) {
  if (value == null || value.isEmpty) {
    return 'Enter $message';
  }
  return null;
}

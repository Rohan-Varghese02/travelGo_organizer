import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelgo_organizer/core/constants/colors.dart';
import 'package:travelgo_organizer/core/services/stream_services.dart';
import 'package:travelgo_organizer/data/models/coupon_data.dart';
import 'package:travelgo_organizer/data/models/post_data.dart';
import 'package:travelgo_organizer/features/logic/action/action_bloc.dart';
import 'package:travelgo_organizer/features/view/widgets/heading_text_field.dart';
import 'package:travelgo_organizer/features/view/widgets/style_text.dart';

void editCouponCreationDialog(
  BuildContext context,
  String organizerUid,
  CouponData coupon,
) async {
  List<PostDataModel> posts =
      await StreamServices().getPostsByOrganizer(organizerUid).first;

  PostDataModel? selectedPost = posts.firstWhere(
    (post) => post.name == coupon.postName,
    orElse: () => posts.first,
  );
  final formState = GlobalKey<FormState>();
  TextEditingController codenameController = TextEditingController(
    text: coupon.codeName,
  );
  TextEditingController discountController = TextEditingController(
    text: coupon.codeDiscount.toString(),
  );
  TextEditingController redeemController = TextEditingController(
    text: coupon.codeRedeem.toString(),
  );
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
                        return codeValidator(p0, 'code name');
                      },
                    ),
                    StyleText(text: 'Upto 10 words allowed', size: 10),
                    SizedBox(height: 10),
                    HeadingTextField(
                      keyboardType: TextInputType.number,
                      headline: 'Code Discount(%):',
                      controller: discountController,
                      hint: 'Enter discount',
                      validator: (p0) {
                        return discountValidator(p0, 'code name');
                      },
                    ),
                    SizedBox(height: 10),
                    HeadingTextField(
                      keyboardType: TextInputType.number,
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
                        int discount = int.parse(discountController.text);
                        int redeem = int.parse(redeemController.text);
                        log(codenameController.text);
                        log(discountController.text);
                        log(redeemController.text);
                        log(selectedPost!.name);
                        log(selectedPost!.uid);
                        log(coupon.couponUid!);
                        context.read<ActionBloc>().add(
                          EditCoupon(
                            coupon: CouponData(
                              codeName: codenameController.text,
                              codeDiscount: discount,
                              codeRedeem: redeem,
                              postName: selectedPost!.name,
                              postUid: selectedPost!.postId,
                              couponUid: coupon.couponUid,
                              isActive: coupon.isActive,
                            ),
                          ),
                        );
                        Navigator.of(context).pop();
                      }
                    },
                    child: StyleText(text: 'Update', color: white),
                  ),
                ],
              ),
            ],
          );
        },
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

String? codeValidator(String? value, String message) {
  if (value == null || value.isEmpty) {
    return 'Enter $message';
  } else if (value.length >= 10) {
    return '10 digits allowd';
  }
  return null;
}

String? discountValidator(String? value, String message) {
  if (value == null || value.isEmpty) {
    return 'Enter $message';
  } else if (int.parse(value) > 100) {
    return 'Value should be less than 100';
  }
  return null;
}

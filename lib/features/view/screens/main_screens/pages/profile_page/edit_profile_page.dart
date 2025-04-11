import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelgo_organizer/core/constants/colors.dart';
import 'package:travelgo_organizer/data/models/organizer_data.dart';
import 'package:travelgo_organizer/features/logic/user/user_bloc.dart';
import 'package:travelgo_organizer/features/view/screens/main_screens/pages/profile_page/widgets/profile_btn.dart';
import 'package:travelgo_organizer/features/view/widgets/heading_text_field.dart';

class EditProfilePage extends StatefulWidget {
  final OrganizerDataModel organizerdata;
  const EditProfilePage({super.key, required this.organizerdata});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  String? imagePath;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController companyController = TextEditingController();
  TextEditingController designationController = TextEditingController();
  TextEditingController aboutController = TextEditingController();
  TextEditingController expController = TextEditingController();
  final keyState = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    nameController.text = widget.organizerdata.name;
    emailController.text = widget.organizerdata.email;
    phoneController.text = widget.organizerdata.phoneNumber;
    companyController.text = widget.organizerdata.company;
    designationController.text = widget.organizerdata.designation;
    aboutController.text = widget.organizerdata.about;
    expController.text = widget.organizerdata.experience;
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            key: keyState,
            child: Column(
              children: [
                Center(
                  child: BlocConsumer<UserBloc, UserState>(
                    builder: (context, state) {
                      log(imagePath.toString());
                      if (state is ProfileImageUpdatedSucess) {
                        imagePath = state.imagePath;
                        log(imagePath.toString());
                      } else if (state is UserProfileIntiated) {
                        context.read<UserBloc>().add(
                          UpdateProfileEvent(
                            imageUrl: widget.organizerdata.imageUrl,
                            uid: widget.organizerdata.uid,
                            imagePath: imagePath,
                            name: nameController.text,
                            email: emailController.text,
                            phone: phoneController.text,
                            company: companyController.text,
                            designation: designationController.text,
                            about: aboutController.text,
                            experience: expController.text,
                            imagePublicID: widget.organizerdata.imagePublicId,
                          ),
                        );
                      }
                      return GestureDetector(
                        onTap: () {
                          context.read<UserBloc>().add(UpdateImageEvent());
                        },
                        child: CircleAvatar(
                          radius: 100,
                          backgroundImage:
                              imagePath != null
                                  ? FileImage(File(imagePath!))
                                  : NetworkImage(widget.organizerdata.imageUrl),
                        ),
                      );
                    },
                    listener: (BuildContext context, UserState state) {
                      if (state is ProfileUpdateSuccess) {
                        Navigator.of(context).pop();
                      }
                    },
                  ),
                ),
                SizedBox(height: 10),

                HeadingTextField(
                  colortext: themeColor,
                  headline: 'Name',
                  controller: nameController,
                  hint: 'Name',
                  validator: (value) {
                    return textValidator(value);
                  },
                ),
                SizedBox(height: 10),
                HeadingTextField(
                  readOnly: true,
                  colortext: themeColor,
                  headline: 'Email',
                  controller: emailController,
                  hint: 'Enter your email',
                  validator: (value) {
                    return textValidator(value);
                  },
                ),
                SizedBox(height: 10),
                HeadingTextField(
                  colortext: themeColor,
                  headline: 'Phone Number',
                  controller: phoneController,
                  hint: 'Enter your phone number',
                  validator: (value) {
                    return textValidator(value);
                  },
                ),
                SizedBox(height: 10),
                HeadingTextField(
                  colortext: themeColor,
                  headline: 'Name of Company',
                  controller: companyController,
                  hint: 'Enter your name of company',
                  validator: (value) {
                    return textValidator(value);
                  },
                ),
                SizedBox(height: 10),
                HeadingTextField(
                  colortext: themeColor,
                  headline: 'Designation',
                  controller: designationController,
                  hint: 'Enter your designation',
                  validator: (value) {
                    return textValidator(value);
                  },
                ),
                SizedBox(height: 10),
                HeadingTextField(
                  colortext: themeColor,
                  headline: 'About',
                  controller: aboutController,
                  hint: 'Enter things about you',
                  validator: (value) {
                    return textValidator(value);
                  },
                ),
                SizedBox(height: 10),
                HeadingTextField(
                  colortext: themeColor,
                  headline: 'Experience with the Company',
                  controller: expController,
                  hint: 'Enter your experience',
                  validator: (value) {
                    return textValidator(value);
                  },
                ),
                SizedBox(height: 10),
                ProfileBtn(
                  onPressed: () {
                    if (keyState.currentState!.validate()) {
                      log('Save to cloud');
                      context.read<UserBloc>().add(ProfileUpdatIntiate());
                    }
                  },
                  text: 'Save',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

String? textValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Fill the Field';
  }
  return null;
}

import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travelgo_organizer/features/logic/auth/auth_bloc.dart';
import 'package:travelgo_organizer/features/view/screens/auth_screens/register_screen/widgets/register_dailog.dart';
import 'package:travelgo_organizer/features/view/widgets/heading_text_field.dart';
import 'package:travelgo_organizer/features/view/widgets/long_button.dart';

class RegisterProfileScreen extends StatefulWidget {
  final String email;
  final String password;
  const RegisterProfileScreen({
    super.key,
    required this.email,
    required this.password,
  });

  @override
  State<RegisterProfileScreen> createState() => _RegisterProfileScreenState();
}

class _RegisterProfileScreenState extends State<RegisterProfileScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController companyController = TextEditingController();
  TextEditingController designationController = TextEditingController();
  TextEditingController aboutController = TextEditingController();
  TextEditingController experienceController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    emailController.text = widget.email;
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 25,
              ),
              child: BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  String? imagePath;
                  String? imageUrl;

                  if (state is ProfileImagePicked) {
                    imagePath = state.imagePath;
                  } else if (state is ProfileImageUploaded) {
                    imageUrl = state.imageUrl;
                    log(state.imageUrl);
                    context.read<AuthBloc>().add(
                      RegisterUser(
                        name: nameController.text,
                        email: emailController.text,
                        password: widget.password,
                        phoneNumber: phoneController.text,
                        imageUrl: imageUrl.toString(),
                        experience: experienceController.text,
                        nameOfCompany: companyController.text,
                        designation: designationController.text,
                        about: aboutController.text,
                      ),
                    );
                  } else if (state is RegisterSuccessful) {
                    log('Register success');
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    });
                  } else if (state is RegisterationError) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return RegisterDailog(
                            onPressed: () {
                              Navigator.of(context).pop();
                              Navigator.of(context).pop();
                            },
                          );
                        },
                      );
                    });
                  } else if (state is NoImageState) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Upload Photo to proceed')),
                      );
                    });
                  }
                  return Column(
                    children: [
                      SizedBox(height: 20),
                      Text(
                        'Profile',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 40),

                      GestureDetector(
                        onTap: () {
                          log('Profile pic to be uploaded');
                          context.read<AuthBloc>().add(PickImageEvent());
                        },
                        child: CircleAvatar(
                          radius: 100,
                          backgroundImage:
                              imagePath != null
                                  ? FileImage(
                                    File(imagePath),
                                  ) 
                                  : imageUrl != null
                                  ? NetworkImage(imageUrl)
                                      as ImageProvider 
                                  : null,
                          child:
                              (imagePath == null && imageUrl == null)
                                  ? Icon(Icons.camera_alt, size: 30)
                                  : null,
                        ),
                      ),

                      SizedBox(height: 20),
                      HeadingTextField(
                        headline: 'Full Name',
                        controller: nameController,
                        hint: 'Enter your name',
                      ),
                      SizedBox(height: 20),
                      HeadingTextField(
                        readOnly: true,
                        headline: 'Email',
                        controller: emailController,
                        hint: 'Enter your name',
                      ),
                      SizedBox(height: 20),
                      HeadingTextField(
                        headline: 'Phone Number',
                        controller: phoneController,
                        hint: 'Enter your phone number',
                      ),
                      SizedBox(height: 20),
                      HeadingTextField(
                        headline: 'Name of Company',
                        controller: companyController,
                        hint: 'Enter your company name',
                      ),
                      SizedBox(height: 20),
                      HeadingTextField(
                        headline: 'Designation',
                        controller: designationController,
                        hint: 'Enter your designation',
                      ),
                      SizedBox(height: 20),
                      HeadingTextField(
                        headline: 'About',
                        controller: aboutController,
                        hint: 'Tell about yourself',
                      ),
                      SizedBox(height: 20),
                      HeadingTextField(
                        headline: 'Experience with Company',
                        controller: experienceController,
                        hint: 'Enter your experience',
                      ),
                      SizedBox(height: 20),
                      LongButton(
                        text: 'Register',
                        onPressed: () {
                          if (imagePath != null) {
                            context.read<AuthBloc>().add(
                              UploadImageEvent(imagePath: imagePath),
                            );
                          } else {
                            context.read<AuthBloc>().add(NoImageEvent());
                          }

                          log(nameController.text);
                          log(emailController.text);
                          log(phoneController.text);
                          log(widget.password);
                          log(imageUrl.toString());
                        },
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

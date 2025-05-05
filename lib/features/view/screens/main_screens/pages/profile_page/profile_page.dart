import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travelgo_organizer/core/constants/colors.dart';
import 'package:travelgo_organizer/core/services/stream_services.dart';
import 'package:travelgo_organizer/data/models/organizer_data.dart';
import 'package:travelgo_organizer/features/logic/auth/auth_bloc.dart';
import 'package:travelgo_organizer/features/logic/user/user_bloc.dart';
import 'package:travelgo_organizer/features/view/screens/main_screens/pages/profile_page/edit_profile_page.dart';
import 'package:travelgo_organizer/features/view/screens/main_screens/pages/profile_page/widgets/logout_dailog.dart';
import 'package:travelgo_organizer/features/view/screens/main_screens/pages/profile_page/widgets/profile_header.dart';
import 'package:travelgo_organizer/features/view/screens/main_screens/pages/profile_page/widgets/profile_btn.dart';
import 'package:travelgo_organizer/features/view/widgets/custom_app_bar.dart';
import 'package:travelgo_organizer/features/view/widgets/heading_text_field.dart';
import 'package:travelgo_organizer/features/view/widgets/profile_avatar.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<UserBloc>().add(FetchDetails());
    });
  }

  TextEditingController nameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

  TextEditingController companyController = TextEditingController();

  TextEditingController designationController = TextEditingController();

  TextEditingController aboutController = TextEditingController();

  TextEditingController expController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserBloc, UserState>(
      listenWhen: (previous, current) => current is! UserActionState,
      buildWhen: (previous, current) => current is ProfileDetailsFetched,
      listener: (context, state) {
        log(state.runtimeType.toString());
        if (state is NavigateToEditPage) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder:
                  (context) =>
                      EditProfilePage(organizerdata: state.organizerData),
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is ProfileDetailsFetched) {
          final organizerData = state.organizerData;
          nameController.text = organizerData.name;
          emailController.text = organizerData.email;
          phoneController.text = organizerData.phoneNumber;
          companyController.text = organizerData.company;
          designationController.text = organizerData.designation;
          aboutController.text = organizerData.about;
          expController.text = organizerData.experience;

          return Scaffold(
            appBar: CustomAppBar(
              title: 'Profile',
              color: themeColor,
              center: true,
              showBack: false,
              actions: [
                IconButton(
                  onPressed: () {
                    log(organizerData.uid);
                    context.read<UserBloc>().add(
                      UserProfileEdit(organizerData: organizerData),
                    );
                  },
                  icon: Icon(FontAwesomeIcons.pen, color: themeColor),
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Center(
                  child: Column(
                    children: [
                      ProfileAvatar(
                        radius: 100,
                        imageUrl: organizerData.imageUrl,
                      ),
                      SizedBox(height: 10),
                      StreamBuilder<OrganizerDataModel>(
                        stream: StreamServices().getOrganizerByUid(
                          organizerData.uid,
                        ),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            final organizer = snapshot.data!;
                            return ProfileHeader(
                              folowers: organizer.followersCount,
                              post: organizer.eventHosted!,
                            );
                          } else {
                            return CircularProgressIndicator();
                          }
                        },
                      ),
                      HeadingTextField(
                        colortext: themeColor,
                        readOnly: true,
                        headline: 'Name',
                        controller: nameController,
                        hint: 'Name',
                      ),
                      SizedBox(height: 10),
                      HeadingTextField(
                        colortext: themeColor,
                        readOnly: true,
                        headline: 'Email',
                        controller: emailController,
                        hint: 'Name',
                      ),
                      SizedBox(height: 10),
                      HeadingTextField(
                        colortext: themeColor,
                        readOnly: true,
                        headline: 'Phone Number',
                        controller: phoneController,
                        hint: 'Name',
                      ),
                      SizedBox(height: 10),
                      HeadingTextField(
                        colortext: themeColor,
                        readOnly: true,
                        headline: 'Name of Company',
                        controller: companyController,
                        hint: 'Name',
                      ),
                      SizedBox(height: 10),
                      HeadingTextField(
                        colortext: themeColor,
                        readOnly: true,
                        headline: 'Designation',
                        controller: designationController,
                        hint: 'Name',
                      ),
                      SizedBox(height: 10),
                      HeadingTextField(
                        colortext: themeColor,
                        readOnly: true,
                        headline: 'About',
                        controller: aboutController,
                        hint: 'Name',
                      ),
                      SizedBox(height: 10),
                      HeadingTextField(
                        colortext: themeColor,
                        readOnly: true,
                        headline: 'Experience with the Company',
                        controller: expController,
                        hint: 'Name',
                      ),
                      SizedBox(height: 10),
                      BlocListener<AuthBloc, AuthState>(
                        listener: (context, state) {
                          log(state.runtimeType.toString());
                          if (state is LogoutDailogOpenState) {
                            logoutDailog(context);
                          }
                        },
                        child: ProfileBtn(
                          text: 'Logout',
                          onPressed: () {
                            context.read<AuthBloc>().add(
                              LogOutDailogOpenEvent(),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
        return CircularProgressIndicator();
      },
    );
  }
}

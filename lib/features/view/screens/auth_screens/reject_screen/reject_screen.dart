import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelgo_organizer/core/constants/colors.dart';
import 'package:travelgo_organizer/core/services/auth/auth_gate.dart';
import 'package:travelgo_organizer/features/logic/auth/auth_bloc.dart';
import 'package:travelgo_organizer/features/logic/user/user_bloc.dart';
import 'package:travelgo_organizer/features/view/screens/auth_screens/reject_screen/reject_btn.dart';
import 'package:travelgo_organizer/features/view/screens/main_screens/pages/profile_page/edit_profile_page.dart';
import 'package:travelgo_organizer/features/view/widgets/style_text.dart';

class RejectScreen extends StatefulWidget {
  const RejectScreen({super.key});

  @override
  State<RejectScreen> createState() => _RejectScreenState();
}

class _RejectScreenState extends State<RejectScreen> {
  @override
  void initState() {
    super.initState();
    context.read<UserBloc>().add(FetchDetails());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserBloc, UserState>(
      buildWhen: (previous, current) => current is UserActionState,
      builder: (context, state) {
        if (state is ProfileDetailsFetched) {
          final organizerData = state.organizerData;
          return Scaffold(
            backgroundColor: white,
            appBar: AppBar(
              actions: [
                GestureDetector(
                  onTap: () {
                    context.read<UserBloc>().add(
                      UserProfileEdit(organizerData: organizerData),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.red,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircleAvatar(
                          radius: 25,
                          backgroundImage: NetworkImage(organizerData.imageUrl),
                        ),
                        StyleText(
                          text: organizerData.name,
                          color: white,
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 20),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(7.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.network(
                      'https://i.pinimg.com/474x/65/8e/07/658e0702ed408e5f62ec06d754eaa087.jpg',
                    ),
                    SizedBox(height: 20),
                    StyleText(
                      text: 'Request Rejected',
                      size: 30,
                      fontWeight: FontWeight.normal,
                    ),
                    SizedBox(height: 20),
                    StyleText(
                      text: 'Your request as organizer has been',
                      size: 14,
                      fontWeight: FontWeight.w300,
                    ),
                    StyleText(
                      text: 'rejected please try again later',
                      size: 14,
                      fontWeight: FontWeight.w300,
                    ),
                    SizedBox(height: 20),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RejectBtn(
                          color: themeColor,
                          text: 'Re-Apply',
                          onPressed: () {
                            context.read<AuthBloc>().add(
                              ReapplyEvent(uid: organizerData.uid),
                            );
                          },
                        ),
                        SizedBox(width: 20),
                        BlocListener<AuthBloc, AuthState>(
                          listener: (context, state) {
                            log(state.runtimeType.toString());
                            if (state is ReApplySuccessState) {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => AuthGate(),
                                ),
                              );
                            }
                          },
                          child: RejectBtn(
                            text: 'Logout',
                            onPressed: () {
                              context.read<AuthBloc>().add(
                                LogOutButtonClicked(),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        return Center(child: CircularProgressIndicator());
      },
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
    );
  }
}

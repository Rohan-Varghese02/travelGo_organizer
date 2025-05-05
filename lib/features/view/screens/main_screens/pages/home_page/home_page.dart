import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelgo_organizer/features/logic/action/action_bloc.dart';
import 'package:travelgo_organizer/features/logic/user/user_bloc.dart';
import 'package:travelgo_organizer/features/view/screens/action_screens/coupon_page/coupon_page.dart';
import 'package:travelgo_organizer/features/view/screens/action_screens/create_blog_page/create_blog_page.dart';
import 'package:travelgo_organizer/features/view/screens/action_screens/create_event_page/create_event_screen.dart';
import 'package:travelgo_organizer/features/view/screens/action_screens/request_page/request_page.dart';
import 'package:travelgo_organizer/features/view/screens/main_screens/pages/home_page/widgets/action_section.dart';
import 'package:travelgo_organizer/features/view/screens/main_screens/pages/home_page/widgets/home_heading.dart';
import 'package:travelgo_organizer/features/view/screens/main_screens/pages/home_page/widgets/home_page_header.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<UserBloc>().add(FetchDetails());
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserBloc, UserState>(
      buildWhen: (previous, current) => current is UserActionState,
      listenWhen: (previous, current) => current is! UserActionState,
      listener: (context, state) {
        log(state.runtimeType.toString());
        if (state is CreateEventIntitated) {
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (context) => CreateEventScreen()));
        } else if (state is CouponEventIntiated) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder:
                  (context) => CouponPage(organizerData: state.organizerData),
            ),
          );
        } else if (state is RequestEventIntiated) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder:
                  (context) => RequestPage(organizerData: state.organizerData),
            ),
          );
        } else if (state is CreateBlogNavigateIntiate) {
          Navigator.of(context)
              .push(
                MaterialPageRoute(
                  builder:
                      (context) =>
                          CreateBlogPage(organizerData: state.organizerData),
                ),
              )
              .then((_) {
                // ignore: use_build_context_synchronously
                context.read<ActionBloc>().add(ClearCoverImage());
              });
        }
      },
      builder: (context, state) {
        if (state is ProfileDetailsFetched) {
          final organierData = state.organizerData;
          return Scaffold(
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HomePageHeader(organizerData: organierData),
                    SizedBox(height: 20),
                    HomeHeading(text: 'Actions'),
                    SizedBox(height: 20),
                    Flexible(child: ActionSection(organizerData: organierData)),
                    SizedBox(height: 20),
                    HomeHeading(text: 'Live Events'),
                  ],
                ),
              ),
            ),
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}

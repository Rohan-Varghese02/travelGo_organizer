import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelgo_organizer/data/models/organizer_data.dart';
import 'package:travelgo_organizer/features/logic/user/user_bloc.dart';
import 'package:travelgo_organizer/features/view/screens/main_screens/pages/home_page/widgets/action_tile.dart';

class ActionSection extends StatelessWidget {
  final OrganizerDataModel organizerData;
  const ActionSection({super.key, required this.organizerData});

  @override
  Widget build(BuildContext context) {
    return GridView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      children: [
        GestureDetector(
          onTap: () {
            context.read<UserBloc>().add(CreateEventClicked());
          },
          child: ActionTile(
            text: 'Create Event',
            assetImage: 'assets/addevent.png',
          ),
        ),
        GestureDetector(
          onTap: () {
            log('Analytics');
          },
          child: ActionTile(
            text: 'Analytics',
            assetImage: 'assets/analytics.png',
          ),
        ),
        GestureDetector(
          onTap: () {
            context.read<UserBloc>().add(
              RequestEventClicked(organizerData: organizerData),
            );
          },
          child: ActionTile(text: 'Request', assetImage: 'assets/request.png'),
        ),
        GestureDetector(
          onTap: () {
            context.read<UserBloc>().add(
              CreateBlogClicked(organizerData: organizerData),
            );
          },
          child: ActionTile(
            text: 'Create Blog',
            assetImage: 'assets/createblog.png',
          ),
        ),
        GestureDetector(
          onTap: () {
            context.read<UserBloc>().add(
              CouponEventClicked(organizerData: organizerData),
            );
          },
          child: ActionTile(text: 'Coupon', assetImage: 'assets/coupon.png'),
        ),
        GestureDetector(
          onTap: () {
            log('Create Event Clicked');
          },
          child: ActionTile(text: 'My Blog', assetImage: 'assets/myblog.png'),
        ),
      ],
    );
  }
}

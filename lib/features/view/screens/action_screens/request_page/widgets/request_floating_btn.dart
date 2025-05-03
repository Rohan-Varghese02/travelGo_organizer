import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelgo_organizer/core/constants/colors.dart';
import 'package:travelgo_organizer/data/models/organizer_data.dart';
import 'package:travelgo_organizer/features/logic/action/action_bloc.dart';
import 'package:travelgo_organizer/features/view/screens/action_screens/request_page/widgets/request_dailog.dart';
import 'package:travelgo_organizer/features/view/widgets/style_text.dart';

class RequestFloatingBtn extends StatelessWidget {
  final OrganizerDataModel organizerData;
  const RequestFloatingBtn({super.key, required this.organizerData});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: themeColor,
      onPressed: () {
        requestDailog(context, organizerData);
      },
      child: Icon(Icons.add, color: white),
    );
  }
}

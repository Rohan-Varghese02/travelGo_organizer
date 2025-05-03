import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelgo_organizer/core/constants/colors.dart';
import 'package:travelgo_organizer/data/models/request_data.dart';
import 'package:travelgo_organizer/features/logic/action/action_bloc.dart';
import 'package:travelgo_organizer/features/view/screens/action_screens/request_page/widgets/edit_request_dailog.dart';
import 'package:travelgo_organizer/features/view/screens/action_screens/request_page/widgets/request_status_indicator.dart';
import 'package:travelgo_organizer/features/view/widgets/text_fw.dart';

class RequestTile extends StatelessWidget {
  final RequestData request;
  const RequestTile({super.key, required this.request});

  @override
  Widget build(BuildContext context) {
    if (request.response == 'Approved') {
      return Padding(
        padding: const EdgeInsets.all(4.0),
        child: container(context, success),
      );
    } else if (request.response == 'Declined') {
      return Padding(
        padding: const EdgeInsets.all(4.0),
        child: container(context, errorred),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(4.0),
        child: container(context, amberYellow),
      );
    }
  }

  Widget container(BuildContext context, Color color) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: color, width: 3),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFw(
                  firstword: 'Subject: ',
                  fontSize: 20,
                  secondWord: request.subject,
                ),
                TextFw(
                  firstword: 'Content: ',
                  secondWord: request.content,
                  fontSize: 17,
                  overflow: TextOverflow.visible,
                ),
                RequestStatusIndicator(status: request.response),
              ],
            ),
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'edit') {
                editRequestDailog(context, request);
                log(request.requestId!);
              } else if (value == 'delete') {
                context.read<ActionBloc>().add(
                  RequestDelete(requestId: request.requestId!),
                );
              }
            },
            itemBuilder:
                (context) => [
                  PopupMenuItem(
                    value: 'edit',
                    child: Row(
                      children: [
                        Icon(Icons.edit),
                        SizedBox(width: 8),
                        Text('Edit'),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 'delete',
                    child: Row(
                      children: [
                        Icon(Icons.delete),
                        SizedBox(width: 8),
                        Text('Delete'),
                      ],
                    ),
                  ),
                ],
            icon: Icon(Icons.more_vert, color: color),
          ),
        ],
      ),
    );
  }
}

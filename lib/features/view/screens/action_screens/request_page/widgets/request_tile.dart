import 'package:flutter/material.dart';
import 'package:travelgo_organizer/data/models/request_data.dart';
import 'package:travelgo_organizer/features/view/screens/action_screens/request_page/widgets/request_status_indicator.dart';
import 'package:travelgo_organizer/features/view/widgets/text_fw.dart';

class RequestTile extends StatelessWidget {
  final RequestData request;
  const RequestTile({super.key, required this.request});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(),
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
                } else if (value == 'delete') {}
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
              icon: Icon(Icons.more_vert),
            ),
          ],
        ),
      ),
    );
  }
}

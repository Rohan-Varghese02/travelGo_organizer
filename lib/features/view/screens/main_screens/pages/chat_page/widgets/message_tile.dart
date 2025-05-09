import 'package:flutter/material.dart';
import 'package:travelgo_organizer/data/models/message_data.dart';
import 'package:travelgo_organizer/features/view/screens/main_screens/pages/chat_page/widgets/chat_bubble.dart';


class MessageTile extends StatelessWidget {
  final MessageData message;
  final String currentUser;
  const MessageTile({
    super.key,
    required this.message,
    required this.currentUser,
  });

  @override
  Widget build(BuildContext context) {
    bool isCurrentUser = message.senderID == currentUser;
    return SizedBox(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment:
              isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            ChatBubble(message: message.message, isCurrentUser: isCurrentUser, timestamp: message.timestamp,),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:travelgo_organizer/core/constants/colors.dart';
import 'package:travelgo_organizer/data/models/chat_data.dart';
import 'package:travelgo_organizer/features/view/widgets/style_text.dart';

class ChatTile extends StatelessWidget {
  final ChatData chatData;
  const ChatTile({super.key, required this.chatData});

  @override
  Widget build(BuildContext context) {
    final timeText = DateFormat(
      'HH:mm',
    ).format(chatData.lastMessageTime.toDate());

    return Container(
      decoration: BoxDecoration(border: Border.all(width: 1, color: grey20)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(chatData.userImage),
        ),
        title: StyleText(text: chatData.userName),
        subtitle:
            chatData.lastMessagebool
                ? StyleText(text: chatData.lastMessage)
                : StyleText(
                  text: chatData.lastMessage,
                  fontWeight: FontWeight.bold,
                ),
        trailing:
            chatData.lastMessagebool
                ? StyleText(text: timeText)
                : Icon(Icons.circle_notifications, color: success),
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:travelgo_organizer/core/constants/colors.dart';
import 'package:travelgo_organizer/features/view/widgets/style_text.dart';


class ChatBubble extends StatelessWidget {
  final Timestamp timestamp;
  final String message;
  final bool isCurrentUser;

  const ChatBubble({
    super.key,
    required this.message,
    required this.isCurrentUser,
    required this.timestamp,
  });

  @override
  Widget build(BuildContext context) {
    final timeText = DateFormat('HH:mm').format(timestamp.toDate());

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Row(
        mainAxisAlignment:
            isCurrentUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isCurrentUser)
            StyleText(text: timeText, size: 10, color: grey50),
          if (!isCurrentUser) const SizedBox(width: 6),

          Flexible(
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isCurrentUser ? themeColor : white,
                borderRadius: BorderRadius.circular(10),
                border:
                    isCurrentUser
                        ? null
                        : Border.all(width: 0.2, color: grey30),
              ),
              child: StyleText(
                text: message,
                color: isCurrentUser ? white : black,
                softWrap: true,
              ),
            ),
          ),

          if (isCurrentUser) const SizedBox(width: 6),
          if (isCurrentUser) StyleText(text: timeText, size: 10, color: grey50),
        ],
      ),
    );
  }
}

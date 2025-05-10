import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:travelgo_organizer/core/constants/colors.dart';
import 'package:travelgo_organizer/core/services/chat_services.dart';
import 'package:travelgo_organizer/data/models/chat_data.dart';
import 'package:travelgo_organizer/data/models/message_data.dart';
import 'package:travelgo_organizer/data/models/organizer_data.dart';
import 'package:travelgo_organizer/features/view/screens/main_screens/pages/chat_page/widgets/chat_custom_appBar.dart';
import 'package:travelgo_organizer/features/view/screens/main_screens/pages/chat_page/widgets/message_tile.dart';
import 'package:travelgo_organizer/features/view/widgets/style_text.dart';

class ChatDetailedPage extends StatefulWidget {
  final OrganizerDataModel organizerData;
  final ChatData chatData;
  ChatDetailedPage({
    super.key,
    required this.organizerData,
    required this.chatData,
  });

  @override
  State<ChatDetailedPage> createState() => _ChatDetailedPageState();
}

class _ChatDetailedPageState extends State<ChatDetailedPage> {
  @override
  void initState() {
    super.initState();
    ChatServices().updateSeen(
      Timestamp.now(),
      widget.organizerData.uid,
      widget.chatData.userUid,
    );
  }

  TextEditingController messageController = TextEditingController();

  Map<String, List<MessageData>> groupMessagesByDate(
    List<MessageData> messages,
  ) {
    Map<String, List<MessageData>> grouped = {};

    for (var message in messages) {
      final date = message.timestamp.toDate();
      final now = DateTime.now();

      String label;
      if (DateUtils.isSameDay(date, now)) {
        label = 'Today';
      } else if (DateUtils.isSameDay(date, now.subtract(Duration(days: 1)))) {
        label = 'Yesterday';
      } else {
        label = DateFormat('MMMM d, yyyy').format(date);
      }

      grouped.putIfAbsent(label, () => []).add(message);
    }

    return grouped;
  }

  void sendMessage() async {
    if (messageController.text.isNotEmpty) {
      await ChatServices().sendMessage(
        widget.chatData.userUid,
        messageController.text,
        widget.organizerData.uid,
        widget.organizerData.email,
      );
      await ChatServices().updateMessageandTime(
        messageController.text,
        Timestamp.now(),
        widget.organizerData.uid,
        widget.chatData.userUid,
      );
      await ChatServices().updateMessageandTimeOrganizer(
        messageController.text,
        Timestamp.now(),
        widget.organizerData.uid,
        widget.chatData.userUid,
      );
      messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    String senderID = widget.organizerData.uid;
    String recieverID = widget.chatData.userUid;
    return Scaffold(
      appBar: ChatCustomAppBar(
        title: widget.chatData.userName,
        color: white,
        picUrl: widget.chatData.userImage,
        backgroundColor: themeColor,
        showBack: true,
      ),
      body: Column(
        children: [
          Flexible(
            child: StreamBuilder(
              stream: ChatServices().getMessage(senderID, recieverID),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Error');
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: StyleText(text: 'Loading'));
                }
                if (snapshot.data!.isEmpty) {
                  return Center(
                    child: StyleText(
                      text: 'Start the conversation with Organizer',
                    ),
                  );
                }
                final messages = snapshot.data!;
                final groupedMessages = groupMessagesByDate(messages);
                final List<String> dateKeys = groupedMessages.keys.toList();

                return ListView.builder(
                  itemCount: groupedMessages.values.fold<int>(
                    0,
                    (prev, list) => prev + list.length + 1,
                  ),
                  itemBuilder: (context, index) {
                    int counter = 0;

                    for (var date in dateKeys) {
                      final msgs = groupedMessages[date]!;

                      if (index == counter) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Center(
                            child: Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: grey20,
                              ),
                              child: StyleText(text: date),
                            ),
                          ),
                        );
                      }

                      counter++; // for header

                      for (var msg in msgs) {
                        if (index == counter) {
                          return MessageTile(
                            message: msg,
                            currentUser: widget.organizerData.uid,
                          );
                        }
                        counter++;
                      }
                    }

                    return SizedBox.shrink(); // fallback
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messageController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Send Message',
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Container(
                  height: 55,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: themeColor,
                  ),
                  child: IconButton(
                    onPressed: sendMessage,
                    icon: Icon(Icons.arrow_upward, color: white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

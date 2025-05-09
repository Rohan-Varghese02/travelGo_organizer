
import 'package:flutter/material.dart';
import 'package:travelgo_organizer/core/constants/colors.dart';
import 'package:travelgo_organizer/core/services/stream_services.dart';
import 'package:travelgo_organizer/data/models/organizer_data.dart';
import 'package:travelgo_organizer/features/view/screens/main_screens/pages/chat_page/chat_detailed_page.dart';
import 'package:travelgo_organizer/features/view/screens/main_screens/pages/chat_page/widgets/chat_tile.dart';
import 'package:travelgo_organizer/features/view/widgets/custom_app_bar.dart';
import 'package:travelgo_organizer/features/view/widgets/style_text.dart';

class ChatPage extends StatelessWidget {
  final OrganizerDataModel organizerData;
  const ChatPage({super.key, required this.organizerData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Chat',
        color: white,
        backgroundColor: themeColor,
        center: true,
        showBack: false,
      ),
      body: StreamBuilder(
        stream: StreamServices().getChat(organizerData.uid),
        builder: (context, snapshot) {
          if (!snapshot.hasData ||
              snapshot.data == null ||
              snapshot.data!.isEmpty) {
            return Center(child: StyleText(text: 'No active chats'));
          } else {
            final chats = snapshot.data;
            return ListView.builder(
              itemCount: chats!.length,
              itemBuilder: (context, index) {
                final chat = chats[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder:
                              (context) => ChatDetailedPage(
                                organizerData: organizerData,
                                chatData: chat,
                              ),
                        ),
                      );
                    },
                    child: ChatTile(chatData: chat),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}

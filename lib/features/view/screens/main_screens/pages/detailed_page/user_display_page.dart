import 'package:flutter/material.dart';
import 'package:travelgo_organizer/core/constants/colors.dart';
import 'package:travelgo_organizer/core/services/stream_services.dart';
import 'package:travelgo_organizer/features/view/screens/main_screens/pages/detailed_page/widgets/user_tile.dart';
import 'package:travelgo_organizer/features/view/widgets/custom_app_bar.dart';
import 'package:travelgo_organizer/features/view/widgets/style_text.dart';

class UserDisplayPage extends StatelessWidget {
  final String postId;
  const UserDisplayPage({super.key, required this.postId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Registered Clients',
        color: white,
        backgroundColor: themeColor,
        center: true,
      ),
      body: StreamBuilder(
        stream: StreamServices().getClients(postId),
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: StyleText(text: 'No Users Registered'));
          }
          final users = snapshot.data!;
          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              return UserTile(user: user);
            },
          );
        },
      ),
    );
  }
}

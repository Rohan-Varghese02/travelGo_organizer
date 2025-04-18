import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:travelgo_organizer/core/constants/colors.dart';
import 'package:travelgo_organizer/core/services/auth/authservice.dart';
import 'package:travelgo_organizer/core/services/stream_services.dart';
import 'package:travelgo_organizer/data/models/post_data.dart';

class MyEventPage extends StatefulWidget {
  const MyEventPage({super.key});

  @override
  State<MyEventPage> createState() => _MyEventPageState();
}

class _MyEventPageState extends State<MyEventPage> {
  String uid = '';
  @override
  void initState() {
    super.initState();
    uid = Authservice().getUserUid();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'My Events',
          style: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: themeColor,
          ),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder<List<PostDataModel>>(
        stream: StreamServices().getPostsByOrganizer(uid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Text('No posts found.');
          }

          final posts = snapshot.data!;
          return ListView.separated(
            itemCount: posts.length,
            itemBuilder: (context, index) {
              final post = posts[index];
              final date = DateTime.parse(post.registrationDeadline);
              final formattedDate = DateFormat('MMMM dd, yy').format(date);
              return ListTile(
                leading: SizedBox(
                  width: 72,
                  height: 200,
                  child: Image(
                    image: NetworkImage(post.imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
                title: Text(
                  post.name,
                  style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  'Time : $formattedDate',
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w300),
                ),
                trailing: PopupMenuButton<String>(
                  onSelected: (value) {
                    log(value);
                  },
                  itemBuilder:
                      (context) => [
                        const PopupMenuItem(value: 'edit', child: Text('Edit')),
                        const PopupMenuItem(
                          value: 'delete',
                          child: Text('Delete'),
                        ),
                      ],
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) => Divider(),
          );
        },
      ),
    );
  }
}

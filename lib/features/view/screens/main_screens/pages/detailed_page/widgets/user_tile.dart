import 'package:flutter/material.dart';
import 'package:travelgo_organizer/core/constants/colors.dart';
import 'package:travelgo_organizer/data/models/userdata.dart';
import 'package:travelgo_organizer/features/view/widgets/style_text.dart';

class UserTile extends StatefulWidget {
  final Userdata user;
  const UserTile({super.key, required this.user});

  @override
  State<UserTile> createState() => _UserTileState();
}

class _UserTileState extends State<UserTile> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final user = widget.user;

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GestureDetector(
        onTap: () => setState(() => _isExpanded = !_isExpanded),
        child: Container(
          padding: EdgeInsets.all(10),
          width: width,
          decoration: BoxDecoration(
            color: white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: black.withOpacity(0.1),
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(backgroundImage: NetworkImage(user.userImage)),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        StyleText(
                          text: user.userName,
                          size: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        StyleText(
                          text: user.userEmail,
                          size: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                  ),
                  // Icon(Icons.message),
                ],
              ),
              if (_isExpanded && user.tickets.isNotEmpty) ...[
                SizedBox(height: 10),
                Divider(),
                StyleText(
                  text: 'Tickets Purchased:',
                  size: 15,
                  fontWeight: FontWeight.bold,
                ),
                ...user.tickets.entries.map(
                  (entry) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2.0),
                    child: StyleText(
                      text: '${entry.key}: ${entry.value}',
                      size: 14,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:travelgo_organizer/features/view/widgets/style_text.dart';

class ChatCustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String picUrl;
  final String title;
  final List<Widget>? actions;
  final bool? center;
  final Color color;
  final bool showBack;
  final Color? backgroundColor;
  const ChatCustomAppBar({
    super.key,
    required this.title,
    this.actions,
    this.showBack = false,
    required this.color,
    this.backgroundColor,
    this.center,
    required this.picUrl,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading:
          showBack
              ? IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(Icons.arrow_back, color: color),
              )
              : SizedBox(),
      title: Row(
        children: [
          CircleAvatar(backgroundImage: NetworkImage(picUrl)),
          SizedBox(width: 10),
          StyleText(
            text: title,
            color: color,
            size: 20,
            fontWeight: FontWeight.w500,
          ),
        ],
      ),
      automaticallyImplyLeading: showBack,
      actions: actions,
      centerTitle: center,
      backgroundColor: backgroundColor,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

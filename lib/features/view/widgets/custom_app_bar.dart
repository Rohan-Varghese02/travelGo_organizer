import 'package:flutter/material.dart';
import 'package:travelgo_organizer/features/view/widgets/style_text.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final bool? center;
  final Color color;
  final bool showBack;
  final Color? backgroundColor;
  final double? size;
  const CustomAppBar({
    super.key,
    required this.title,
    this.actions,
    this.showBack = true,
    required this.color,
    this.backgroundColor,
    this.center,
    this.size,
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
      title: StyleText(
        text: title,
        color: color,
        size: size ?? 24,
        fontWeight: FontWeight.w500,
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

import 'package:flutter/material.dart';
import 'package:travelgo_organizer/core/constants/colors.dart';
import 'package:travelgo_organizer/features/view/widgets/style_text.dart';

class DetailedAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String subtitle;
  final List<Widget>? actions;
  final bool? center;
  final Color color;
  final bool showBack;
  final Color? backgroundColor;
  final double? size;
  const DetailedAppBar({
    super.key,
    required this.title,
    required this.subtitle,
    this.actions,
    this.center,
    required this.color,
    required this.showBack,
    this.backgroundColor,
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
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StyleText(
            text: title,
            color: whiteBg,
            size: 26,
            fontWeight: FontWeight.w500,
          ),
          StyleText(
            text: subtitle,
            color: white,
            size: 15,
            fontWeight: FontWeight.w300,
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

import 'package:flutter/material.dart';

class EventPic extends StatelessWidget {
  final String pic;
  const EventPic({super.key, required this.pic});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      height: 400,
      width: width,
      decoration: BoxDecoration(
        image: DecorationImage(image: NetworkImage(pic), fit: BoxFit.cover),
      ),
    );
  }
}

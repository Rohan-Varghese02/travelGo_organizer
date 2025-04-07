import 'package:flutter/material.dart';

class LoginDivider extends StatelessWidget {
  const LoginDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Divider(),
        Text('Or'),
        Divider()
      ],
    );
  }
}
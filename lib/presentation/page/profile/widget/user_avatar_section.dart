import 'package:flutter/material.dart';

class UserAvatarSection extends StatelessWidget {
  const UserAvatarSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 120,
      width: 120,
      child: CircleAvatar(
        backgroundImage: AssetImage(
          'assets/images/test.jpg',
        ),
      ),
    );
  }
}

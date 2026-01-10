import 'package:flutter/material.dart';

class UserFullNameSection extends StatelessWidget {
  const UserFullNameSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Yozhykov Maksim',
      style: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}

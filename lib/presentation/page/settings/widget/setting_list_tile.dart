import 'package:flutter/material.dart';

class SettingListTile extends StatelessWidget {
  final String text;
  final Widget trailing;

  const SettingListTile({
    super.key,
    required this.text,
    required this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        text,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      trailing: trailing,
    );
  }
}

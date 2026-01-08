import 'package:flutter/material.dart';

class SettingListTile extends StatelessWidget {
  final String text;
  final IconData leadingIcon;
  final Widget trailing;

  const SettingListTile({
    super.key,
    required this.text,
    required this.leadingIcon,
    required this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        size: 36,
        leadingIcon,
        color: const Color(0xFF007DFC),
      ),
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

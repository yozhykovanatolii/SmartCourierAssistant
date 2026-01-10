import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class SectionListTile extends StatelessWidget {
  final String leadingEmoji;
  final String title;
  final Function()? onTap;
  final bool isLogOut;

  const SectionListTile({
    super.key,
    required this.leadingEmoji,
    required this.title,
    this.isLogOut = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Text(
        leadingEmoji,
        style: const TextStyle(
          fontSize: 24,
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isLogOut ? Colors.red : null,
          fontSize: 19,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: const Icon(
        Iconsax.arrow_right_3_copy,
        size: 24,
      ),
    );
  }
}

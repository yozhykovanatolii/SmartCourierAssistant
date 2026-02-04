import 'package:flutter/material.dart';

class ActionFloatingButton extends StatelessWidget {
  final IconData icon;
  final String? heroTag;
  final Function()? onPressed;

  const ActionFloatingButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.heroTag,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      shape: const CircleBorder(),
      heroTag: heroTag,
      child: Icon(icon),
    );
  }
}

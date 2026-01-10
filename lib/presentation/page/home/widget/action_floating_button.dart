import 'package:flutter/material.dart';

class ActionFloatingButton extends StatelessWidget {
  final IconData icon;
  final Color foregroundColor;
  final String? heroTag;
  final Function()? onPressed;

  const ActionFloatingButton({
    super.key,
    required this.icon,
    required this.foregroundColor,
    required this.onPressed,
    this.heroTag,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: Colors.white,
      foregroundColor: foregroundColor,
      shape: const CircleBorder(),
      heroTag: heroTag,
      child: Icon(icon),
    );
  }
}

import 'package:flutter/material.dart';

class SnackBarBody extends StatelessWidget {
  final int backgroundColor;
  final int color;
  final String message;
  final IconData iconData;

  const SnackBarBody({
    super.key,
    required this.backgroundColor,
    required this.color,
    required this.iconData,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      constraints: const BoxConstraints(minHeight: 57),
      decoration: BoxDecoration(
        color: Color(backgroundColor),
        border: Border.all(
          color: Color(color),
          width: 2,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        spacing: 10,
        children: [
          Icon(
            iconData,
            color: Color(color),
          ),
          Expanded(
            child: Text(
              message,
              style: TextStyle(
                color: Color(color),
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

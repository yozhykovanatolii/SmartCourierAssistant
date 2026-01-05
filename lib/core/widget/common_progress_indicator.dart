import 'package:flutter/material.dart';

class CommonProgressIndicator extends StatelessWidget {
  final double? scale;
  final Color color;

  const CommonProgressIndicator({
    super.key,
    this.scale,
    this.color = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: scale,
      child: CircularProgressIndicator(
        color: color,
      ),
    );
  }
}

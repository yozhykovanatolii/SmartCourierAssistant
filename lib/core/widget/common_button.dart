import 'package:flutter/material.dart';

class CommonButton extends StatelessWidget {
  final Function()? onPressed;
  final Widget child;
  final Color color;
  final double? width;

  const CommonButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.color = Colors.blue,
    this.width = 300,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: MediaQuery.of(context).size.height * 0.06,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          elevation: const WidgetStatePropertyAll(10),
          backgroundColor: WidgetStatePropertyAll(color),
          foregroundColor: const WidgetStatePropertyAll(Colors.black),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        child: child,
      ),
    );
  }
}

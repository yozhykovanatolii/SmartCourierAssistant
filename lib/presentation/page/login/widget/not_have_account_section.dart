import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class NotHaveAccountSection extends StatelessWidget {
  const NotHaveAccountSection({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: 'Don\'t have an account?',
        style: TextStyle(
          fontSize: 15,
          color: Colors.grey[500],
        ),
        children: [
          const WidgetSpan(
            child: SizedBox(width: 5),
          ),
          TextSpan(
            text: 'Sign Up',
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
              decorationThickness: 2,
              color: Colors.blue,
            ),
            recognizer: TapGestureRecognizer()..onTap = () {},
          ),
        ],
      ),
    );
  }
}

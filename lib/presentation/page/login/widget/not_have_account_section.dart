import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:smart_courier_assistant/core/localization/generated/l10n.dart';
import 'package:smart_courier_assistant/presentation/page/register/register_page.dart';

class NotHaveAccountSection extends StatelessWidget {
  const NotHaveAccountSection({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: S.of(context).dontHaveAnAccount,
        style: TextStyle(
          fontSize: 15,
          color: Colors.grey[500],
        ),
        children: [
          const WidgetSpan(
            child: SizedBox(width: 5),
          ),
          TextSpan(
            text: S.of(context).signUp,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
              decorationThickness: 2,
              color: Colors.blue,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const RegisterPage()),
                );
              },
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:smart_courier_assistant/core/widget/common_button.dart';

class ResetPasswordButton extends StatelessWidget {
  const ResetPasswordButton({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonButton(
      width: MediaQuery.of(context).size.width,
      onPressed: () {},
      child: const Text(
        'Reset password',
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
        ),
      ),
    );
  }
}

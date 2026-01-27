import 'package:flutter/material.dart';
import 'package:smart_courier_assistant/core/widget/common_button.dart';

class ConfirmButton extends StatelessWidget {
  const ConfirmButton({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonButton(
      width: MediaQuery.of(context).size.width,
      onPressed: () {},
      child: const Text(
        'Confirm',
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
        ),
      ),
    );
  }
}

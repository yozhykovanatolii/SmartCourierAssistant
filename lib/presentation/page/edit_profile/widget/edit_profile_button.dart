import 'package:flutter/material.dart';
import 'package:smart_courier_assistant/core/widget/common_button.dart';

class EditProfileButton extends StatelessWidget {
  const EditProfileButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CommonButton(
      width: MediaQuery.of(context).size.width,
      onPressed: () {},
      color: const Color(0xFF007DFC),
      child: Text(
        'Save',
        style: TextStyle(
          fontSize: MediaQuery.textScalerOf(context).scale(18),
          color: Colors.white,
        ),
      ),
    );
  }
}

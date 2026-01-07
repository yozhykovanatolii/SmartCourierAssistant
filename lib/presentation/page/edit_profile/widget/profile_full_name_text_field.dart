import 'package:flutter/material.dart';
import 'package:smart_courier_assistant/core/widget/common_text_field.dart';

class ProfileFullNameTextField extends StatelessWidget {
  final TextEditingController? controller;

  const ProfileFullNameTextField({
    super.key,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return CommonTextField(
      controller: controller,
      onChanged: (fullName) {},
      hintText: 'Enter your full name',
      //errorText: fullNameError,
    );
  }
}

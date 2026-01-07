import 'package:flutter/material.dart';
import 'package:smart_courier_assistant/core/widget/common_text_field.dart';

class ProfilePhoneNumberTextField extends StatelessWidget {
  final TextEditingController? controller;

  const ProfilePhoneNumberTextField({
    super.key,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return CommonTextField(
      controller: controller,
      onChanged: (phoneNumber) {},
      hintText: 'Enter your phone number',
      //errorText: phoneNumberError,
    );
  }
}

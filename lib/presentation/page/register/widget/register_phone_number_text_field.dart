import 'package:flutter/material.dart';
import 'package:smart_courier_assistant/core/widget/common_text_field.dart';

class RegisterPhoneNumberTextField extends StatelessWidget {
  const RegisterPhoneNumberTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonTextField(
      onChanged: (phoneNumber) => print(phoneNumber),
      hintText: 'Enter your phone number',
      //errorText: phoneNumberError,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:smart_courier_assistant/core/widget/common_text_field.dart';

class ClientPhoneNumberTextField extends StatelessWidget {
  const ClientPhoneNumberTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonTextField(
      onChanged: (phoneNumber) => print(phoneNumber),
      hintText: 'Enter client phone number',
      //errorText: phoneNumberError,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:smart_courier_assistant/core/widget/common_text_field.dart';

class ClientFullNameTextField extends StatelessWidget {
  const ClientFullNameTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonTextField(
      onChanged: (fullName) => print(fullName),
      hintText: 'Enter client full name',
      //errorText: fullNameError,
    );
  }
}

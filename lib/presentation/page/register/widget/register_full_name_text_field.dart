import 'package:flutter/material.dart';
import 'package:smart_courier_assistant/core/widget/common_text_field.dart';

class RegisterFullNameTextField extends StatelessWidget {
  const RegisterFullNameTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonTextField(
      onChanged: (fullName) => print(fullName),
      hintText: 'Enter your full name',
      //errorText: fullNameError,
    );
  }
}

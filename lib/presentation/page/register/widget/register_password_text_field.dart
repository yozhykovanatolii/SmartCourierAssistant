import 'package:flutter/material.dart';
import 'package:smart_courier_assistant/core/widget/common_text_field.dart';

class RegisterPasswordTextField extends StatelessWidget {
  const RegisterPasswordTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonTextField(
      onChanged: (password) => print(password),
      hintText: 'Enter your password',
      obscureText: true,
      //errorText: passwordError,
    );
  }
}

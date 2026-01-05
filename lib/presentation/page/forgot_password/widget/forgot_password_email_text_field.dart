import 'package:flutter/material.dart';
import 'package:smart_courier_assistant/core/widget/common_text_field.dart';

class ForgotPasswordEmailTextField extends StatelessWidget {
  const ForgotPasswordEmailTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonTextField(
      onChanged: (email) => print(email),
      hintText: 'Enter your email',
      //errorText: emailErrorMessage,
    );
  }
}

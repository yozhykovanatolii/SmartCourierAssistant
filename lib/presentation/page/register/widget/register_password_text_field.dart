import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_courier_assistant/core/widget/common_text_field.dart';
import 'package:smart_courier_assistant/presentation/bloc/register/register_cubit.dart';
import 'package:smart_courier_assistant/presentation/bloc/register/register_state.dart';

class RegisterPasswordTextField extends StatelessWidget {
  const RegisterPasswordTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<RegisterCubit, RegisterState, String?>(
      selector: (state) => state.passwordError,
      builder: (context, passwordError) {
        return CommonTextField(
          onChanged: (password) =>
              context.read<RegisterCubit>().setRegisterPassword(password),
          hintText: 'Enter your password',
          obscureText: true,
          errorText: passwordError,
        );
      },
    );
  }
}

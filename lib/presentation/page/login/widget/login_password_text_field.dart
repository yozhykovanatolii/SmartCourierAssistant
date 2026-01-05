import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_courier_assistant/core/widget/common_text_field.dart';
import 'package:smart_courier_assistant/presentation/bloc/login/login_cubit.dart';
import 'package:smart_courier_assistant/presentation/bloc/login/login_state.dart';

class LoginPasswordTextField extends StatelessWidget {
  const LoginPasswordTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<LoginCubit, LoginState, String?>(
      selector: (state) => state.passwordError,
      builder: (context, passwordError) {
        return CommonTextField(
          onChanged: (password) =>
              context.read<LoginCubit>().setLoginPassword(password),
          hintText: 'Enter your password',
          errorText: passwordError,
          obscureText: true,
        );
      },
    );
  }
}

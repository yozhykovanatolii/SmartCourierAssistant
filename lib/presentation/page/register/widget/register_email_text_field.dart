import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_courier_assistant/core/widget/common_text_field.dart';
import 'package:smart_courier_assistant/presentation/bloc/register/register_cubit.dart';
import 'package:smart_courier_assistant/presentation/bloc/register/register_state.dart';

class RegisterEmailTextField extends StatelessWidget {
  const RegisterEmailTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<RegisterCubit, RegisterState, String?>(
      selector: (state) => state.emailError,
      builder: (context, emailError) {
        return CommonTextField(
          onChanged: (email) =>
              context.read<RegisterCubit>().setRegisterEmail(email),
          hintText: 'Enter your email',
          errorText: emailError,
        );
      },
    );
  }
}

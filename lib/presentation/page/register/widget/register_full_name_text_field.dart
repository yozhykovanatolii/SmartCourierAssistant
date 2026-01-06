import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_courier_assistant/core/widget/common_text_field.dart';
import 'package:smart_courier_assistant/presentation/bloc/register/register_cubit.dart';
import 'package:smart_courier_assistant/presentation/bloc/register/register_state.dart';

class RegisterFullNameTextField extends StatelessWidget {
  const RegisterFullNameTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<RegisterCubit, RegisterState, String?>(
      selector: (state) => state.fullNameError,
      builder: (context, fullNameError) {
        return CommonTextField(
          onChanged: (fullName) =>
              context.read<RegisterCubit>().setRegisterFullName(fullName),
          hintText: 'Enter your full name',
          errorText: fullNameError,
        );
      },
    );
  }
}

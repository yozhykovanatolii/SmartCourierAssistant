import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_courier_assistant/core/widget/common_text_field.dart';
import 'package:smart_courier_assistant/presentation/bloc/register/register_cubit.dart';
import 'package:smart_courier_assistant/presentation/bloc/register/register_state.dart';

class RegisterPhoneNumberTextField extends StatelessWidget {
  const RegisterPhoneNumberTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<RegisterCubit, RegisterState, String?>(
      selector: (state) => state.phoneNumberError,
      builder: (context, phoneNumberError) {
        return CommonTextField(
          onChanged: (phoneNumber) =>
              context.read<RegisterCubit>().setRegisterPhoneNumber(phoneNumber),
          hintText: 'Enter your phone number',
          errorText: phoneNumberError,
        );
      },
    );
  }
}

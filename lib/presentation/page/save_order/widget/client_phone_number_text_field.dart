import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_courier_assistant/core/widget/common_text_field.dart';
import 'package:smart_courier_assistant/presentation/bloc/save_order/save_order_cubit.dart';

class ClientPhoneNumberTextField extends StatelessWidget {
  final TextEditingController? clientPhoneNumberController;

  const ClientPhoneNumberTextField({
    super.key,
    this.clientPhoneNumberController,
  });

  @override
  Widget build(BuildContext context) {
    final clientPhoneNumberError = context.select(
      (SaveOrderCubit saveOrderCubit) =>
          saveOrderCubit.state.clientPhoneNumberError,
    );
    return CommonTextField(
      controller: clientPhoneNumberController,
      onChanged: (phoneNumber) =>
          context.read<SaveOrderCubit>().setClientPhoneNumber(phoneNumber),
      hintText: 'Enter client phone number',
      errorText: clientPhoneNumberError,
    );
  }
}

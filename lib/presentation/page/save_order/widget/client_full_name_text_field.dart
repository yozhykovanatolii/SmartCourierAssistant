import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_courier_assistant/core/widget/common_text_field.dart';
import 'package:smart_courier_assistant/presentation/bloc/save_order/save_order_cubit.dart';

class ClientFullNameTextField extends StatelessWidget {
  const ClientFullNameTextField({super.key});

  @override
  Widget build(BuildContext context) {
    final clientFullNameError = context.select(
      (SaveOrderCubit saveOrderCubit) =>
          saveOrderCubit.state.clientFullNameError,
    );
    return CommonTextField(
      onChanged: (fullName) =>
          context.read<SaveOrderCubit>().setClientFullName(fullName),
      hintText: 'Enter client full name',
      errorText: clientFullNameError,
    );
  }
}

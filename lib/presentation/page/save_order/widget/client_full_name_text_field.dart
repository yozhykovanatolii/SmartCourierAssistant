import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_courier_assistant/core/widget/common_text_field.dart';
import 'package:smart_courier_assistant/generated/l10n.dart';
import 'package:smart_courier_assistant/presentation/bloc/save_order/save_order_cubit.dart';

class ClientFullNameTextField extends StatelessWidget {
  final TextEditingController? clientFullNameController;

  const ClientFullNameTextField({
    super.key,
    this.clientFullNameController,
  });

  @override
  Widget build(BuildContext context) {
    final clientFullNameError = context.select(
      (SaveOrderCubit saveOrderCubit) =>
          saveOrderCubit.state.clientFullNameError,
    );
    return CommonTextField(
      controller: clientFullNameController,
      onChanged: (fullName) =>
          context.read<SaveOrderCubit>().setClientFullName(fullName),
      hintText: S.of(context).enterClientFullName,
      errorText: clientFullNameError,
    );
  }
}

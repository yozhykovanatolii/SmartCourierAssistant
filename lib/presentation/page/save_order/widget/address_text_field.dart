import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_courier_assistant/core/widget/common_text_field.dart';
import 'package:smart_courier_assistant/generated/l10n.dart';
import 'package:smart_courier_assistant/presentation/bloc/save_order/save_order_cubit.dart';

class AddressTextField extends StatelessWidget {
  final TextEditingController? addressController;

  const AddressTextField({
    super.key,
    this.addressController,
  });

  @override
  Widget build(BuildContext context) {
    final addressError = context.select(
      (SaveOrderCubit saveOrderCubit) => saveOrderCubit.state.addressError,
    );
    return CommonTextField(
      controller: addressController,
      onChanged: (address) =>
          context.read<SaveOrderCubit>().setOrderAddress(address),
      hintText: S.of(context).enterAddressOfOrder,
      errorText: addressError,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:smart_courier_assistant/core/widget/common_text_field.dart';
import 'package:smart_courier_assistant/presentation/bloc/save_order/save_order_cubit.dart';

class AddressTextField extends StatelessWidget {
  const AddressTextField({super.key});

  @override
  Widget build(BuildContext context) {
    final addressError = context.select(
      (SaveOrderCubit saveOrderCubit) => saveOrderCubit.state.addressError,
    );
    return CommonTextField(
      onChanged: (address) =>
          context.read<SaveOrderCubit>().setOrderAddress(address),
      hintText: 'Enter address of order',
      suffixIcon: IconButton(
        onPressed: () {},
        icon: const Icon(
          Iconsax.scan,
          color: Colors.blue,
        ),
      ),
      errorText: addressError,
    );
  }
}

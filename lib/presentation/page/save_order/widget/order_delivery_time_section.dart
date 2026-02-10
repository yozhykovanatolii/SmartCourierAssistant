import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_courier_assistant/core/util/ui/ui_helper.dart';
import 'package:smart_courier_assistant/core/localization/generated/l10n.dart';
import 'package:smart_courier_assistant/presentation/bloc/save_order/save_order_cubit.dart';

class OrderDeliveryTimeSection extends StatelessWidget {
  const OrderDeliveryTimeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          S.of(context).deliveryBy,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const _DeliveryTimeButton(),
      ],
    );
  }
}

class _DeliveryTimeButton extends StatelessWidget {
  const _DeliveryTimeButton();

  @override
  Widget build(BuildContext context) {
    final deliveryBy = context.select(
      (SaveOrderCubit saveOrderCubit) => saveOrderCubit.state.deliveryBy,
    );
    return TextButton(
      onPressed: () async {
        final saveOrderCubit = context.read<SaveOrderCubit>();
        final TimeOfDay newSelectedTime = await UiHelper.showTimePickerDialog(
          context: context,
          initialTime: TimeOfDay(
            hour: deliveryBy.hour,
            minute: deliveryBy.minute,
          ),
        );
        saveOrderCubit.chooseDeliveryTime(
          newSelectedTime.hour,
          newSelectedTime.minute,
        );
      },
      child: Text(
        '${deliveryBy.hour}:${deliveryBy.minute.toString().padLeft(2, '0')}',
        style: TextStyle(
          color: Colors.grey[500],
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

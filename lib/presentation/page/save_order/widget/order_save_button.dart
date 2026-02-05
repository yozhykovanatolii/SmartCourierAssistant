import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_courier_assistant/core/state/button_status.dart';
import 'package:smart_courier_assistant/core/state/form_status.dart';
import 'package:smart_courier_assistant/core/widget/common_button.dart';
import 'package:smart_courier_assistant/core/widget/common_progress_indicator.dart';
import 'package:smart_courier_assistant/data/model/order_model.dart';
import 'package:smart_courier_assistant/generated/l10n.dart';
import 'package:smart_courier_assistant/presentation/bloc/save_order/save_order_cubit.dart';
import 'package:smart_courier_assistant/presentation/bloc/save_order/save_order_state.dart';

class OrderSaveButton extends StatelessWidget {
  final OrderModel? orderModel;

  const OrderSaveButton({
    super.key,
    this.orderModel,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SaveOrderCubit, SaveOrderState>(
      builder: (context, state) {
        final buttonStatus = state.buttonStatus;
        final formStatus = state.formStatus;
        final color = buttonStatus == ButtonStatus.disabled
            ? Colors.grey
            : Colors.blue;
        final textColor = buttonStatus == ButtonStatus.disabled
            ? Colors.black
            : Colors.white;
        final child = formStatus == FormStatus.loading
            ? const CommonProgressIndicator(scale: 0.8)
            : Text(
                S.of(context).save,
                style: TextStyle(
                  color: textColor,
                  fontSize: 18,
                ),
              );
        final onPressed = buttonStatus == ButtonStatus.disabled
            ? null
            : () => context.read<SaveOrderCubit>().saveOrder(orderModel);
        return CommonButton(
          width: MediaQuery.of(context).size.width,
          onPressed: onPressed,
          color: color,
          child: child,
        );
      },
    );
  }
}

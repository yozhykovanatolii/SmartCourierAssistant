import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_courier_assistant/core/widget/common_button.dart';
import 'package:smart_courier_assistant/core/widget/common_progress_indicator.dart';
import 'package:smart_courier_assistant/presentation/bloc/login/login_state.dart';
import 'package:smart_courier_assistant/presentation/bloc/proof_delivery/proof_delivery_cubit.dart';
import 'package:smart_courier_assistant/presentation/bloc/proof_delivery/proof_delivery_state.dart';
import 'package:smart_courier_assistant/presentation/bloc/save_order/save_order_state.dart';

class ConfirmButton extends StatelessWidget {
  final String orderId;

  const ConfirmButton({
    super.key,
    required this.orderId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProofDeliveryCubit, ProofDeliveryState>(
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
                'Confirm',
                style: TextStyle(
                  color: textColor,
                  fontSize: 18,
                ),
              );
        final onPressed = buttonStatus == ButtonStatus.disabled
            ? null
            : () {
                context.read<ProofDeliveryCubit>().confirmDelivery(orderId);
              };
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

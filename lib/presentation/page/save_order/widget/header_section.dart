import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:smart_courier_assistant/core/util/ui/ui_helper.dart';
import 'package:smart_courier_assistant/core/widget/information_dialog_box.dart';
import 'package:smart_courier_assistant/generated/l10n.dart';
import 'package:smart_courier_assistant/presentation/bloc/order/order_cubit.dart';
import 'package:smart_courier_assistant/presentation/bloc/save_order/save_order_cubit.dart';

class HeaderSection extends StatelessWidget {
  final bool isEditing;
  const HeaderSection({
    super.key,
    required this.isEditing,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(Colors.grey[200]),
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(12),
              ),
            ),
          ),
          icon: const Icon(
            Iconsax.arrow_left_2_copy,
            color: Colors.black,
          ),
        ),
        Text(
          S.of(context).saveOrder,
          style: TextStyle(
            fontSize: MediaQuery.textScalerOf(context).scale(23),
            fontWeight: FontWeight.bold,
          ),
        ),
        isEditing
            ? IconButton(
                onPressed: () {
                  UiHelper.showConfirmDialog(
                    context,
                    InformationDialogBox(
                      title: S.of(context).deletingOrder,
                      description: S
                          .of(context)
                          .youreGoingToDeleteAnOrderAreYouSure,
                      onClickActionButton: () {
                        context.read<SaveOrderCubit>().deleteOrder();
                        context.read<OrderCubit>().fetchOrders();
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                    ),
                  );
                },
                icon: const Icon(
                  Iconsax.trash,
                  color: Colors.red,
                ),
              )
            : const SizedBox(width: 48),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:smart_courier_assistant/core/util/ui/ui_helper.dart';
import 'package:smart_courier_assistant/domain/entity/order_entity.dart';
import 'package:smart_courier_assistant/generated/l10n.dart';
import 'package:smart_courier_assistant/presentation/bloc/order/order_cubit.dart';
import 'package:smart_courier_assistant/presentation/page/proof_delivery/proof_delivery_page.dart';
import 'package:smart_courier_assistant/presentation/page/save_order/save_order_page.dart';

class OrderCard extends StatelessWidget {
  final int index;
  final OrderEntity order;

  const OrderCard({
    super.key,
    required this.index,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(width: 32),
            const SizedBox(width: 5),
            Expanded(child: _OrderCardContent(order)),
          ],
        ),
        Positioned(
          top: 0,
          left: 0,
          child: _IndexCircle(index: index),
        ),
        const Positioned(
          top: 40,
          left: 15,
          bottom: 0,
          child: _DottedLine(),
        ),
      ],
    );
  }
}

class _IndexCircle extends StatelessWidget {
  final int index;

  const _IndexCircle({required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32,
      height: 32,
      decoration: const BoxDecoration(
        color: Colors.blue,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Text(
        '$index',
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class _DottedLine extends StatelessWidget {
  const _DottedLine();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(
        20,
        (_) => Container(
          width: 2,
          height: 6,
          color: Colors.blue,
        ),
      ),
    );
  }
}

class _OrderCardContent extends StatelessWidget {
  final OrderEntity order;

  const _OrderCardContent(this.order);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _CardHeaderSection(order),
        Text(
          'ETA ${order.plannedEta.hour}:${order.plannedEta.minute.toString().padLeft(2, '0')} • ${order.deliveryRisk.text}',
          style: TextStyle(
            color: Color(order.deliveryRisk.color),
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          '${order.clientFullName} • ${order.category}',
          style: const TextStyle(
            color: Color(0xFF6E6E73),
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          spacing: 8,
          children: order.status == 'Delivered'
              ? []
              : [
                  Expanded(child: _OrderDoneButton(order.id)),
                  Expanded(
                    child: _OrderClientActionButton(
                      text: S.of(context).call,
                      backgroundColor: Colors.blue,
                      onPressed: () =>
                          context.read<OrderCubit>().openCallDialer(
                            order.clientPhoneNumber,
                          ),
                    ),
                  ),
                  Expanded(
                    child: _OrderClientActionButton(
                      text: S.of(context).chat,
                      backgroundColor: Colors.orange,
                      onPressed: () =>
                          context.read<OrderCubit>().openUserMessanger(
                            order.clientPhoneNumber,
                          ),
                    ),
                  ),
                ],
        ),
        const Divider(),
      ],
    );
  }
}

class _CardHeaderSection extends StatelessWidget {
  final OrderEntity order;

  const _CardHeaderSection(this.order);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            order.address.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        GestureDetector(
          onTap: order.status == 'Delivered'
              ? null
              : () {
                  UiHelper.showModalSheet(
                    context,
                    SaveOrderPage(
                      order: order,
                      isEditing: true,
                    ),
                  );
                },
          child: Icon(
            Iconsax.arrow_right_3_copy,
            size: 30,
            color: Colors.grey[500],
          ),
        ),
      ],
    );
  }
}

class _OrderDoneButton extends StatelessWidget {
  final String orderId;

  const _OrderDoneButton(this.orderId);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        UiHelper.showModalSheet(
          context,
          ProofDeliveryPage(
            orderId: orderId,
          ),
        );
      },
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(12),
        ),
        side: const BorderSide(
          color: Colors.green,
          width: 1.5,
        ),
      ),
      child: Text(
        S.of(context).done,
        style: const TextStyle(
          color: Colors.green,
          fontSize: 12.3,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _OrderClientActionButton extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final Function()? onPressed;

  const _OrderClientActionButton({
    required this.text,
    required this.onPressed,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.047,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(backgroundColor),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12.3,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

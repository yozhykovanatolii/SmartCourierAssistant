import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:smart_courier_assistant/core/util/ui_helper.dart';
import 'package:smart_courier_assistant/data/model/order_model.dart';
import 'package:smart_courier_assistant/presentation/page/save_order/save_order_page.dart';

class OrderCard extends StatelessWidget {
  final int index;
  final OrderModel order;

  const OrderCard({
    super.key,
    required this.index,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 5,
      children: [
        Column(
          children: [
            Container(
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
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: 2,
              height: 110,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(
                      10,
                      (index) => Container(
                        width: 2,
                        height: constraints.maxHeight / 30,
                        color: Colors.blue,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        Expanded(child: _OrderCardContent(order)),
      ],
    );
  }
}

class _OrderCardContent extends StatelessWidget {
  final OrderModel order;

  const _OrderCardContent(this.order);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _CardHeaderSection(order),
        const Text(
          'ETA 14:30 • ON TIME',
          style: TextStyle(
            color: Color(0xFF2ECC71),
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
        const SizedBox(height: 15),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          spacing: 8,
          children: [
            Expanded(child: _OrderDoneButton()),
            Expanded(
              child: _OrderClientActionButton(
                text: '📞 Call',
                backgroundColor: Colors.blue,
              ),
            ),
            Expanded(
              child: _OrderClientActionButton(
                text: '💬 Chat',
                backgroundColor: Colors.orange,
              ),
            ),
          ],
        ),
        const SizedBox(height: 5),
        const Divider(),
      ],
    );
  }
}

class _CardHeaderSection extends StatelessWidget {
  final OrderModel order;

  const _CardHeaderSection(this.order);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            order.address,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Color(0xFF1C1C1E),
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            UiHelper.showModalSheet(
              context,
              SaveOrderPage(
                orderModel: order,
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
  const _OrderDoneButton();

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {},
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(12),
        ),
        side: const BorderSide(
          color: Colors.green,
          width: 1.5,
        ),
      ),
      child: const Text(
        '✅ Done',
        style: TextStyle(
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

  const _OrderClientActionButton({
    required this.text,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.047,
      child: ElevatedButton(
        onPressed: () {},
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

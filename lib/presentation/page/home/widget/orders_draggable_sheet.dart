import 'package:flutter/material.dart';

class OrdersDraggableSheet extends StatelessWidget {
  const OrdersDraggableSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.2,
      minChildSize: 0.2,
      maxChildSize: 0.8,
      snap: true,
      builder: (context, scrollController) {
        return Container(
          padding: const EdgeInsetsGeometry.only(
            top: 10,
            left: 10,
            right: 10,
          ),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              Container(
                height: 3.5,
                width: 50,
                color: Colors.grey,
              ),
              const SizedBox(height: 10),
              const Text(
                'Orders',
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

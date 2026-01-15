import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_courier_assistant/core/widget/common_progress_indicator.dart';
import 'package:smart_courier_assistant/presentation/bloc/order/order_cubit.dart';
import 'package:smart_courier_assistant/presentation/bloc/order/order_state.dart';
import 'package:smart_courier_assistant/presentation/page/home/widget/error_orders_section.dart';
import 'package:smart_courier_assistant/presentation/page/home/widget/order_card.dart';

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
              const SizedBox(height: 20),
              Expanded(
                child: BlocBuilder<OrderCubit, OrderState>(
                  builder: (context, state) {
                    if (state is OrderFailureState) {
                      return ErrorOrdersSection(
                        errorMessage: state.errorMessage,
                      );
                    }
                    if (state is OrderSuccessState) {
                      final activeOrders = state.activeOrders;
                      return ListView.builder(
                        controller: scrollController,
                        itemBuilder: (context, index) {
                          return OrderCard(
                            index: index + 1,
                            order: activeOrders[index],
                          );
                        },
                        itemCount: activeOrders.length,
                      );
                    }
                    return const Center(
                      child: CommonProgressIndicator(
                        scale: 1.08,
                        color: Colors.blue,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

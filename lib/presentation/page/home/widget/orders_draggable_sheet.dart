import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_courier_assistant/core/widget/common_progress_indicator.dart';
import 'package:smart_courier_assistant/presentation/bloc/order/order_cubit.dart';
import 'package:smart_courier_assistant/presentation/bloc/order/order_state.dart';
import 'package:smart_courier_assistant/presentation/page/home/widget/error_orders_section.dart';
import 'package:smart_courier_assistant/presentation/page/home/widget/header_sheet_section.dart';
import 'package:smart_courier_assistant/presentation/page/home/widget/order_card.dart';

class OrdersDraggableSheet extends StatelessWidget {
  const OrdersDraggableSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.25,
      minChildSize: 0.25,
      maxChildSize: 0.8,
      snap: true,
      builder: (context, scrollController) {
        return Container(
          padding: const EdgeInsetsGeometry.only(
            top: 10,
            left: 10,
            right: 10,
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: const BorderRadius.vertical(
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
              const SizedBox(height: 20),
              const HeaderSheetSection(),
              const SizedBox(height: 20),
              Expanded(
                child: BlocBuilder<OrderCubit, OrderState>(
                  builder: (context, state) {
                    final status = state.status;
                    if (status == OrderStatus.failure) {
                      return ErrorOrdersSection(
                        errorMessage: state.errorMessage,
                      );
                    }
                    if (status == OrderStatus.success) {
                      final activeOrders = state.orders;
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

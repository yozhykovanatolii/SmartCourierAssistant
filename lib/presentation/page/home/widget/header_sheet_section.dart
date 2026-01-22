import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:smart_courier_assistant/presentation/bloc/order/order_cubit.dart';

class HeaderSheetSection extends StatelessWidget {
  const HeaderSheetSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Orders',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
        _OptimizeRouteButton(),
      ],
    );
  }
}

class _OptimizeRouteButton extends StatelessWidget {
  const _OptimizeRouteButton();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.read<OrderCubit>().optimizeOrdersRoute(),
      child: Row(
        spacing: 5,
        children: [
          const Icon(
            Iconsax.refresh_2,
            color: Colors.blue,
          ),
          Text(
            'Optimize route',
            style: TextStyle(
              fontSize: MediaQuery.textScalerOf(context).scale(17),
              fontWeight: FontWeight.w600,
              color: Colors.blue,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:smart_courier_assistant/core/util/ui/ui_helper.dart';
import 'package:smart_courier_assistant/generated/l10n.dart';
import 'package:smart_courier_assistant/presentation/bloc/order/order_cubit.dart';
import 'package:smart_courier_assistant/presentation/page/home/widget/route_optimization_dialog.dart';

class HeaderSheetSection extends StatelessWidget {
  const HeaderSheetSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          S.of(context).orders,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
        const _OptimizeRouteButton(),
      ],
    );
  }
}

class _OptimizeRouteButton extends StatelessWidget {
  const _OptimizeRouteButton();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //context.read<OrderCubit>().optimizeOrdersRoute();
        UiHelper.showConfirmDialog(
          context,
          const RouteOptimizationDialog(),
        );
      },
      child: Row(
        spacing: 5,
        children: [
          const Icon(
            Iconsax.refresh_2,
            color: Colors.blue,
          ),
          Text(
            S.of(context).optimizeRoute,
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

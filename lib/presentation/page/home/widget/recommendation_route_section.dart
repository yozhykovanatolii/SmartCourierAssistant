import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_courier_assistant/presentation/bloc/order/order_cubit.dart';

class RecommendationRouteSection extends StatelessWidget {
  const RecommendationRouteSection({super.key});

  @override
  Widget build(BuildContext context) {
    final recommendation = context.select(
      (OrderCubit orderCubit) => orderCubit.state.routeRecommendation,
    );
    if (recommendation.isEmpty) {
      return const SizedBox.shrink();
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFE3F2FD),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.auto_awesome_rounded,
            color: Color(0xFF1976D2),
            size: 20,
          ),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              recommendation,
              style: const TextStyle(
                color: Color(0xFF0D47A1),
                fontSize: 13.5,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

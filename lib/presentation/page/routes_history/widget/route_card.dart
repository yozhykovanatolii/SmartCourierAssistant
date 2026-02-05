import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:smart_courier_assistant/domain/entity/route_entity.dart';
import 'package:smart_courier_assistant/presentation/page/route_detail/route_detail_page.dart';

class RouteCard extends StatelessWidget {
  final RouteEntity route;

  const RouteCard({
    super.key,
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => RouteDetailPage(route: route)),
        );
      },
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                route.routeId,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  const Icon(
                    Icons.event,
                    size: 18,
                    color: Color(0xFF3B82F6),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    "${route.createAt.day}.${route.createAt.month}.${route.createAt.year}",
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF6B7280),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Icon(
                    Iconsax.box,
                    size: 18,
                    color: Color(0xFF4CAF50),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    "${route.ordersCount} orders",
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Icon(
                    Icons.error_outline,
                    size: 18,
                    color: Color(0xFFDC2626),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    "${route.delayedOrdersCount} delayed",
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFFDC2626),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

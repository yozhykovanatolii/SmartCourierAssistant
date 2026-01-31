import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:smart_courier_assistant/data/model/route_model.dart';
import 'package:smart_courier_assistant/presentation/page/route_detail/route_detail_page.dart';

class RouteCard extends StatelessWidget {
  final RouteModel route;

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
                "Route ${route.routeId}",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Color(0xFF111827),
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
                    "${route.date.day}.${route.date.month}.${route.date.year}",
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
                  const Text(
                    "10 orders",
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF111827),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Icon(
                    Icons.error_outline,
                    size: 18,
                    color: Color(0xFFDC2626),
                  ),
                  const SizedBox(width: 4),
                  const Text(
                    "2 delayed",
                    style: TextStyle(
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

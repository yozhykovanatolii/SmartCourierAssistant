import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class RouteCard extends StatelessWidget {
  final DateTime dateCreated;

  const RouteCard({
    super.key,
    required this.dateCreated,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
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
            const Text(
              "Route 0a045830-f60d-11f0-933d-438bad7f15f6",
              style: TextStyle(
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
                  "${dateCreated.day}.${dateCreated.month}.${dateCreated.year}",
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
    );
  }
}

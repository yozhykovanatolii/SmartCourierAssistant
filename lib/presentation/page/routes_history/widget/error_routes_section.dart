import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class ErrorRoutesSection extends StatelessWidget {
  final String errorMessage;

  const ErrorRoutesSection({
    super.key,
    required this.errorMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Iconsax.routing,
            size: 50,
            color: Color(0xFF9CA3BF),
          ),
          Text(
            errorMessage,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 18,
              color: Color(0xFF9CA3BF),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:smart_courier_assistant/generated/l10n.dart';

class HeaderProofDelivery extends StatelessWidget {
  const HeaderProofDelivery({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(Colors.grey[200]),
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(12),
              ),
            ),
          ),
          icon: const Icon(
            Iconsax.arrow_left_2_copy,
            color: Colors.black,
          ),
        ),
        Text(
          S.of(context).proofOfDelivery,
          style: TextStyle(
            fontSize: MediaQuery.textScalerOf(context).scale(23),
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 48),
      ],
    );
  }
}

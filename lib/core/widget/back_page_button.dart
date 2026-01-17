import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class BackPageButton extends StatelessWidget {
  const BackPageButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => Navigator.pop(context),
      icon: const Icon(
        Iconsax.arrow_left_2_copy,
        color: Colors.black,
      ),
    );
  }
}

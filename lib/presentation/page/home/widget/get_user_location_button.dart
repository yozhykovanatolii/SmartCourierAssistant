import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class GetUserLocationButton extends StatelessWidget {
  const GetUserLocationButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {},
      heroTag: 'GetUserLocation',
      backgroundColor: Colors.white,
      foregroundColor: Colors.blue,
      shape: const CircleBorder(),
      child: const Icon(Iconsax.gps),
    );
  }
}

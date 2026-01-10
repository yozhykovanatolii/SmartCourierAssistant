import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:smart_courier_assistant/presentation/page/home/widget/action_floating_button.dart';
import 'package:smart_courier_assistant/presentation/page/home/widget/google_map_section.dart';
import 'package:smart_courier_assistant/presentation/page/home/widget/orders_draggable_sheet.dart';
import 'package:smart_courier_assistant/presentation/page/profile/profile_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            const GoogleMapSection(),
            Positioned(
              top: 25,
              left: 15,
              child: ActionFloatingButton(
                icon: Iconsax.menu_1_copy,
                foregroundColor: Colors.black,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const ProfilePage(),
                    ),
                  );
                },
              ),
            ),
            Positioned(
              bottom: 250,
              right: 15,
              child: ActionFloatingButton(
                icon: Iconsax.scan,
                foregroundColor: Colors.blue,
                heroTag: 'ScanDocument',
                onPressed: () {},
              ),
            ),
            Positioned(
              bottom: 175,
              right: 15,
              child: ActionFloatingButton(
                icon: Iconsax.gps,
                foregroundColor: Colors.blue,
                heroTag: 'GetUserLocation',
                onPressed: () {},
              ),
            ),
            const OrdersDraggableSheet(),
          ],
        ),
      ),
    );
  }
}

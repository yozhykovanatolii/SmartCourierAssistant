import 'package:flutter/material.dart';
import 'package:smart_courier_assistant/presentation/page/home/widget/get_user_location_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              bottom: 175,
              right: 15,
              child: GetUserLocationButton(),
            ),
          ],
        ),
      ),
    );
  }
}

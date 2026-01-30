import 'package:flutter/material.dart';
import 'package:smart_courier_assistant/presentation/page/routes_history/widget/error_routes_section.dart';

class RoutesHistoryPage extends StatelessWidget {
  const RoutesHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Routes History🗺️',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: const ErrorRoutesSection(
        errorMessage: 'Routes are not found',
      ),
    );
  }
}

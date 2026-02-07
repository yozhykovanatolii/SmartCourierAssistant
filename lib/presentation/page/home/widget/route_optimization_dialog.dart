import 'package:flutter/material.dart';

class RouteOptimizationDialog extends StatelessWidget {
  const RouteOptimizationDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return const AlertDialog(
      content: SizedBox(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Optimize route',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Route optimization in progress. Please wait a few minutes.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 30),
            _OptimizationProgressIndicator(),
          ],
        ),
      ),
    );
  }
}

class _OptimizationProgressIndicator extends StatelessWidget {
  const _OptimizationProgressIndicator();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: LinearProgressIndicator(
        color: Colors.blue,
        backgroundColor: Colors.grey[400],
        minHeight: 7,
      ),
    );
  }
}

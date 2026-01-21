import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:smart_courier_assistant/data/model/order_model.dart';

class RouteOptimizeClient {
  static const _apiKey =
      'eyJvcmciOiI1YjNjZTM1OTc4NTExMTAwMDFjZjYyNDgiLCJpZCI6IjlhZjFhY2E3MjYwZjQ5ZDZhY2ZmMGFjY2RiOGU5MjkxIiwiaCI6Im11cm11cjY0In0=';

  Future<List<Map<String, dynamic>>> optimizeRoute(
    List<OrderModel> orders,
  ) async {
    final jobs = _ordersToJobs(orders);
    final startCoordinates = [35.1215, 47.8357];
    final response = await http.post(
      Uri.parse('https://api.openrouteservice.org/optimization'),
      headers: {
        'Authorization': _apiKey,
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "jobs": jobs,
        "vehicles": [
          {
            "id": 1,
            "start": startCoordinates,
            "profile": "driving-car",
          },
        ],
      }),
    );
    final data = jsonDecode(response.body);
    final steps = data['routes'][0]['steps'] as List<dynamic>;
    return steps.cast<Map<String, dynamic>>();
  }

  List<Map<String, dynamic>> _ordersToJobs(List<OrderModel> orders) {
    return orders
        .map(
          (order) => {
            'id': order.id.hashCode,
            'location': [order.longitude, order.latitude],
          },
        )
        .toList();
  }
}

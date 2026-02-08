import 'dart:convert';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:smart_courier_assistant/data/model/firestore/order_model.dart';
import 'package:http/http.dart' as http;

class RouteDirectionClient {
  static const _apiKey =
      'eyJvcmciOiI1YjNjZTM1OTc4NTExMTAwMDFjZjYyNDgiLCJpZCI6IjlhZjFhY2E3MjYwZjQ5ZDZhY2ZmMGFjY2RiOGU5MjkxIiwiaCI6Im11cm11cjY0In0=';

  Future<List<LatLng>> getRoutePolyline(
    List<OrderModel> orders,
    double latitude,
    double longitude,
  ) async {
    final coordinates = buildDirectionsCoordinates(
      orders,
      latitude,
      longitude,
    );
    final response = await http.post(
      Uri.parse(
        'https://api.openrouteservice.org/v2/directions/driving-car/geojson',
      ),
      headers: {
        'Authorization': _apiKey,
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'coordinates': coordinates,
      }),
    );
    final data = jsonDecode(response.body);
    final geometry =
        data['features'][0]['geometry']['coordinates'] as List<dynamic>;
    return geometry
        .map(
          (point) => LatLng(
            point[1] as double,
            point[0] as double,
          ),
        )
        .toList();
  }

  List<List<double>> buildDirectionsCoordinates(
    List<OrderModel> optimizedOrders,
    double startLat,
    double startLng,
  ) {
    final coordinates = <List<double>>[];
    coordinates.add([startLng, startLat]);
    for (final order in optimizedOrders) {
      coordinates.add([order.longitude, order.latitude]);
    }
    return coordinates;
  }
}

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:smart_courier_assistant/data/datasource/remote/api/route_direction_client.dart';
import 'package:smart_courier_assistant/data/datasource/remote/firebase/firebase_auth/user_auth.dart';
import 'package:smart_courier_assistant/data/datasource/remote/firebase/firestore/route_firestore.dart';
import 'package:smart_courier_assistant/data/model/order_model.dart';
import 'package:smart_courier_assistant/data/model/route_model.dart';

class RouteRepository {
  final RouteFirestore _routeFirestore = RouteFirestore();
  final RouteDirectionClient _directionClient = RouteDirectionClient();
  final UserAuth _userAuth = UserAuth();

  Future<String> createRoute() async {
    RouteModel routeModel = RouteModel.initial();
    final courierId = _userAuth.userId;
    final routeId = await _routeFirestore.getTodayRouteId(courierId);
    if (routeId == null) {
      routeModel = routeModel.copyWith(courierId: courierId);
      await _routeFirestore.createRoute(routeModel);
      return routeModel.routeId;
    }
    return routeId;
  }

  Future<List<LatLng>> buildRoutePolyline(
    List<OrderModel> orders,
    double startLat,
    double startLng,
  ) async {
    return await _directionClient.getRoutePolyline(
      orders,
      startLat,
      startLng,
    );
  }

  Future<List<RouteModel>> getAllCourierRoutes() async {
    final courierId = _userAuth.userId;
    return await _routeFirestore.getAllCourierRoutes(courierId);
  }
}

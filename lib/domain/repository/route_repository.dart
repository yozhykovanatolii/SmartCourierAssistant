import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:smart_courier_assistant/domain/entity/order_entity.dart';
import 'package:smart_courier_assistant/domain/entity/route_entity.dart';

abstract interface class RouteRepository {
  Future<String> createRoute();
  Future<List<LatLng>> buildRoutePolyline(
    List<OrderEntity> orders,
    double startLat,
    double startLng,
  );
  Future<List<RouteEntity>> getAllCourierRoutes();
  Future<String> getCurrentRouteRecommendation();
  Future<String> getRouteRecommendationByAI(
    List<OrderEntity> ordersEntity,
  );
}

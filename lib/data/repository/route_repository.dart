import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:smart_courier_assistant/data/datasource/remote/api/recommendation_gpt_client.dart';
import 'package:smart_courier_assistant/data/datasource/remote/api/route_direction_client.dart';
import 'package:smart_courier_assistant/data/datasource/remote/firebase/firebase_auth/user_auth.dart';
import 'package:smart_courier_assistant/data/datasource/remote/firebase/firestore/order_firestore.dart';
import 'package:smart_courier_assistant/data/datasource/remote/firebase/firestore/route_firestore.dart';
import 'package:smart_courier_assistant/data/mapper/order_mapper.dart';
import 'package:smart_courier_assistant/data/mapper/route_mapper.dart';
import 'package:smart_courier_assistant/data/model/risky_order_model.dart';
import 'package:smart_courier_assistant/data/model/route_analysis_model.dart';
import 'package:smart_courier_assistant/data/model/route_model.dart';
import 'package:smart_courier_assistant/domain/entity/order_entity.dart';
import 'package:smart_courier_assistant/domain/entity/route_entity.dart';

class RouteRepository {
  final RouteFirestore _routeFirestore = RouteFirestore();
  final RouteDirectionClient _directionClient = RouteDirectionClient();
  final RecommendationGptClient _gptClient = RecommendationGptClient();
  final OrderFirestore _orderFirestore = OrderFirestore();
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
    List<OrderEntity> orders,
    double startLat,
    double startLng,
  ) async {
    final ordersModel = orders
        .map((order) => OrderMapper.fromEntity(order))
        .toList();
    return await _directionClient.getRoutePolyline(
      ordersModel,
      startLat,
      startLng,
    );
  }

  Future<List<RouteEntity>> getAllCourierRoutes() async {
    final courierId = _userAuth.userId;
    final routesModel = await _routeFirestore.getAllCourierRoutes(courierId);
    final futures = routesModel.map((routeModel) async {
      final ordersModel = await _orderFirestore.getAllUserOrders(
        routeModel.routeId,
      );
      return RouteMapper.toEntity(routeModel, ordersModel);
    }).toList();
    return await Future.wait(futures);
  }

  Future<String> getCurrentRouteRecommendation() async {
    final courierId = _userAuth.userId;
    final routeModel = await _routeFirestore.getTodayRoute(courierId);
    return routeModel.recommendation;
  }

  Future<String> getRouteRecommendationByAI(
    List<OrderEntity> ordersEntity,
  ) async {
    final riskyOrders = ordersEntity
        .map(OrderMapper.fromEntity)
        .where(
          (orderModel) =>
              orderModel.deliveryRisk == 'Delayed' ||
              orderModel.deliveryRisk == 'At risk',
        )
        .map(RiskyOrderModel.fromOrderModel)
        .toList();
    final currentTimeDateTime = DateTime.now();
    final analysis = RouteAnalysisModel(
      totalOrders: ordersEntity.length,
      riskyOrders: riskyOrders,
      currentTime:
          '${currentTimeDateTime.hour}:${currentTimeDateTime.minute.toString().padLeft(2, '0')}',
    );
    final courierId = _userAuth.userId;
    final routeId = await _routeFirestore.getTodayRouteId(courierId);
    final recommendation = await _gptClient.getRouteRecommendation(analysis);
    if (routeId != null && recommendation != null) {
      await _routeFirestore.saveRouteRecommendation(recommendation, routeId);
    }
    return recommendation ?? '';
  }
}

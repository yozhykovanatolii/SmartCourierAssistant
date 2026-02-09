// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:smart_courier_assistant/data/datasource/remote/api/recommendation_gpt_client.dart';
import 'package:smart_courier_assistant/data/datasource/remote/api/route_direction_client.dart';
import 'package:smart_courier_assistant/data/datasource/remote/firebase/firebase_auth/user_auth.dart';
import 'package:smart_courier_assistant/data/datasource/remote/firebase/firestore/order_firestore.dart';
import 'package:smart_courier_assistant/data/datasource/remote/firebase/firestore/route_firestore.dart';
import 'package:smart_courier_assistant/data/mapper/order_mapper.dart';
import 'package:smart_courier_assistant/data/mapper/route_mapper.dart';
import 'package:smart_courier_assistant/data/model/api/risky_order_model.dart';
import 'package:smart_courier_assistant/data/model/api/route_analysis_model.dart';
import 'package:smart_courier_assistant/data/model/firestore/route_model.dart';
import 'package:smart_courier_assistant/domain/entity/order_entity.dart';
import 'package:smart_courier_assistant/domain/entity/route_entity.dart';
import 'package:smart_courier_assistant/domain/repository/route_repository.dart';

class RouteRepositoryImpl implements RouteRepository {
  final RouteFirestore routeFirestore;
  final RouteDirectionClient directionClient;
  final RecommendationGptClient gptClient;
  final OrderFirestore orderFirestore;
  final UserAuth userAuth;

  RouteRepositoryImpl({
    required this.routeFirestore,
    required this.directionClient,
    required this.gptClient,
    required this.orderFirestore,
    required this.userAuth,
  });

  @override
  Future<String> createRoute() async {
    RouteModel routeModel = RouteModel.initial();
    final courierId = userAuth.userId;
    final routeId = await routeFirestore.getTodayRouteId(courierId);
    if (routeId == null) {
      routeModel = routeModel.copyWith(courierId: courierId);
      await routeFirestore.createRoute(routeModel);
      return routeModel.routeId;
    }
    return routeId;
  }

  @override
  Future<List<LatLng>> buildRoutePolyline(
    List<OrderEntity> orders,
    double startLat,
    double startLng,
  ) async {
    final ordersModel = orders
        .map((order) => OrderMapper.fromEntity(order))
        .toList();
    return await directionClient.getRoutePolyline(
      ordersModel,
      startLat,
      startLng,
    );
  }

  @override
  Future<List<RouteEntity>> getAllCourierRoutes() async {
    final courierId = userAuth.userId;
    final routesModel = await routeFirestore.getAllCourierRoutes(courierId);
    final futures = routesModel.map((routeModel) async {
      final ordersModel = await orderFirestore.getAllUserOrders(
        routeModel.routeId,
      );
      return RouteMapper.toEntity(routeModel, ordersModel);
    }).toList();
    return await Future.wait(futures);
  }

  @override
  Future<String> getCurrentRouteRecommendation() async {
    final courierId = userAuth.userId;
    final routeModel = await routeFirestore.getTodayRoute(courierId);
    return routeModel.recommendation;
  }

  @override
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
    final courierId = userAuth.userId;
    final routeId = await routeFirestore.getTodayRouteId(courierId);
    final recommendation = await gptClient.getRouteRecommendation(analysis);
    if (routeId != null && recommendation != null) {
      await routeFirestore.saveRouteRecommendation(recommendation, routeId);
    }
    return recommendation ?? '';
  }
}

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:smart_courier_assistant/domain/entity/order_entity.dart';

enum OrderStatus { initial, loading, success, failure }

class OrderState {
  final List<OrderEntity> orders;
  final List<LatLng> routePoints;
  final String routeRecommendation;
  final String errorMessage;
  final String geolocationError;
  final String actionError;
  final double latitude;
  final double longitude;
  final OrderStatus status;

  OrderState({
    required this.orders,
    required this.routePoints,
    required this.routeRecommendation,
    required this.errorMessage,
    required this.geolocationError,
    required this.actionError,
    required this.latitude,
    required this.longitude,
    required this.status,
  });

  factory OrderState.initial() {
    return OrderState(
      orders: [],
      routePoints: [],
      routeRecommendation: '',
      errorMessage: '',
      geolocationError: '',
      actionError: '',
      latitude: 50.4501,
      longitude: 30.5234,
      status: OrderStatus.initial,
    );
  }

  OrderState copyWith({
    List<OrderEntity>? orders,
    List<LatLng>? routePoints,
    String? routeRecommendation,
    String? errorMessage,
    String? geolocationError,
    String? actionError,
    double? latitude,
    double? longitude,
    OrderStatus? status,
  }) {
    return OrderState(
      orders: orders ?? this.orders,
      routePoints: routePoints ?? this.routePoints,
      routeRecommendation: routeRecommendation ?? this.routeRecommendation,
      errorMessage: errorMessage ?? this.errorMessage,
      geolocationError: geolocationError ?? this.geolocationError,
      actionError: actionError ?? this.actionError,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      status: status ?? this.status,
    );
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:smart_courier_assistant/core/exception/geolocation_exception.dart';
import 'package:smart_courier_assistant/core/exception/orders_not_found_exception.dart';
import 'package:smart_courier_assistant/core/exception/route_not_found_exception.dart';
import 'package:smart_courier_assistant/data/repository/geolocation_repository.dart';
import 'package:smart_courier_assistant/data/repository/order_repository.dart';
import 'package:smart_courier_assistant/data/repository/route_repository.dart';
import 'package:smart_courier_assistant/data/repository/user_repository.dart';
import 'package:smart_courier_assistant/presentation/bloc/order/order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  final OrderRepository _orderRepository = OrderRepository();
  final GeolocationRepository _geolocationRepository = GeolocationRepository();
  final UserRepository _userRepository = UserRepository();
  final RouteRepository _routeRepository = RouteRepository();

  OrderCubit() : super(OrderState.initial());

  Future<void> fetchOrders() async {
    emit(state.copyWith(status: OrderStatus.loading));
    try {
      final activeOrders = await _orderRepository.getAllCourierActiveOrders();
      final routeRecommendation = await _routeRepository
          .getCurrentRouteRecommendation();
      emit(
        state.copyWith(
          status: OrderStatus.success,
          orders: activeOrders,
          routeRecommendation: routeRecommendation,
        ),
      );
    } on RouteNotFoundException catch (exception) {
      emit(
        state.copyWith(
          status: OrderStatus.failure,
          errorMessage: exception.errorMessage,
        ),
      );
    } on OrdersNotFoundException catch (exception) {
      emit(
        state.copyWith(
          status: OrderStatus.failure,
          errorMessage: exception.errorMessage,
        ),
      );
    }
  }

  Future<void> fetchOrdersByRouteId(String routeId) async {
    emit(state.copyWith(status: OrderStatus.loading));
    try {
      final orders = await _orderRepository.getAllCourierOrdersByRouteId(
        routeId,
      );
      emit(state.copyWith(status: OrderStatus.success, orders: orders));
    } on RouteNotFoundException catch (exception) {
      emit(
        state.copyWith(
          status: OrderStatus.failure,
          errorMessage: exception.errorMessage,
        ),
      );
    } on OrdersNotFoundException catch (exception) {
      emit(
        state.copyWith(
          status: OrderStatus.failure,
          errorMessage: exception.errorMessage,
        ),
      );
    }
  }

  Future<void> getUserLocation() async {
    try {
      final location = await _geolocationRepository.getCurrentLocation();
      print('${location.latitude}, ${location.longitude}');
      emit(
        state.copyWith(
          latitude: location.latitude,
          longitude: location.longitude,
        ),
      );
    } on PermissionDeniedException catch (exception) {
      emit(
        state.copyWith(geolocationError: exception.message),
      );
    } on GeolocationException catch (exception) {
      emit(
        state.copyWith(geolocationError: exception.errorMessage),
      );
    }
  }

  Future<void> optimizeOrdersRoute() async {
    final orders = state.orders;
    final latitude = state.latitude;
    final longitude = state.longitude;
    if (orders.isNotEmpty) {
      final updatedOrders = await _orderRepository.optimizeOrdersRoute(
        orders,
        latitude,
        longitude,
      );
      final recommendation = await _routeRepository.getRouteRecommendationByAI(
        updatedOrders,
      );
      print('Recommendation: $recommendation');
      final routePoints = await _routeRepository.buildRoutePolyline(
        updatedOrders,
        latitude,
        longitude,
      );
      emit(
        state.copyWith(
          routePoints: routePoints,
          routeRecommendation: recommendation,
        ),
      );
    } else {
      return;
    }
  }

  Future<void> openCallDialer(String clientPhoneNumber) async {
    try {
      await _userRepository.callUserDialer(clientPhoneNumber);
    } catch (exception) {
      emit(
        state.copyWith(actionError: exception.toString()),
      );
    } finally {
      emit(
        state.copyWith(actionError: ''),
      );
    }
  }

  Future<void> openUserMessanger(String clientPhoneNumber) async {
    try {
      await _userRepository.messageUser(clientPhoneNumber);
    } catch (exception) {
      emit(
        state.copyWith(actionError: exception.toString()),
      );
    } finally {
      emit(
        state.copyWith(actionError: ''),
      );
    }
  }
}

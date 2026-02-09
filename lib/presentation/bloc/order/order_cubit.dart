// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

import 'package:smart_courier_assistant/core/exception/auth/user_not_found_exception.dart';
import 'package:smart_courier_assistant/core/exception/geolocation_exception.dart';
import 'package:smart_courier_assistant/core/exception/optimization_route_exception.dart';
import 'package:smart_courier_assistant/core/exception/orders_not_found_exception.dart';
import 'package:smart_courier_assistant/core/exception/route_not_found_exception.dart';
import 'package:smart_courier_assistant/domain/repository/geolocation_repository.dart';
import 'package:smart_courier_assistant/domain/repository/order_repository.dart';
import 'package:smart_courier_assistant/domain/repository/route_repository.dart';
import 'package:smart_courier_assistant/domain/repository/user_repository.dart';
import 'package:smart_courier_assistant/presentation/bloc/order/order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  final OrderRepository orderRepository;
  final GeolocationRepository geolocationRepository;
  final UserRepository userRepository;
  final RouteRepository routeRepository;

  OrderCubit(
    this.orderRepository,
    this.geolocationRepository,
    this.userRepository,
    this.routeRepository,
  ) : super(OrderState.initial());

  Future<void> fetchOrders() async {
    emit(state.copyWith(status: OrderStatus.loading));
    try {
      final activeOrders = await orderRepository.getAllCourierActiveOrders();
      final routeRecommendation = await routeRepository
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
      final orders = await orderRepository.getAllCourierOrdersByRouteId(
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
      final location = await geolocationRepository.getCurrentLocation();
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
    emit(
      state.copyWith(
        routeOptimizationStatus: RouteOptimizationStatus.loading,
      ),
    );
    try {
      final updatedOrders = await orderRepository.optimizeOrdersRoute(
        orders,
        latitude,
        longitude,
      );
      final recommendation = await routeRepository.getRouteRecommendationByAI(
        updatedOrders,
      );
      print('Recommendation: $recommendation');
      final routePoints = await routeRepository.buildRoutePolyline(
        updatedOrders,
        latitude,
        longitude,
      );
      emit(
        state.copyWith(
          orders: updatedOrders,
          routePoints: routePoints,
          routeRecommendation: recommendation,
          routeOptimizationStatus: RouteOptimizationStatus.success,
        ),
      );
    } on OptimizationRouteException catch (exception) {
      emit(
        state.copyWith(
          optimizationError: exception.errorMessage,
          routeOptimizationStatus: RouteOptimizationStatus.failure,
        ),
      );
    } on UserNotFoundException catch (exception) {
      emit(
        state.copyWith(
          optimizationError: exception.errorMessage,
          routeOptimizationStatus: RouteOptimizationStatus.failure,
        ),
      );
    } finally {
      emit(
        state.copyWith(
          optimizationError: '',
          routeOptimizationStatus: RouteOptimizationStatus.initial,
        ),
      );
    }
  }

  Future<void> openCallDialer(String clientPhoneNumber) async {
    try {
      await userRepository.callUserDialer(clientPhoneNumber);
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
      await userRepository.messageUser(clientPhoneNumber);
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

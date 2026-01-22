import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:smart_courier_assistant/core/exception/geolocation_exception.dart';
import 'package:smart_courier_assistant/core/exception/orders_not_found_exception.dart';
import 'package:smart_courier_assistant/data/repository/geolocation_repository.dart';
import 'package:smart_courier_assistant/data/repository/order_repository.dart';
import 'package:smart_courier_assistant/presentation/bloc/order/order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  final OrderRepository _orderRepository = OrderRepository();
  final GeolocationRepository _geolocationRepository = GeolocationRepository();

  OrderCubit() : super(OrderState.initial());

  Future<void> fetchOrders() async {
    emit(state.copyWith(status: OrderStatus.loading));
    try {
      final activeOrders = await _orderRepository.getAllCourierActiveOrders();
      emit(state.copyWith(status: OrderStatus.success, orders: activeOrders));
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
    if (orders.isNotEmpty) {
      await _orderRepository.optimizeOrdersRoute(
        orders,
        state.latitude,
        state.longitude,
      );
    } else {
      return;
    }
  }
}

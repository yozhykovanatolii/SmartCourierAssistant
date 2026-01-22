import 'package:smart_courier_assistant/data/model/order_model.dart';

enum OrderStatus { initial, loading, success, failure }

class OrderState {
  final List<OrderModel> orders;
  final String errorMessage;
  final double latitude;
  final double longitude;
  final OrderStatus status;

  OrderState({
    required this.orders,
    required this.errorMessage,
    required this.latitude,
    required this.longitude,
    required this.status,
  });

  factory OrderState.initial() {
    return OrderState(
      orders: [],
      errorMessage: '',
      latitude: 50.4501,
      longitude: 30.5234,
      status: OrderStatus.initial,
    );
  }

  OrderState copyWith({
    List<OrderModel>? orders,
    String? errorMessage,
    double? latitude,
    double? longitude,
    OrderStatus? status,
  }) {
    return OrderState(
      orders: orders ?? this.orders,
      errorMessage: errorMessage ?? this.errorMessage,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      status: status ?? this.status,
    );
  }
}

import 'package:smart_courier_assistant/domain/entity/order_entity.dart';

class RouteEntity {
  final String routeId;
  final int ordersCount;
  final int delayedOrdersCount;
  final DateTime createAt;

  RouteEntity({
    required this.routeId,
    required this.ordersCount,
    required this.delayedOrdersCount,
    required this.createAt,
  });

  factory RouteEntity.initial() {
    return RouteEntity(
      routeId: '',
      createAt: DateTime.now(),
      ordersCount: 0,
      delayedOrdersCount: 0,
    );
  }

  RouteEntity copyWith({
    String? routeId,
    int? ordersCount,
    int? delayedOrdersCount,
    List<OrderEntity>? orders,
    DateTime? createAt,
  }) {
    return RouteEntity(
      routeId: routeId ?? this.routeId,
      ordersCount: ordersCount ?? this.ordersCount,
      delayedOrdersCount: delayedOrdersCount ?? this.delayedOrdersCount,
      createAt: createAt ?? this.createAt,
    );
  }
}

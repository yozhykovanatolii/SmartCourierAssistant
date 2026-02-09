import 'package:smart_courier_assistant/domain/entity/order_entity.dart';

abstract interface class OrderRepository {
  Future<void> saveOrder(
    String clientFullName,
    String clientPhoneNumber,
    String address,
    String category,
    String routeId,
    DateTime deliveryBy, {
    OrderEntity? currentOrder,
  });
  Future<List<OrderEntity>> getAllCourierActiveOrders();
  Future<List<OrderEntity>> getAllCourierOrdersByRouteId(String routeId);
  Future<List<OrderEntity>> optimizeOrdersRoute(
    List<OrderEntity> orders,
    double latitude,
    double longitude,
  );
  Future<void> deleteOrder(String orderId);
  Future<String> getOrderPhoto();
}

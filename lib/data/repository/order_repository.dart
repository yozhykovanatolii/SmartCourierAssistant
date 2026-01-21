import 'package:smart_courier_assistant/data/datasource/remote/api/route_optimize_client.dart';
import 'package:smart_courier_assistant/data/datasource/remote/firebase/firebase_auth/user_auth.dart';
import 'package:smart_courier_assistant/data/datasource/remote/firebase/firestore/order_firestore.dart';
import 'package:smart_courier_assistant/data/datasource/remote/firebase/firestore/route_firestore.dart';
import 'package:smart_courier_assistant/data/model/order_model.dart';
import 'package:smart_courier_assistant/data/service/geolocation_service.dart';

class OrderRepository {
  final UserAuth _userAuth = UserAuth();
  final OrderFirestore _orderFirestore = OrderFirestore();
  final RouteFirestore _routeFirestore = RouteFirestore();
  final RouteOptimizeClient _optimizeClient = RouteOptimizeClient();
  String _routeId = '';

  Future<void> saveOrder(
    String clientFullName,
    String clientPhoneNumber,
    String address,
    String category,
    String routeId, {
    OrderModel? currentOrder,
  }) async {
    OrderModel orderModel = OrderModel.initial();
    final location = await GeolocationService.getLocationByAddress(address);
    orderModel = orderModel.copyWith(
      id: currentOrder?.id,
      clientFullName: clientFullName,
      clientPhoneNumber: clientPhoneNumber,
      address: address,
      latitude: location.latitude,
      longitude: location.longitude,
      category: category,
    );
    await _orderFirestore.saveOrder(orderModel, routeId);
  }

  Future<List<OrderModel>> getAllCourierActiveOrders() async {
    final courierId = _userAuth.userId;
    final routeModel = await _routeFirestore.getTodayRoute(courierId);
    _routeId = routeModel.routeId;
    return await _orderFirestore.getAllUserOrders(routeModel.routeId);
  }

  Future<List<OrderModel>> optimizeOrdersRoute(
    List<OrderModel> orders,
  ) async {
    final steps = await _optimizeClient.optimizeRoute(orders);
    final startTime = DateTime.now();
    Duration cumulativeDuration = Duration.zero;
    final unloadingTimePerJob = 300;
    final jobIdToOrderId = {for (var o in orders) o.id.hashCode: o.id};
    List<OrderModel> updatedOrders = [];
    for (int i = 0; i < steps.length; i++) {
      final step = steps[i];
      if (step['type'] != 'job') continue;
      final orderId = jobIdToOrderId[step['job']];
      final order = orders.firstWhere((o) => o.id == orderId);
      cumulativeDuration += Duration(
        seconds: step['duration'] + unloadingTimePerJob,
      );
      final eta = startTime.add(cumulativeDuration);
      final updatedOrder = order.copyWith(
        latitude: step['location'][1],
        longitude: step['location'][0],
        status: order.status,
        plannedEta: eta,
        orderIndex: updatedOrders.length,
      );
      updatedOrders.add(updatedOrder);
    }
    final newOrders = await _orderFirestore.saveOrders(updatedOrders, _routeId);
    print('Маршрут $_routeId успешно оптимизирован и сохранён.');
    return newOrders;
  }

  Future<void> deleteOrder(String orderId) async {
    final courierId = _userAuth.userId;
    final routeId = await _routeFirestore.getTodayRouteId(courierId);
    if (routeId == null) return;
    await _orderFirestore.deleteOrder(orderId, routeId);
  }
}

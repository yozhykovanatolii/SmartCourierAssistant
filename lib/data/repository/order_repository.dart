import 'package:smart_courier_assistant/data/datasource/remote/firebase_auth/user_auth.dart';
import 'package:smart_courier_assistant/data/datasource/remote/firestore/order_firestore.dart';
import 'package:smart_courier_assistant/data/datasource/remote/firestore/route_firestore.dart';
import 'package:smart_courier_assistant/data/model/order_model.dart';
import 'package:smart_courier_assistant/data/service/geolocation_service.dart';

class OrderRepository {
  final UserAuth _userAuth = UserAuth();
  final OrderFirestore _orderFirestore = OrderFirestore();
  final RouteFirestore _routeFirestore = RouteFirestore();

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
    return await _orderFirestore.getAllUserOrders(routeModel.routeId);
  }

  Future<void> deleteOrder(String orderId) async {
    final courierId = _userAuth.userId;
    final routeId = await _routeFirestore.getTodayRouteId(courierId);
    if (routeId == null) return;
    await _orderFirestore.deleteOrder(orderId, routeId);
  }
}

import 'package:smart_courier_assistant/core/util/calculation_eta_util.dart';
import 'package:smart_courier_assistant/data/datasource/remote/api/route_optimize_client.dart';
import 'package:smart_courier_assistant/data/datasource/remote/firebase/firebase_auth/user_auth.dart';
import 'package:smart_courier_assistant/data/datasource/remote/firebase/firestore/order_firestore.dart';
import 'package:smart_courier_assistant/data/datasource/remote/firebase/firestore/route_firestore.dart';
import 'package:smart_courier_assistant/data/datasource/remote/storage/supabase_storage.dart';
import 'package:smart_courier_assistant/data/model/order_model.dart';
import 'package:smart_courier_assistant/data/service/camera_picker_service.dart';
import 'package:smart_courier_assistant/data/service/geolocation_service.dart';

class OrderRepository {
  final UserAuth _userAuth = UserAuth();
  final OrderFirestore _orderFirestore = OrderFirestore();
  final RouteFirestore _routeFirestore = RouteFirestore();
  final RouteOptimizeClient _optimizeClient = RouteOptimizeClient();
  final SupabaseStorage _supabaseStorage = SupabaseStorage();
  String _routeId = '';

  Future<void> saveOrder(
    String clientFullName,
    String clientPhoneNumber,
    String address,
    String category,
    String routeId,
    DateTime deliveryBy, {
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
      deliveryBy: deliveryBy,
      plannedEta: currentOrder?.plannedEta,
      recommendation: currentOrder?.recommendation ?? orderModel.recommendation,
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

  Future<List<OrderModel>> getAllCourierOrdersByRouteId(String routeId) async {
    return await _orderFirestore.getAllUserOrders(routeId);
  }

  Future<List<OrderModel>> optimizeOrdersRoute(
    List<OrderModel> orders,
    double latitude,
    double longitude,
  ) async {
    final steps = await _optimizeClient.optimizeRoute(
      orders,
      latitude,
      longitude,
    );
    final updatedOrders = CalculationEtaUtil.calculateEtaForOrders(
      steps,
      orders,
    );
    await _orderFirestore.saveOrders(updatedOrders, _routeId);
    print('Маршрут $_routeId успешно оптимизирован и сохранён.');
    return updatedOrders;
  }

  Future<void> deleteOrder(String orderId) async {
    final courierId = _userAuth.userId;
    final routeId = await _routeFirestore.getTodayRouteId(courierId);
    if (routeId == null) return;
    await _orderFirestore.deleteOrder(orderId, routeId);
  }

  Future<String> getOrderPhoto() async {
    final imageFile = await CameraPickerService.pickImageFileFromGallery();
    final imageUrl = await _supabaseStorage.saveImage(imageFile, 'orders');
    return imageUrl;
  }
}

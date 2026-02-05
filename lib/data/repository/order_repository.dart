import 'package:smart_courier_assistant/core/util/calculation_eta_util.dart';
import 'package:smart_courier_assistant/data/datasource/remote/api/route_optimize_client.dart';
import 'package:smart_courier_assistant/data/datasource/remote/firebase/firebase_auth/user_auth.dart';
import 'package:smart_courier_assistant/data/datasource/remote/firebase/firestore/order_firestore.dart';
import 'package:smart_courier_assistant/data/datasource/remote/firebase/firestore/route_firestore.dart';
import 'package:smart_courier_assistant/data/datasource/remote/storage/supabase_storage.dart';
import 'package:smart_courier_assistant/data/mapper/order_mapper.dart';
import 'package:smart_courier_assistant/data/mapper/proof_delivery_mapper.dart';
import 'package:smart_courier_assistant/data/model/order_model.dart';
import 'package:smart_courier_assistant/data/service/camera_picker_service.dart';
import 'package:smart_courier_assistant/data/service/geolocation_service.dart';
import 'package:smart_courier_assistant/domain/entity/order_entity.dart';

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
    OrderEntity? currentOrder,
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
      proofDelivery: ProofDeliveryMapper.fromEntity(
        currentOrder?.proofDeliveryEntity,
      ),
      category: category,
    );
    await _orderFirestore.saveOrder(orderModel, routeId);
  }

  Future<List<OrderEntity>> getAllCourierActiveOrders() async {
    final courierId = _userAuth.userId;
    final routeModel = await _routeFirestore.getTodayRoute(courierId);
    _routeId = routeModel.routeId;
    print('Success route: ${routeModel.routeId}');
    final ordersModel = await _orderFirestore.getAllUserOrders(
      routeModel.routeId,
    );
    print('Success orders: ${ordersModel.length}');
    return ordersModel
        .map((orderModel) => OrderMapper.toEntity(orderModel))
        .toList();
  }

  Future<List<OrderEntity>> getAllCourierOrdersByRouteId(String routeId) async {
    final ordersModel = await _orderFirestore.getAllUserOrders(routeId);
    return ordersModel
        .map((orderModel) => OrderMapper.toEntity(orderModel))
        .toList();
  }

  Future<List<OrderEntity>> optimizeOrdersRoute(
    List<OrderEntity> orders,
    double latitude,
    double longitude,
  ) async {
    final ordersModel = orders
        .map((order) => OrderMapper.fromEntity(order))
        .toList();
    final steps = await _optimizeClient.optimizeRoute(
      ordersModel,
      latitude,
      longitude,
    );
    final updatedOrders = CalculationEtaUtil.calculateEtaForOrders(
      steps,
      ordersModel,
    );
    await _orderFirestore.saveOrders(updatedOrders, _routeId);
    print('Маршрут $_routeId успешно оптимизирован и сохранён.');
    return updatedOrders
        .map((updatedOrder) => OrderMapper.toEntity(updatedOrder))
        .toList();
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

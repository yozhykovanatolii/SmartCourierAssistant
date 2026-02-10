// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:smart_courier_assistant/core/util/calculation_eta_util.dart';
import 'package:smart_courier_assistant/data/datasource/remote/api/route_optimize_client.dart';
import 'package:smart_courier_assistant/data/datasource/remote/firebase/firebase_auth/user_auth.dart';
import 'package:smart_courier_assistant/data/datasource/remote/firebase/firestore/order_firestore.dart';
import 'package:smart_courier_assistant/data/datasource/remote/firebase/firestore/route_firestore.dart';
import 'package:smart_courier_assistant/data/datasource/remote/storage/supabase_storage.dart';
import 'package:smart_courier_assistant/data/mapper/order_mapper.dart';
import 'package:smart_courier_assistant/data/mapper/proof_delivery_mapper.dart';
import 'package:smart_courier_assistant/data/model/firestore/order_model.dart';
import 'package:smart_courier_assistant/data/service/camera_picker_service.dart';
import 'package:smart_courier_assistant/data/service/geolocation_service.dart';
import 'package:smart_courier_assistant/domain/entity/order_entity.dart';
import 'package:smart_courier_assistant/domain/repository/order_repository.dart';

class OrderRepositoryImpl implements OrderRepository {
  final UserAuth userAuth;
  final OrderFirestore orderFirestore;
  final RouteFirestore routeFirestore;
  final RouteOptimizeClient optimizeClient;
  final SupabaseStorage supabaseStorage;
  String _routeId = '';

  OrderRepositoryImpl({
    required this.userAuth,
    required this.orderFirestore,
    required this.routeFirestore,
    required this.optimizeClient,
    required this.supabaseStorage,
  });

  @override
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
    await orderFirestore.saveOrder(orderModel, routeId);
  }

  @override
  Future<List<OrderEntity>> getAllCourierActiveOrders() async {
    final courierId = userAuth.userId;
    final routeModel = await routeFirestore.getTodayRoute(courierId);
    _routeId = routeModel.routeId;
    print('Success route: ${routeModel.routeId}');
    final ordersModel = await orderFirestore.getAllUserOrders(
      routeModel.routeId,
    );
    return ordersModel
        .map((orderModel) => OrderMapper.toEntity(orderModel))
        .toList();
  }

  @override
  Future<List<OrderEntity>> getAllCourierOrdersByRouteId(String routeId) async {
    final ordersModel = await orderFirestore.getAllUserOrders(routeId);
    return ordersModel
        .map((orderModel) => OrderMapper.toEntity(orderModel))
        .toList();
  }

  @override
  Future<List<OrderEntity>> optimizeOrdersRoute(
    List<OrderEntity> orders,
    double latitude,
    double longitude,
  ) async {
    final ordersModel = orders
        .map((order) => OrderMapper.fromEntity(order))
        .toList();
    final steps = await optimizeClient.optimizeRoute(
      ordersModel,
      latitude,
      longitude,
    );
    final updatedOrders = CalculationEtaUtil.calculateEtaForOrders(
      steps,
      ordersModel,
    );
    await orderFirestore.saveOrders(updatedOrders, _routeId);
    print('Маршрут $_routeId успешно оптимизирован и сохранён.');
    return updatedOrders
        .map((updatedOrder) => OrderMapper.toEntity(updatedOrder))
        .toList();
  }

  @override
  Future<void> deleteOrder(String orderId) async {
    final courierId = userAuth.userId;
    final routeId = await routeFirestore.getTodayRouteId(courierId);
    if (routeId == null) return;
    await orderFirestore.deleteOrder(orderId, routeId);
  }

  @override
  Future<String> getOrderPhoto() async {
    final imageFile = await CameraPickerService.pickImageFileFromGallery();
    final imageUrl = await supabaseStorage.saveImage(imageFile, 'orders');
    return imageUrl;
  }
}

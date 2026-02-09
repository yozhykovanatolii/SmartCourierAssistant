import 'package:smart_courier_assistant/data/datasource/remote/firebase/firebase_auth/user_auth.dart';
import 'package:smart_courier_assistant/data/datasource/remote/firebase/firestore/order_firestore.dart';
import 'package:smart_courier_assistant/data/datasource/remote/firebase/firestore/route_firestore.dart';
import 'package:smart_courier_assistant/data/model/firestore/proof_delivery_model.dart';
import 'package:smart_courier_assistant/domain/repository/delivery_repository.dart';

class DeliveryRepositoryImpl implements DeliveryRepository {
  final UserAuth userAuth;
  final RouteFirestore routeFirestore;
  final OrderFirestore orderFirestore;

  DeliveryRepositoryImpl(
    this.userAuth,
    this.routeFirestore,
    this.orderFirestore,
  );

  @override
  Future<void> createProofOfDelivery(
    String orderId,
    String courierComment,
    List<String> orderPhotos,
  ) async {
    final courierId = userAuth.userId;
    final routeModel = await routeFirestore.getTodayRoute(courierId);
    final proofDelivery = ProofDeliveryModel(
      courierComment: courierComment,
      orderPhotos: orderPhotos,
      confirmedAt: DateTime.now(),
    );
    await orderFirestore.updateOrderProofDelivery(
      proofDelivery,
      routeModel.routeId,
      orderId,
    );
  }
}

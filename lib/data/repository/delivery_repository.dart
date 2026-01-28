import 'package:smart_courier_assistant/data/datasource/remote/firebase/firebase_auth/user_auth.dart';
import 'package:smart_courier_assistant/data/datasource/remote/firebase/firestore/order_firestore.dart';
import 'package:smart_courier_assistant/data/datasource/remote/firebase/firestore/route_firestore.dart';
import 'package:smart_courier_assistant/data/model/proof_delivery_model.dart';

class DeliveryRepository {
  final UserAuth _userAuth = UserAuth();
  final RouteFirestore _routeFirestore = RouteFirestore();
  final OrderFirestore _orderFirestore = OrderFirestore();

  Future<void> createProofOfDelivery(
    String orderId,
    String courierComment,
    List<String> orderPhotos,
  ) async {
    final courierId = _userAuth.userId;
    final routeModel = await _routeFirestore.getTodayRoute(courierId);
    final proofDelivery = ProofDeliveryModel(
      courierComment: courierComment,
      orderPhotos: orderPhotos,
      confirmedAt: DateTime.now(),
    );
    await _orderFirestore.updateOrderProofDelivery(
      proofDelivery,
      routeModel.routeId,
      orderId,
    );
  }
}

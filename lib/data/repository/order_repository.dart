import 'package:smart_courier_assistant/data/datasource/remote/firebase_auth/user_auth.dart';
import 'package:smart_courier_assistant/data/datasource/remote/firestore/order_firestore.dart';
import 'package:smart_courier_assistant/data/model/order_model.dart';

class OrderRepository {
  final UserAuth _userAuth = UserAuth();
  final OrderFirestore _orderFirestore = OrderFirestore();

  Future<void> saveOrder(
    String clientFullName,
    String clientPhoneNumber,
    String address,
    String category,
  ) async {
    final userID = _userAuth.userId;
    OrderModel orderModel = OrderModel.initial();
    orderModel = orderModel.copyWith(
      courierId: userID,
      clientFullName: clientFullName,
      clientPhoneNumber: clientPhoneNumber,
      address: address,
      category: category,
    );
    await _orderFirestore.saveOrder(orderModel);
  }
}

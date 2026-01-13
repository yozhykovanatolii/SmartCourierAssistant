import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smart_courier_assistant/data/model/order_model.dart';

class OrderFirestore {
  final _firestore = FirebaseFirestore.instance;

  Future<void> saveOrder(OrderModel userModel) async {
    final docReference = _getUserDocumentReference(userModel.id);
    await docReference.set(userModel);
  }

  Future<void> deleteOrder(String orderId) async {
    await _firestore.collection('orders').doc(orderId).delete();
  }

  DocumentReference<OrderModel> _getUserDocumentReference(String id) {
    return _firestore
        .collection('orders')
        .doc(id)
        .withConverter(
          fromFirestore: OrderModel.fromFirestore,
          toFirestore: (OrderModel orderModel, options) =>
              orderModel.toFirestore(),
        );
  }
}

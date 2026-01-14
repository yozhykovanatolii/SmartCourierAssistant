import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smart_courier_assistant/core/exception/orders_not_found_exception.dart';
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

  Future<List<OrderModel>> getAllUserOrders(String userId) async {
    final collectionReference = _getListingCollectionReference();
    final query = collectionReference.where('courierId', isEqualTo: userId);
    final querySnapshot = await query.get();
    if (querySnapshot.docs.isEmpty) {
      throw OrdersNotFoundException('Orders weren\'t found');
    }
    return querySnapshot.docs.map((document) => document.data()).toList();
  }

  CollectionReference<OrderModel> _getListingCollectionReference() {
    return _firestore
        .collection('orders')
        .withConverter(
          fromFirestore: OrderModel.fromFirestore,
          toFirestore: (OrderModel orderModel, options) =>
              orderModel.toFirestore(),
        );
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

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smart_courier_assistant/core/exception/orders_not_found_exception.dart';
import 'package:smart_courier_assistant/data/model/order_model.dart';

class OrderFirestore {
  final _firestore = FirebaseFirestore.instance;

  Future<void> saveOrder(OrderModel orderModel, String routeId) async {
    final docReference = _getUserDocumentReference(orderModel.id, routeId);
    await docReference.set(orderModel);
  }

  Future<void> deleteOrder(String orderId, String routeId) async {
    final collectionReference = _getOrderCollectionReference(routeId);
    await collectionReference.doc(orderId).delete();
  }

  Future<List<OrderModel>> getAllUserOrders(String routeId) async {
    final collectionReference = _getOrderCollectionReference(routeId);
    final querySnapshot = await collectionReference.get();
    if (querySnapshot.docs.isEmpty) {
      throw OrdersNotFoundException('Orders weren\'t found');
    }
    return querySnapshot.docs.map((document) => document.data()).toList();
  }

  CollectionReference<OrderModel> _getOrderCollectionReference(String routeId) {
    return _firestore
        .collection('routes')
        .doc(routeId)
        .collection('orders')
        .withConverter(
          fromFirestore: OrderModel.fromFirestore,
          toFirestore: (OrderModel orderModel, options) =>
              orderModel.toFirestore(),
        );
  }

  DocumentReference<OrderModel> _getUserDocumentReference(
    String id,
    String routeId,
  ) {
    return _firestore
        .collection('routes')
        .doc(routeId)
        .collection('orders')
        .doc(id)
        .withConverter(
          fromFirestore: OrderModel.fromFirestore,
          toFirestore: (OrderModel orderModel, options) =>
              orderModel.toFirestore(),
        );
  }
}

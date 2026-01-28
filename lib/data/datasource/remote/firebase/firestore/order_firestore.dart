import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smart_courier_assistant/core/exception/orders_not_found_exception.dart';
import 'package:smart_courier_assistant/data/model/order_model.dart';
import 'package:smart_courier_assistant/data/model/proof_delivery_model.dart';

class OrderFirestore {
  final _firestore = FirebaseFirestore.instance;

  Future<void> saveOrder(OrderModel orderModel, String routeId) async {
    final docReference = _getUserDocumentReference(orderModel.id, routeId);
    await docReference.set(orderModel);
  }

  Future<void> saveOrders(
    List<OrderModel> orders,
    String routeId,
  ) async {
    final collectionReference = _getOrderCollectionReference(routeId);
    final batch = _firestore.batch();
    for (final order in orders) {
      batch.set(collectionReference.doc(order.id), order);
    }
    await batch.commit();
  }

  Future<void> deleteOrdersSubcollection(String routeId) async {
    final collectionReference = _getOrderCollectionReference(routeId);
    final snapshot = await collectionReference.get();

    final batch = _firestore.batch();
    for (final doc in snapshot.docs) {
      batch.delete(doc.reference);
    }
    await batch.commit();
  }

  Future<void> deleteOrder(String orderId, String routeId) async {
    final collectionReference = _getOrderCollectionReference(routeId);
    await collectionReference.doc(orderId).delete();
  }

  Future<List<OrderModel>> getAllUserOrders(String routeId) async {
    final collectionReference = _getOrderCollectionReference(routeId);
    final querySnapshot = await collectionReference.orderBy('orderIndex').get();
    if (querySnapshot.docs.isEmpty) {
      throw OrdersNotFoundException('Orders weren\'t found');
    }
    return querySnapshot.docs.map((document) => document.data()).toList();
  }

  Future<void> updateOrderProofDelivery(
    ProofDeliveryModel proofDelivery,
    String routeId,
    String orderId,
  ) async {
    final docReference = _getUserDocumentReference(orderId, routeId);
    await docReference.update({
      'status': 'Delivered',
      'proofDelivery': proofDelivery.toFirestore(),
    });
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

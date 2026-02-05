import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import 'package:smart_courier_assistant/data/model/proof_delivery_model.dart';

class OrderModel {
  final String id;
  final String clientFullName;
  final String clientPhoneNumber;
  final String address;
  final double latitude;
  final double longitude;
  final DateTime plannedEta;
  final DateTime deliveryBy;
  final String deliveryRisk;
  final String recommendation;
  final String category;
  final String status;
  final ProofDeliveryModel? proofDelivery;
  final int orderIndex;

  OrderModel({
    required this.id,
    required this.clientFullName,
    required this.clientPhoneNumber,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.plannedEta,
    required this.deliveryBy,
    required this.deliveryRisk,
    required this.recommendation,
    required this.category,
    required this.status,
    required this.proofDelivery,
    required this.orderIndex,
  });

  factory OrderModel.initial() {
    return OrderModel(
      id: const Uuid().v1(),
      clientFullName: '',
      clientPhoneNumber: '',
      address: '',
      latitude: 0,
      longitude: 0,
      category: '',
      recommendation: 'Uknown',
      deliveryRisk: 'On time',
      plannedEta: DateTime.now(),
      deliveryBy: DateTime.now(),
      status: 'Active',
      orderIndex: 0,
      proofDelivery: null,
    );
  }

  Map<String, dynamic> toFirestore() {
    return <String, dynamic>{
      'id': id,
      'clientFullName': clientFullName,
      'clientPhoneNumber': clientPhoneNumber,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'plannedEta': Timestamp.fromDate(plannedEta),
      'deliveryBy': Timestamp.fromDate(deliveryBy),
      'category': category,
      'deliveryRisk': deliveryRisk,
      'status': status,
      'recommendation': recommendation,
      'orderIndex': orderIndex,
      if (proofDelivery != null) 'proofDelivery': proofDelivery!.toFirestore(),
    };
  }

  factory OrderModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return OrderModel(
      id: data?['id'] as String,
      clientFullName: data?['clientFullName'] as String,
      clientPhoneNumber: data?['clientPhoneNumber'] as String,
      address: data?['address'] as String,
      latitude: data?['latitude'] as double,
      longitude: data?['longitude'] as double,
      plannedEta: (data?['plannedEta'] as Timestamp).toDate(),
      deliveryBy: (data?['deliveryBy'] as Timestamp).toDate(),
      category: data?['category'] as String,
      status: data?['status'] as String,
      deliveryRisk: data?['deliveryRisk'] as String,
      recommendation: data?['recommendation'] as String,
      orderIndex: (data?['orderIndex'] ?? 0) as int,
      proofDelivery: data?['proofDelivery'] != null
          ? ProofDeliveryModel.fromFirestore(
              Map<String, dynamic>.from(data?['proofDelivery']),
            )
          : null,
    );
  }

  OrderModel copyWith({
    String? id,
    String? clientFullName,
    String? clientPhoneNumber,
    String? address,
    double? latitude,
    double? longitude,
    DateTime? plannedEta,
    DateTime? deliveryBy,
    String? deliveryRisk,
    String? recommendation,
    String? category,
    String? status,
    ProofDeliveryModel? proofDelivery,
    int? orderIndex,
  }) {
    return OrderModel(
      id: id ?? this.id,
      clientFullName: clientFullName ?? this.clientFullName,
      clientPhoneNumber: clientPhoneNumber ?? this.clientPhoneNumber,
      address: address ?? this.address,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      plannedEta: plannedEta ?? this.plannedEta,
      deliveryBy: deliveryBy ?? this.deliveryBy,
      deliveryRisk: deliveryRisk ?? this.deliveryRisk,
      recommendation: recommendation ?? this.recommendation,
      category: category ?? this.category,
      status: status ?? this.status,
      proofDelivery: proofDelivery ?? this.proofDelivery,
      orderIndex: orderIndex ?? this.orderIndex,
    );
  }
}

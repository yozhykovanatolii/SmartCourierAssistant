import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class OrderModel {
  final String id;
  final String courierId;
  final String clientFullName;
  final String clientPhoneNumber;
  final String address;
  final String category;
  final String status;

  OrderModel({
    required this.id,
    required this.courierId,
    required this.clientFullName,
    required this.clientPhoneNumber,
    required this.address,
    required this.category,
    required this.status,
  });

  factory OrderModel.initial() {
    return OrderModel(
      id: const Uuid().v1(),
      courierId: '',
      clientFullName: '',
      clientPhoneNumber: '',
      address: '',
      category: '',
      status: 'Active',
    );
  }

  Map<String, dynamic> toFirestore() {
    return <String, dynamic>{
      'id': id,
      'courierId': courierId,
      'clientFullName': clientFullName,
      'clientPhoneNumber': clientPhoneNumber,
      'address': address,
      'category': category,
      'status': status,
    };
  }

  factory OrderModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return OrderModel(
      id: data?['id'] as String,
      courierId: data?['courierId'] as String,
      clientFullName: data?['clientFullName'] as String,
      clientPhoneNumber: data?['clientPhoneNumber'] as String,
      address: data?['address'] as String,
      category: data?['category'] as String,
      status: data?['status'] as String,
    );
  }

  OrderModel copyWith({
    String? id,
    String? courierId,
    String? clientFullName,
    String? clientPhoneNumber,
    String? address,
    String? category,
    String? status,
  }) {
    return OrderModel(
      id: id ?? this.id,
      courierId: courierId ?? this.courierId,
      clientFullName: clientFullName ?? this.clientFullName,
      clientPhoneNumber: clientPhoneNumber ?? this.clientPhoneNumber,
      address: address ?? this.address,
      category: category ?? this.category,
      status: status ?? this.status,
    );
  }
}

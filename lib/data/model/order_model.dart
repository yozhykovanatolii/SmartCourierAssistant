import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class OrderModel {
  final String id;
  final String clientFullName;
  final String clientPhoneNumber;
  final String address;
  final double latitude;
  final double longitude;
  final String category;
  final String status;

  OrderModel({
    required this.id,
    required this.clientFullName,
    required this.clientPhoneNumber,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.category,
    required this.status,
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
      status: 'Active',
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
      clientFullName: data?['clientFullName'] as String,
      clientPhoneNumber: data?['clientPhoneNumber'] as String,
      address: data?['address'] as String,
      latitude: data?['latitude'] as double,
      longitude: data?['longitude'] as double,
      category: data?['category'] as String,
      status: data?['status'] as String,
    );
  }

  OrderModel copyWith({
    String? id,
    String? clientFullName,
    String? clientPhoneNumber,
    String? address,
    double? latitude,
    double? longitude,
    String? category,
    String? status,
  }) {
    return OrderModel(
      id: id ?? this.id,
      clientFullName: clientFullName ?? this.clientFullName,
      clientPhoneNumber: clientPhoneNumber ?? this.clientPhoneNumber,
      address: address ?? this.address,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      category: category ?? this.category,
      status: status ?? this.status,
    );
  }
}

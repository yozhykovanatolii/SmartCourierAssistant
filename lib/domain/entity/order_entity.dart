import 'package:smart_courier_assistant/domain/entity/address_entity.dart';
import 'package:smart_courier_assistant/domain/entity/proof_delivery_entity.dart';

enum DeliveryRisk {
  onTime(color: 0xFF00FF00, text: 'On time'),
  delayed(color: 0xFFFF0000, text: 'Delayed'),
  atRisk(color: 0xFFFFD600, text: 'At risk');

  final int color;
  final String text;

  const DeliveryRisk({
    required this.color,
    required this.text,
  });

  static DeliveryRisk fromText(String textRisk) {
    return DeliveryRisk.values.firstWhere(
      (status) => status.text == textRisk,
    );
  }
}

class OrderEntity {
  final String id;
  final String clientFullName;
  final String clientPhoneNumber;
  final AddressEntity address;
  final DateTime plannedEta;
  final DateTime deliveryBy;
  final DeliveryRisk deliveryRisk;
  final ProofDeliveryEntity? proofDeliveryEntity;
  final String recommendation;
  final String category;
  final String status;
  final int orderIndex;

  OrderEntity({
    required this.id,
    required this.clientFullName,
    required this.clientPhoneNumber,
    required this.address,
    required this.plannedEta,
    required this.deliveryBy,
    required this.deliveryRisk,
    required this.proofDeliveryEntity,
    required this.recommendation,
    required this.category,
    required this.status,
    required this.orderIndex,
  });

  factory OrderEntity.initial() {
    return OrderEntity(
      id: '',
      clientFullName: '',
      clientPhoneNumber: '',
      address: AddressEntity.initial(),
      plannedEta: DateTime.now(),
      deliveryBy: DateTime.now(),
      deliveryRisk: DeliveryRisk.onTime,
      proofDeliveryEntity: null,
      recommendation: '',
      category: '',
      status: '',
      orderIndex: 0,
    );
  }

  OrderEntity copyWith({
    String? id,
    String? clientFullName,
    String? clientPhoneNumber,
    AddressEntity? address,
    DateTime? plannedEta,
    DateTime? deliveryBy,
    DeliveryRisk? deliveryRisk,
    ProofDeliveryEntity? proofDeliveryEntity,
    String? recommendation,
    String? category,
    String? status,
    int? orderIndex,
  }) {
    return OrderEntity(
      id: id ?? this.id,
      clientFullName: clientFullName ?? this.clientFullName,
      clientPhoneNumber: clientPhoneNumber ?? this.clientPhoneNumber,
      address: address ?? this.address,
      plannedEta: plannedEta ?? this.plannedEta,
      deliveryBy: deliveryBy ?? this.deliveryBy,
      deliveryRisk: deliveryRisk ?? this.deliveryRisk,
      proofDeliveryEntity: proofDeliveryEntity ?? this.proofDeliveryEntity,
      recommendation: recommendation ?? this.recommendation,
      category: category ?? this.category,
      status: status ?? this.status,
      orderIndex: orderIndex ?? this.orderIndex,
    );
  }
}

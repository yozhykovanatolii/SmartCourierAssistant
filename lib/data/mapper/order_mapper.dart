import 'package:smart_courier_assistant/data/mapper/proof_delivery_mapper.dart';
import 'package:smart_courier_assistant/data/model/firestore/order_model.dart';
import 'package:smart_courier_assistant/domain/entity/address_entity.dart';
import 'package:smart_courier_assistant/domain/entity/order_entity.dart';
import 'package:smart_courier_assistant/domain/entity/proof_delivery_entity.dart';

class OrderMapper {
  static OrderEntity toEntity(OrderModel orderModel) {
    return OrderEntity(
      id: orderModel.id,
      clientFullName: orderModel.clientFullName,
      clientPhoneNumber: orderModel.clientPhoneNumber,
      address: AddressEntity(
        name: orderModel.address,
        latitude: orderModel.latitude,
        longitude: orderModel.longitude,
      ),
      plannedEta: orderModel.plannedEta,
      deliveryBy: orderModel.deliveryBy,
      deliveryRisk: DeliveryRisk.fromText(orderModel.deliveryRisk),
      proofDeliveryEntity: ProofDeliveryEntity(
        courierComment: orderModel.proofDelivery?.courierComment ?? '',
        orderPhotos: orderModel.proofDelivery?.orderPhotos ?? [],
        confirmedAt: orderModel.proofDelivery?.confirmedAt ?? DateTime.now(),
      ),
      recommendation: orderModel.recommendation,
      category: orderModel.category,
      status: orderModel.status,
      orderIndex: orderModel.orderIndex,
    );
  }

  static OrderModel fromEntity(OrderEntity order) {
    return OrderModel(
      id: order.id,
      clientFullName: order.clientFullName,
      clientPhoneNumber: order.clientPhoneNumber,
      address: order.address.name,
      latitude: order.address.latitude,
      longitude: order.address.longitude,
      plannedEta: order.plannedEta,
      deliveryBy: order.deliveryBy,
      deliveryRisk: order.deliveryRisk.text,
      recommendation: order.recommendation,
      category: order.category,
      status: order.status,
      proofDelivery: ProofDeliveryMapper.fromEntity(
        order.proofDeliveryEntity,
      ),
      orderIndex: order.orderIndex,
    );
  }
}

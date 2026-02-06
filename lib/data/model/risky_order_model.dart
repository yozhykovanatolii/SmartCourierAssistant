import 'package:smart_courier_assistant/data/model/order_model.dart';

class RiskyOrderModel {
  final String id;
  final String address;
  final String status;
  final int delayMinutes;
  final int positionInRoute;

  RiskyOrderModel({
    required this.id,
    required this.address,
    required this.status,
    required this.delayMinutes,
    required this.positionInRoute,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'address': address,
      'status': status,
      'delay_minutes': delayMinutes,
      'position_in_route': positionInRoute,
    };
  }

  @override
  String toString() {
    return 'Order #$id at "$address" is $status, delay about $delayMinutes min, position $positionInRoute in route';
  }

  factory RiskyOrderModel.fromOrderModel(OrderModel order) {
    return RiskyOrderModel(
      id: order.id,
      address: order.address,
      status: order.deliveryRisk,
      delayMinutes: order.deliveryBy.difference(order.plannedEta).inMinutes,
      positionInRoute: order.orderIndex,
    );
  }
}

import 'package:smart_courier_assistant/data/model/order_model.dart';

class CalculationEtaUtil {
  static const int _unloadingTimePerJob = 300;

  static List<OrderModel> calculateEtaForOrders(
    List<Map<String, dynamic>> steps,
    List<OrderModel> orders,
  ) {
    DateTime startTime = DateTime.now();
    Duration cumulativeDuration = Duration.zero;
    final jobIdToOrderId = {for (var o in orders) o.id.hashCode: o.id};
    List<OrderModel> updatedOrders = [];
    for (int i = 0; i < steps.length; i++) {
      final step = steps[i];
      if (step['type'] != 'job') continue;
      final orderId = jobIdToOrderId[step['job']];
      final order = orders.firstWhere((o) => o.id == orderId);
      cumulativeDuration += Duration(
        seconds: step['duration'] + _unloadingTimePerJob,
      );
      final eta = startTime.add(cumulativeDuration);
      final deliveryRisk = _getDeliveryRiskByETA(eta, order.deliveryBy);
      final recommendation = _generateOrderRecomendation(
        deliveryRisk,
        eta,
        order.deliveryBy,
        order.address,
      );
      final updatedOrder = order.copyWith(
        latitude: step['location'][1],
        longitude: step['location'][0],
        status: order.status,
        plannedEta: eta,
        deliveryRisk: deliveryRisk,
        recommendation: recommendation,
        orderIndex: updatedOrders.length,
      );
      updatedOrders.add(updatedOrder);
    }
    return updatedOrders;
  }

  static String _getDeliveryRiskByETA(DateTime eta, DateTime deliverBy) {
    final difference = deliverBy.difference(eta).inMinutes;
    if (difference >= 5) {
      return 'On time';
    } else if (difference >= 0) {
      return 'At risk';
    }
    return 'Delayed';
  }

  static String _generateOrderRecomendation(
    String deliveryRisk,
    DateTime plannedEta,
    DateTime deliverBy,
    String address,
  ) {
    if (deliveryRisk == 'On time') return 'Uknown';
    if (deliveryRisk == 'Delayed') {
      return 'Delay unavoidable (~${plannedEta.difference(deliverBy).inMinutes.abs()} min). We recommend completing "$address" last.';
    }
    return 'Risk of delay. Consider completing "$address" earlier to reduce potential lateness.';
  }
}

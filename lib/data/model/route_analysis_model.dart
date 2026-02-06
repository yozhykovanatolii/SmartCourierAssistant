import 'package:smart_courier_assistant/data/model/risky_order_model.dart';

class RouteAnalysisModel {
  final int totalOrders;
  final List<RiskyOrderModel> riskyOrders;
  final String currentTime;

  RouteAnalysisModel({
    required this.totalOrders,
    required this.riskyOrders,
    required this.currentTime,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'totalOrders': totalOrders,
      'riskyOrders': riskyOrders.map((o) => o.toJson()).toList(),
      'currentTime': currentTime,
    };
  }

  String generateUserPrompt() {
    final buffer = StringBuffer();
    buffer.writeln('Route analysis:');
    buffer.writeln('Total orders: $totalOrders');
    buffer.writeln('Orders at risk or delayed: ${riskyOrders.length}\n');
    for (var o in riskyOrders) {
      buffer.writeln(
        'Order #${o.id} at "${o.address}" is ${o.status}, delay about ${o.delayMinutes} min, position ${o.positionInRoute} in route',
      );
    }
    return buffer.toString();
  }
}

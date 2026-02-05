import 'package:smart_courier_assistant/data/model/order_model.dart';
import 'package:smart_courier_assistant/data/model/route_model.dart';
import 'package:smart_courier_assistant/domain/entity/route_entity.dart';

class RouteMapper {
  static RouteEntity toEntity(
    RouteModel routeModel,
    List<OrderModel> ordersModel,
  ) {
    final delayedOrdersCount = ordersModel
        .where(
          (orderModel) => orderModel.deliveryRisk == 'Delayed',
        )
        .length;
    return RouteEntity(
      routeId: routeModel.routeId,
      ordersCount: ordersModel.length,
      delayedOrdersCount: delayedOrdersCount,
      createAt: routeModel.date,
    );
  }
}

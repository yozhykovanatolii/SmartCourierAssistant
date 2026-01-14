import 'package:smart_courier_assistant/data/model/order_model.dart';

sealed class OrderState {}

final class OrderInitialState extends OrderState {}

final class OrderLoadingState extends OrderState {}

final class OrderSuccessState extends OrderState {
  final List<OrderModel> activeOrders;

  OrderSuccessState(this.activeOrders);
}

final class OrderFailureState extends OrderState {
  final String errorMessage;

  OrderFailureState(this.errorMessage);
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_courier_assistant/core/exception/orders_not_found_exception.dart';
import 'package:smart_courier_assistant/data/repository/order_repository.dart';
import 'package:smart_courier_assistant/presentation/bloc/order/order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  final OrderRepository _orderRepository = OrderRepository();

  OrderCubit() : super(OrderInitialState());

  Future<void> fetchOrders() async {
    emit(OrderLoadingState());
    try {
      final activeOrders = await _orderRepository.getAllCourierActiveOrders();
      emit(OrderSuccessState(activeOrders));
    } on OrdersNotFoundException catch (exception) {
      emit(OrderFailureState(exception.errorMessage));
    }
  }

  Future<void> optimizeOrdersRoute() async {
    if (state is OrderSuccessState) {
      final orders = (state as OrderSuccessState).activeOrders;
      await _orderRepository.optimizeOrdersRoute(orders);
    } else {
      return;
    }
  }
}

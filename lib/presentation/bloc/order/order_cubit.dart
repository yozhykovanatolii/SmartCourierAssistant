import 'package:flutter_bloc/flutter_bloc.dart';
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
    } catch (exception) {
      emit(OrderFailureState(exception.toString()));
    }
  }
}

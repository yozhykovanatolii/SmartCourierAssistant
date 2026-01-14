import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_courier_assistant/core/exception/auth/user_not_found_exception.dart';
import 'package:smart_courier_assistant/data/model/order_model.dart';
import 'package:smart_courier_assistant/data/repository/order_repository.dart';
import 'package:smart_courier_assistant/data/repository/user_repository.dart';
import 'package:smart_courier_assistant/presentation/bloc/login/login_state.dart';
import 'package:smart_courier_assistant/presentation/bloc/save_order/save_order_state.dart';

class SaveOrderCubit extends Cubit<SaveOrderState> {
  final OrderRepository _orderRepository = OrderRepository();
  final UserRepository _userRepository = UserRepository();
  String orderId = '';

  SaveOrderCubit() : super(SaveOrderState.initial());

  void setOrderAddress(String address) {
    emit(state.copyWith(address: address));
  }

  void setClientFullName(String clientFullName) {
    emit(state.copyWith(clientFullName: clientFullName));
  }

  void setClientPhoneNumber(String clientPhoneNumber) {
    emit(state.copyWith(clientPhoneNumber: clientPhoneNumber));
  }

  void chooseOrderCategory(String category) {
    final previousCategory = state.category;
    if (category == previousCategory) return;
    emit(state.copyWith(category: category));
  }

  Future<void> deleteOrder() async {
    await _orderRepository.deleteOrder(orderId);
  }

  void editOrder(OrderModel? order) {
    if (order != null) {
      orderId = order.id;
      emit(
        state.copyWith(
          address: order.address,
          clientFullName: order.clientFullName,
          clientPhoneNumber: order.clientPhoneNumber,
          category: order.category,
        ),
      );
    }
  }

  Future<void> saveOrder(OrderModel? currentOrder) async {
    emit(state.copyWith(formStatus: FormStatus.loading));
    try {
      await _orderRepository.saveOrder(
        state.clientFullName,
        state.clientPhoneNumber,
        state.address,
        state.category,
        currentOrder: currentOrder,
      );
      emit(state.copyWith(formStatus: FormStatus.success));
    } on UserNotFoundException catch (exception) {
      emit(
        state.copyWith(
          errorMessage: exception.errorMessage,
          formStatus: FormStatus.success,
        ),
      );
    } finally {
      emit(
        state.copyWith(
          errorMessage: '',
          formStatus: FormStatus.initial,
        ),
      );
    }
  }

  Future<void> openCallDialer(String clientPhoneNumber) async {
    try {
      await _userRepository.callUserDialer(clientPhoneNumber);
    } catch (exception) {
      emit(
        state.copyWith(
          errorMessage: exception.toString(),
          formStatus: FormStatus.failure,
        ),
      );
    } finally {
      emit(
        state.copyWith(
          errorMessage: '',
          formStatus: FormStatus.initial,
        ),
      );
    }
  }
}

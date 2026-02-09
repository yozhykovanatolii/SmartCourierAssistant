import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_courier_assistant/core/exception/auth/user_not_found_exception.dart';
import 'package:smart_courier_assistant/core/exception/geolocation_exception.dart';
import 'package:smart_courier_assistant/core/state/form_status.dart';
import 'package:smart_courier_assistant/domain/entity/order_entity.dart';
import 'package:smart_courier_assistant/domain/repository/order_repository.dart';
import 'package:smart_courier_assistant/domain/repository/route_repository.dart';
import 'package:smart_courier_assistant/presentation/bloc/save_order/save_order_state.dart';

class SaveOrderCubit extends Cubit<SaveOrderState> {
  final OrderRepository orderRepository;
  final RouteRepository routeRepository;
  String _orderId = '';

  SaveOrderCubit(this.orderRepository, this.routeRepository)
    : super(SaveOrderState.initial());

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

  void chooseDeliveryTime(int hour, int minute) {
    DateTime currentDeliveryBy = state.deliveryBy;
    if (currentDeliveryBy.hour == hour && currentDeliveryBy.minute == minute) {
      return;
    }
    currentDeliveryBy = currentDeliveryBy.copyWith(
      hour: hour,
      minute: minute,
    );
    emit(state.copyWith(deliveryBy: currentDeliveryBy));
  }

  Future<void> deleteOrder() async {
    await orderRepository.deleteOrder(_orderId);
  }

  void editOrder(OrderEntity? order) {
    if (order != null) {
      _orderId = order.id;
      emit(
        state.copyWith(
          address: order.address.name,
          clientFullName: order.clientFullName,
          clientPhoneNumber: order.clientPhoneNumber,
          deliveryBy: order.deliveryBy,
          category: order.category,
        ),
      );
    }
  }

  Future<void> saveOrder(OrderEntity? currentOrder) async {
    emit(state.copyWith(formStatus: FormStatus.loading));
    try {
      final routeId = await routeRepository.createRoute();
      await orderRepository.saveOrder(
        state.clientFullName,
        state.clientPhoneNumber,
        state.address,
        state.category,
        routeId,
        state.deliveryBy,
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
    } on GeolocationException catch (exception) {
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
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_courier_assistant/core/exception/auth/user_not_found_exception.dart';
import 'package:smart_courier_assistant/core/exception/orders_not_found_exception.dart';
import 'package:smart_courier_assistant/core/exception/permission_deny_exception.dart';
import 'package:smart_courier_assistant/core/exception/photo_not_selected_exception.dart';
import 'package:smart_courier_assistant/core/state/form_status.dart';
import 'package:smart_courier_assistant/domain/repository/delivery_repository.dart';
import 'package:smart_courier_assistant/domain/repository/order_repository.dart';
import 'package:smart_courier_assistant/presentation/bloc/proof_delivery/proof_delivery_state.dart';

class ProofDeliveryCubit extends Cubit<ProofDeliveryState> {
  final OrderRepository orderRepository;
  final DeliveryRepository deliveryRepository;

  ProofDeliveryCubit(
    this.orderRepository,
    this.deliveryRepository,
  ) : super(ProofDeliveryState.initial());

  Future<void> addOrderPhoto() async {
    try {
      final photoUrl = await orderRepository.getOrderPhoto();
      final updatedOrderPhotos = List<String>.from(state.orderPhotos)
        ..add(photoUrl);
      emit(state.copyWith(orderPhotos: updatedOrderPhotos));
    } on PermissionDenyException catch (exception) {
      emit(
        state.copyWith(
          errorMessage: exception.errorMessage,
          formStatus: FormStatus.failure,
        ),
      );
    } on PhotoNotSelectedException catch (exception) {
      emit(
        state.copyWith(
          errorMessage: exception.errorMessage,
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

  void deleteOrderPhoto(String orderPhotoUrl) {
    final updatedList = List<String>.from(state.orderPhotos)
      ..remove(orderPhotoUrl);
    emit(state.copyWith(orderPhotos: updatedList));
  }

  void editCourierComment(String courierComment) {
    emit(state.copyWith(courierComment: courierComment));
  }

  Future<void> confirmDelivery(String orderId) async {
    emit(state.copyWith(formStatus: FormStatus.loading));
    try {
      await deliveryRepository.createProofOfDelivery(
        orderId,
        state.courierComment,
        state.orderPhotos,
      );
      emit(state.copyWith(formStatus: FormStatus.success));
    } on UserNotFoundException catch (exception) {
      emit(
        state.copyWith(
          errorMessage: exception.errorMessage,
          formStatus: FormStatus.failure,
        ),
      );
    } on OrdersNotFoundException catch (exception) {
      emit(
        state.copyWith(
          errorMessage: exception.errorMessage,
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

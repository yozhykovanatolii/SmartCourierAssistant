import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_courier_assistant/core/exception/permission_deny_exception.dart';
import 'package:smart_courier_assistant/core/exception/photo_not_selected_exception.dart';
import 'package:smart_courier_assistant/data/repository/order_repository.dart';
import 'package:smart_courier_assistant/presentation/bloc/login/login_state.dart';
import 'package:smart_courier_assistant/presentation/bloc/proof_delivery/proof_delivery_state.dart';

class ProofDeliveryCubit extends Cubit<ProofDeliveryState> {
  final OrderRepository _orderRepository = OrderRepository();

  ProofDeliveryCubit() : super(ProofDeliveryState.initial());

  Future<void> addOrderPhoto() async {
    try {
      final photoUrl = await _orderRepository.getOrderPhoto();
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
      emit(state.copyWith(errorMessage: '', formStatus: FormStatus.initial));
    }
  }

  void deleteOrderPhoto(String orderPhotoUrl) {
    final updatedList = List<String>.from(state.orderPhotos)
      ..remove(orderPhotoUrl);
    emit(state.copyWith(orderPhotos: updatedList));
  }
}

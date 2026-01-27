import 'package:smart_courier_assistant/core/validator/delivery_validator.dart';
import 'package:smart_courier_assistant/presentation/bloc/login/login_state.dart';
import 'package:smart_courier_assistant/presentation/bloc/save_order/save_order_state.dart';

class ProofDeliveryState {
  final List<String> orderPhotos;
  final String courierComment;
  final String errorMessage;
  final FormStatus formStatus;

  ProofDeliveryState({
    required this.orderPhotos,
    required this.courierComment,
    required this.errorMessage,
    required this.formStatus,
  });

  factory ProofDeliveryState.initial() {
    return ProofDeliveryState(
      orderPhotos: [],
      courierComment: '',
      errorMessage: '',
      formStatus: FormStatus.initial,
    );
  }

  ProofDeliveryState copyWith({
    List<String>? orderPhotos,
    String? courierComment,
    String? errorMessage,
    FormStatus? formStatus,
  }) {
    return ProofDeliveryState(
      orderPhotos: orderPhotos ?? this.orderPhotos,
      courierComment: courierComment ?? this.courierComment,
      errorMessage: errorMessage ?? this.errorMessage,
      formStatus: formStatus ?? this.formStatus,
    );
  }

  String get courierCommentCount => '${courierComment.length}/200';
  String? get courierCommentError =>
      DeliveryValidator.validateCourierComment(courierComment);

  ButtonStatus get buttonStatus {
    if (orderPhotos.isEmpty ||
        DeliveryValidator.validateCourierComment(courierComment) != null) {
      return ButtonStatus.disabled;
    }
    return ButtonStatus.enabled;
  }
}

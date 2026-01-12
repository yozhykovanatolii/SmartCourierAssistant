import 'package:smart_courier_assistant/core/validator/order_validator.dart';
import 'package:smart_courier_assistant/core/validator/user_validator.dart';
import 'package:smart_courier_assistant/presentation/bloc/login/login_state.dart';

enum ButtonStatus { enabled, disabled }

class SaveOrderState {
  final String clientFullName;
  final String clientPhoneNumber;
  final String address;
  final String category;
  final FormStatus formStatus;
  final String errorMessage;

  SaveOrderState({
    required this.clientFullName,
    required this.clientPhoneNumber,
    required this.address,
    required this.category,
    required this.formStatus,
    required this.errorMessage,
  });

  factory SaveOrderState.initial() {
    return SaveOrderState(
      clientFullName: '',
      clientPhoneNumber: '',
      address: '',
      category: '📦 Parcel',
      formStatus: FormStatus.initial,
      errorMessage: '',
    );
  }

  SaveOrderState copyWith({
    String? clientFullName,
    String? clientPhoneNumber,
    String? address,
    String? category,
    FormStatus? formStatus,
    String? errorMessage,
  }) {
    return SaveOrderState(
      clientFullName: clientFullName ?? this.clientFullName,
      clientPhoneNumber: clientPhoneNumber ?? this.clientPhoneNumber,
      address: address ?? this.address,
      category: category ?? this.category,
      formStatus: formStatus ?? this.formStatus,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  String? get clientFullNameError =>
      UserValidator.validateFullName(clientFullName);
  String? get clientPhoneNumberError =>
      UserValidator.validatePhoneNumber(clientPhoneNumber);
  String? get addressError => OrderValidator.validateAddress(address);

  ButtonStatus get buttonStatus {
    if (clientFullNameError != null ||
        clientPhoneNumberError != null ||
        addressError != null) {
      return ButtonStatus.disabled;
    }
    return ButtonStatus.enabled;
  }
}

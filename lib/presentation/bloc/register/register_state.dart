import 'package:smart_courier_assistant/core/state/form_status.dart';
import 'package:smart_courier_assistant/core/validator/user_validator.dart';

class RegisterState {
  final String fullName;
  final String email;
  final String password;
  final String phoneNumber;
  final String errorMessage;
  final FormStatus formStatus;

  RegisterState({
    required this.fullName,
    required this.email,
    required this.password,
    required this.phoneNumber,
    required this.errorMessage,
    required this.formStatus,
  });

  factory RegisterState.initial() {
    return RegisterState(
      fullName: '',
      email: '',
      password: '',
      phoneNumber: '',
      errorMessage: '',
      formStatus: FormStatus.initial,
    );
  }

  RegisterState copyWith({
    String? fullName,
    String? email,
    String? password,
    String? phoneNumber,
    String? errorMessage,
    FormStatus? formStatus,
  }) {
    return RegisterState(
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      password: password ?? this.password,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      errorMessage: errorMessage ?? this.errorMessage,
      formStatus: formStatus ?? this.formStatus,
    );
  }

  String? get fullNameError => UserValidator.validateFullName(fullName);
  String? get emailError => UserValidator.validateEmail(email);
  String? get passwordError => UserValidator.validatePassword(password);
  String? get phoneNumberError =>
      UserValidator.validatePhoneNumber(phoneNumber);
}

import 'package:smart_courier_assistant/core/state/form_status.dart';
import 'package:smart_courier_assistant/core/validator/user_validator.dart';

class LoginState {
  final String email;
  final String password;
  final FormStatus formStatus;
  final FormStatus googleLoginStatus;
  final String errorMessage;

  LoginState({
    required this.email,
    required this.password,
    required this.formStatus,
    required this.googleLoginStatus,
    required this.errorMessage,
  });

  factory LoginState.initial() {
    return LoginState(
      email: '',
      password: '',
      formStatus: FormStatus.initial,
      googleLoginStatus: FormStatus.initial,
      errorMessage: '',
    );
  }

  LoginState copyWith({
    String? email,
    String? password,
    FormStatus? formStatus,
    FormStatus? googleLoginStatus,
    String? errorMessage,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      formStatus: formStatus ?? this.formStatus,
      googleLoginStatus: googleLoginStatus ?? this.googleLoginStatus,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  String? get emailError => UserValidator.validateEmail(email);
  String? get passwordError => UserValidator.validatePassword(password);
}

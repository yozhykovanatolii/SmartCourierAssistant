import 'package:smart_courier_assistant/core/validator/user_validator.dart';

enum FormStatus { initial, loading, success, failure }

class LoginState {
  final String email;
  final String password;
  final FormStatus formStatus;
  final String errorMessage;

  LoginState({
    required this.email,
    required this.password,
    required this.formStatus,
    required this.errorMessage,
  });

  factory LoginState.initial() {
    return LoginState(
      email: '',
      password: '',
      formStatus: FormStatus.initial,
      errorMessage: '',
    );
  }

  LoginState copyWith({
    String? email,
    String? password,
    FormStatus? formStatus,
    String? errorMessage,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      formStatus: formStatus ?? this.formStatus,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  String? get emailError => UserValidator.validateEmail(email);
  String? get passwordError => UserValidator.validatePassword(password);
}

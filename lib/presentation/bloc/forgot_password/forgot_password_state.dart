import 'package:smart_courier_assistant/core/validator/user_validator.dart';
import 'package:smart_courier_assistant/presentation/bloc/login/login_state.dart';

class ForgotPasswordState {
  final String email;
  final FormStatus formStatus;
  final String errorMessage;

  ForgotPasswordState({
    required this.email,
    required this.formStatus,
    required this.errorMessage,
  });

  factory ForgotPasswordState.initial() {
    return ForgotPasswordState(
      email: '',
      formStatus: FormStatus.initial,
      errorMessage: '',
    );
  }

  ForgotPasswordState copyWith({
    String? email,
    FormStatus? formStatus,
    String? errorMessage,
  }) {
    return ForgotPasswordState(
      email: email ?? this.email,
      formStatus: formStatus ?? this.formStatus,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  String? get emailErrorMessage => UserValidator.validateEmail(email);
}

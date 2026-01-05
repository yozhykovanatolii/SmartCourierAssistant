import 'package:smart_courier_assistant/core/validator/user_validator.dart';
import 'package:smart_courier_assistant/presentation/bloc/login/login_state.dart';

class ResetPasswordState {
  final String email;
  final FormStatus formStatus;
  final String errorMessage;

  ResetPasswordState({
    required this.email,
    required this.formStatus,
    required this.errorMessage,
  });

  factory ResetPasswordState.initial() {
    return ResetPasswordState(
      email: '',
      formStatus: FormStatus.initial,
      errorMessage: '',
    );
  }

  ResetPasswordState copyWith({
    String? email,
    FormStatus? formStatus,
    String? errorMessage,
  }) {
    return ResetPasswordState(
      email: email ?? this.email,
      formStatus: formStatus ?? this.formStatus,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  String? get emailErrorMessage => UserValidator.validateEmail(email);
}

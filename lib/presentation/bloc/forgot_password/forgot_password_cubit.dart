import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_courier_assistant/core/exception/auth/reset_password_exception.dart';
import 'package:smart_courier_assistant/data/repository/auth_repository.dart';
import 'package:smart_courier_assistant/presentation/bloc/forgot_password/forgot_password_state.dart';
import 'package:smart_courier_assistant/presentation/bloc/login/login_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  final AuthRepository _authRepository = AuthRepository();

  ForgotPasswordCubit() : super(ForgotPasswordState.initial());

  void changeUserEmail(String email) {
    emit(state.copyWith(email: email));
  }

  Future<void> sendEmailLetter() async {
    emit(state.copyWith(formStatus: FormStatus.loading));
    try {
      await _authRepository.resetPassword(state.email);
      emit(state.copyWith(formStatus: FormStatus.success));
    } on ResetPasswordException catch (exception) {
      emit(
        state.copyWith(
          formStatus: FormStatus.failure,
          errorMessage: exception.errorMessage,
        ),
      );
    } finally {
      emit(state.copyWith(formStatus: FormStatus.initial));
    }
  }
}

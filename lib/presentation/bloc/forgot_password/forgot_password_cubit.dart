import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_courier_assistant/core/exception/auth/reset_password_exception.dart';
import 'package:smart_courier_assistant/core/state/form_status.dart';
import 'package:smart_courier_assistant/domain/repository/auth_repository.dart';
import 'package:smart_courier_assistant/domain/repository/user_repository.dart';
import 'package:smart_courier_assistant/presentation/bloc/forgot_password/forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  final AuthRepository authRepository;
  final UserRepository userRepository;

  ForgotPasswordCubit(this.authRepository, this.userRepository)
    : super(ForgotPasswordState.initial());

  void changeUserEmail(String email) {
    emit(state.copyWith(email: email));
  }

  Future<void> sendEmailLetter() async {
    emit(state.copyWith(formStatus: FormStatus.loading));
    try {
      final isUserExist = await userRepository.checkIfUserExistByEmail(
        state.email,
      );
      if (isUserExist) {
        emit(
          state.copyWith(
            formStatus: FormStatus.failure,
            errorMessage: 'This email is busy, please choose another one.',
          ),
        );
        return;
      }
      await authRepository.resetPassword(state.email);
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

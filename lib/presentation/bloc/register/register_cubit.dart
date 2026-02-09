import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_courier_assistant/core/exception/auth/register_exception.dart';
import 'package:smart_courier_assistant/core/state/form_status.dart';
import 'package:smart_courier_assistant/domain/repository/auth_repository.dart';
import 'package:smart_courier_assistant/domain/repository/user_repository.dart';
import 'package:smart_courier_assistant/presentation/bloc/register/register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final UserRepository userRepository;
  final AuthRepository authRepository;

  RegisterCubit(this.userRepository, this.authRepository)
    : super(RegisterState.initial());

  void setRegisterFullName(String fullName) {
    emit(state.copyWith(fullName: fullName));
  }

  void setRegisterEmail(String email) {
    emit(state.copyWith(email: email));
  }

  void setRegisterPassword(String password) {
    emit(state.copyWith(password: password));
  }

  void setRegisterPhoneNumber(String phoneNumber) {
    emit(state.copyWith(phoneNumber: phoneNumber));
  }

  Future<void> signUpUser() async {
    if (state.emailError != null ||
        state.fullNameError != null ||
        state.passwordError != null ||
        state.phoneNumberError != null) {
      return;
    }
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
      await authRepository.signUpUser(
        state.email,
        state.password,
        state.fullName,
        state.phoneNumber,
      );
      emit(state.copyWith(formStatus: FormStatus.success));
    } on RegisterException catch (exception) {
      emit(
        state.copyWith(
          formStatus: FormStatus.failure,
          errorMessage: exception.message,
        ),
      );
    } finally {
      emit(state.copyWith(formStatus: FormStatus.initial));
    }
  }
}

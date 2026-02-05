import 'package:bloc/bloc.dart';
import 'package:smart_courier_assistant/core/exception/auth/login_exception.dart';
import 'package:smart_courier_assistant/core/exception/auth/login_with_google_exception.dart';
import 'package:smart_courier_assistant/core/state/form_status.dart';
import 'package:smart_courier_assistant/data/repository/auth_repository.dart';
import 'package:smart_courier_assistant/presentation/bloc/login/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepository _authRepository = AuthRepository();

  LoginCubit() : super(LoginState.initial());

  void setLoginEmail(String email) {
    emit(state.copyWith(email: email));
  }

  void setLoginPassword(String password) {
    emit(state.copyWith(password: password));
  }

  Future<void> signInUser() async {
    if (state.emailError != null || state.passwordError != null) return;
    emit(state.copyWith(formStatus: FormStatus.loading));
    try {
      await _authRepository.signInUser(state.email, state.password);
      emit(state.copyWith(formStatus: FormStatus.success));
    } on LoginException catch (exception) {
      emit(
        state.copyWith(
          errorMessage: exception.message,
          formStatus: FormStatus.failure,
        ),
      );
    } finally {
      emit(state.copyWith(formStatus: FormStatus.initial));
    }
  }

  Future<void> signInWithGoogle() async {
    emit(state.copyWith(googleLoginStatus: FormStatus.loading));
    try {
      await _authRepository.signInWithGoogle();
      emit(state.copyWith(googleLoginStatus: FormStatus.success));
    } on LoginWithGoogleException catch (exception) {
      emit(
        state.copyWith(
          errorMessage: exception.message,
          googleLoginStatus: FormStatus.failure,
        ),
      );
    } finally {
      emit(state.copyWith(googleLoginStatus: FormStatus.initial));
    }
  }
}

import 'package:bloc/bloc.dart';
import 'package:smart_courier_assistant/presentation/bloc/login/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
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
  }
}

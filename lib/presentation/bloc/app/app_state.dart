import 'package:smart_courier_assistant/data/model/user_model.dart';

sealed class AppState {}

final class AppInitialState extends AppState {}

final class UserAuthenticatedState extends AppState {
  final UserModel user;

  UserAuthenticatedState(this.user);
}

final class UserUnauthenticatedState extends AppState {
  final String errorMessage;

  UserUnauthenticatedState(this.errorMessage);
}

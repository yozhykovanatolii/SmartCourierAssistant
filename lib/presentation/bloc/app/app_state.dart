import 'package:smart_courier_assistant/domain/entity/user_entity.dart';

sealed class AppState {}

final class AppInitialState extends AppState {}

final class UserAuthenticatedState extends AppState {
  final UserEntity user;

  UserAuthenticatedState(this.user);
}

final class UserUnauthenticatedState extends AppState {
  final String errorMessage;

  UserUnauthenticatedState(this.errorMessage);
}

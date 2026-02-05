import 'package:smart_courier_assistant/domain/entity/user_entity.dart';

sealed class AppEvent {}

class AppUserSubscriptionRequested extends AppEvent {}

class AppUserChanged extends AppEvent {
  final UserEntity user;

  AppUserChanged(this.user);
}

class AppUserUnauthenticated extends AppEvent {
  final String errorMessage;

  AppUserUnauthenticated(this.errorMessage);
}

import 'package:smart_courier_assistant/data/model/user_model.dart';

sealed class AppEvent {}

class AppUserSubscriptionRequested extends AppEvent {}

class AppUserChanged extends AppEvent {
  final UserModel user;

  AppUserChanged(this.user);
}

class AppUserUnauthenticated extends AppEvent {
  final String errorMessage;

  AppUserUnauthenticated(this.errorMessage);
}

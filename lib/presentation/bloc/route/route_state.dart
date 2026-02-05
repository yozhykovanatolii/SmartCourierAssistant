import 'package:smart_courier_assistant/domain/entity/route_entity.dart';

sealed class RouteState {}

final class RouteInitialState extends RouteState {}

final class RouteLoadingState extends RouteState {}

final class RouteSuccessState extends RouteState {
  final List<RouteEntity> routes;

  RouteSuccessState(this.routes);
}

final class RouteFailureState extends RouteState {
  final String errorMessage;

  RouteFailureState(this.errorMessage);
}

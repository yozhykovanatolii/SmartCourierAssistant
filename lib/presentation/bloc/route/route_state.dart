import 'package:smart_courier_assistant/data/model/route_model.dart';

sealed class RouteState {}

final class RouteInitialState extends RouteState {}

final class RouteLoadingState extends RouteState {}

final class RouteSuccessState extends RouteState {
  final List<RouteModel> routes;

  RouteSuccessState(this.routes);
}

final class RouteFailureState extends RouteState {
  final String errorMessage;

  RouteFailureState(this.errorMessage);
}

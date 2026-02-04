import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_courier_assistant/core/exception/auth/user_not_found_exception.dart';
import 'package:smart_courier_assistant/core/exception/route_not_found_exception.dart';
import 'package:smart_courier_assistant/data/repository/route_repository.dart';
import 'package:smart_courier_assistant/presentation/bloc/route/route_state.dart';

class RouteCubit extends Cubit<RouteState> {
  final _routeRepository = RouteRepository();

  RouteCubit() : super(RouteInitialState());

  Future<void> fetchAllCourierRoutes() async {
    emit(RouteLoadingState());
    try {
      final routes = await _routeRepository.getAllCourierRoutes();
      emit(RouteSuccessState(routes));
    } on UserNotFoundException catch (exception) {
      emit(RouteFailureState(exception.errorMessage));
    } on RouteNotFoundException catch (exception) {
      emit(RouteFailureState(exception.errorMessage));
    }
  }
}

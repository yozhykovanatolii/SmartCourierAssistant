import 'package:smart_courier_assistant/data/datasource/remote/firebase_auth/user_auth.dart';
import 'package:smart_courier_assistant/data/datasource/remote/firestore/route_firestore.dart';
import 'package:smart_courier_assistant/data/model/route_model.dart';

class RouteRepository {
  final RouteFirestore _routeFirestore = RouteFirestore();
  final UserAuth _userAuth = UserAuth();

  Future<String> createRoute() async {
    RouteModel routeModel = RouteModel.initial();
    final courierId = _userAuth.userId;
    final routeId = await _routeFirestore.getTodayRouteId(courierId);
    if (routeId == null) {
      routeModel = routeModel.copyWith(courierId: courierId);
      await _routeFirestore.createRoute(routeModel);
      return routeModel.routeId;
    }
    return routeId;
  }
}

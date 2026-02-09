import 'package:geolocator/geolocator.dart';
import 'package:smart_courier_assistant/data/service/geolocation_service.dart';
import 'package:smart_courier_assistant/domain/repository/geolocation_repository.dart';

class GeolocationRepositoryImpl implements GeolocationRepository {
  @override
  Future<Position> getCurrentLocation() async {
    return await GeolocationService.getCurrentLocation();
  }
}

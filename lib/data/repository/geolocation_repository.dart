import 'package:geolocator/geolocator.dart';
import 'package:smart_courier_assistant/data/service/geolocation_service.dart';

class GeolocationRepository {
  Future<Position> getCurrentLocation() async {
    return await GeolocationService.getCurrentLocation();
  }
}

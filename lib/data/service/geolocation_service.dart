import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:smart_courier_assistant/core/exception/geolocation_exception.dart';

class GeolocationService {
  static Future<Position> getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw GeolocationException('Location services are disabled.');
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw const PermissionDeniedException(
          'Location permissions are denied',
        );
      }
    }
    return await Geolocator.getCurrentPosition();
  }

  static Future<Location> getLocationByAddress(String address) async {
    final locations = await locationFromAddress(address);
    if (locations.isEmpty) {
      throw GeolocationException('Location did not find by address');
    }
    return locations.first;
  }
}

import 'package:geocoding/geocoding.dart';
import 'package:smart_courier_assistant/core/exception/geolocation_exception.dart';

class GeolocationService {
  static Future<Location> getLocationByAddress(String address) async {
    final locations = await locationFromAddress(address);
    if (locations.isEmpty) {
      throw GeolocationException('Location did not find by address');
    }
    return locations.first;
  }
}

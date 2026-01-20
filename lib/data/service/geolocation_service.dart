import 'package:geocoding/geocoding.dart';

class GeolocationService {
  static Future<Location> getLocationByAddress(String address) async {
    final locations = await locationFromAddress(address);
    if (locations.isEmpty) {
      throw Exception('Location did not find by address');
    }
    return locations.first;
  }
}

import 'package:geolocator/geolocator.dart';

abstract class LocationService {
  Future<Position> getCurrentLocation();
}

class LocationServiceImplementation implements LocationService {
  @override
  Future<Position> getCurrentLocation() async {
    final defaultLocation = Position(
      latitude: -13.0006552,
      longitude: -38.5114449,
      timestamp: DateTime.now(),
      accuracy: 0,
      altitude: 0,
      heading: 0,
      speed: 0,
      speedAccuracy: 0,
      altitudeAccuracy: 0,
      headingAccuracy: 0,
    );

    try {
      bool isLocationServiceEnabled =
          await Geolocator.isLocationServiceEnabled();

      if (!isLocationServiceEnabled) {
        return defaultLocation;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return defaultLocation;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        return defaultLocation;
      }

      return await Geolocator.getCurrentPosition();
    } catch (e) {
      return defaultLocation;
    }
  }
}

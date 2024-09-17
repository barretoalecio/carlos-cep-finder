import '../../domain/entities/location_entity.dart';

class LocationEntityMapper {
  static LocationEntity fromMap(Map<String, dynamic> map) {
    return LocationEntity(
      latitude: map['latitude'],
      longitude: map['longitude'],
    );
  }

  static Map<String, dynamic> toMap(LocationEntity entity) {
    return {
      'latitude': entity.latitude,
      'longitude': entity.longitude,
    };
  }
}

import 'package:equatable/equatable.dart';

class LocationEntity extends Equatable {
  const LocationEntity({
    required this.latitude,
    required this.longitude,
  });

  final double latitude;
  final double longitude;

  @override
  List<Object?> get props => [
        latitude,
        longitude,
      ];
}

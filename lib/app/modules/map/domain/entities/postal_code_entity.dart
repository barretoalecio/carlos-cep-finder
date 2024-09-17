import 'package:equatable/equatable.dart';

import 'location_entity.dart';

class PostalCodeEntity extends Equatable {
  const PostalCodeEntity({
    required this.postalCode,
    required this.state,
    required this.city,
    required this.neighborhood,
    required this.street,
    this.location,
  });

  final String postalCode;
  final String state;
  final String city;
  final String neighborhood;
  final String street;
  final LocationEntity? location;

  @override
  List<Object?> get props => [
        postalCode,
        state,
        city,
        neighborhood,
        street,
        location,
      ];
}

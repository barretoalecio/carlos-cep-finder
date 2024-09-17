import '../../../modules/map/domain/entities/postal_code_entity.dart';

extension PostalCodeExtension on PostalCodeEntity {
  String get formattedAddress {
    final parts = <String>[];

    if (street.isNotEmpty) {
      parts.add(street);
    }

    if (neighborhood.isNotEmpty) {
      if (parts.isNotEmpty) {
        parts.add(' - ');
      }
      parts.add(neighborhood);
    }

    if (city.isNotEmpty) {
      if (parts.isNotEmpty) {
        parts.add(', ');
      }
      parts.add(city);
    }

    if (state.isNotEmpty) {
      if (parts.isNotEmpty) {
        parts.add(' - ');
      }
      parts.add(state);
    }

    return parts.join();
  }
}

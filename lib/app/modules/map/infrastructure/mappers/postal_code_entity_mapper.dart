import '../../domain/entities/postal_code_entity.dart';
import 'location_entity_mapper.dart';

class PostalCodeEntityMapper {
  static PostalCodeEntity fromMap(Map<String, dynamic> map) {
    return PostalCodeEntity(
      postalCode: map['cep'],
      city: map['city'],
      neighborhood: map['neighborhood'],
      state: map['state'],
      street: map['street'],
      location: map['latlng'] != null
          ? LocationEntityMapper.fromMap(map['latlng'])
          : null,
    );
  }

  static Map<String, dynamic> toMap(PostalCodeEntity entity) {
    return {
      'cep': entity.postalCode,
      'city': entity.city,
      'neighborhood': entity.neighborhood,
      'state': entity.state,
      'street': entity.street,
      'latlng': entity.location != null
          ? LocationEntityMapper.toMap(entity.location!)
          : null,
    };
  }

  static PostalCodeEntity fromGoogleMap(Map<String, dynamic> map) {
    return PostalCodeEntity(
      postalCode: (map['structured_formatting']?['main_text'] ?? '')
          .replaceAll('-', ''),
      city: _getCityFromTerms(map['terms']),
      neighborhood: _getNeighborhoodFromTerms(map['terms']),
      state: _getStateFromTerms(map['terms']),
      street: _getStreetFromTerms(map['terms']),
      location: null,
    );
  }

  static String _getCityFromTerms(List<dynamic>? terms) {
    if (terms == null) return '';
    return terms.firstWhere(
          (term) => term['offset'] == 37,
          orElse: () => {'value': ''},
        )['value'] ??
        '';
  }

  static String _getNeighborhoodFromTerms(List<dynamic>? terms) {
    if (terms == null) return '';
    return terms.firstWhere(
          (term) => term['offset'] == 27,
          orElse: () => {'value': ''},
        )['value'] ??
        '';
  }

  static String _getStateFromTerms(List<dynamic>? terms) {
    if (terms == null) return '';
    return terms.firstWhere(
          (term) => term['offset'] == 48,
          orElse: () => {'value': ''},
        )['value'] ??
        '';
  }

  static String _getStreetFromTerms(List<dynamic>? terms) {
    if (terms == null) return '';
    return terms.firstWhere(
          (term) => term['offset'] == 0,
          orElse: () => {'value': ''},
        )['value'] ??
        '';
  }
}

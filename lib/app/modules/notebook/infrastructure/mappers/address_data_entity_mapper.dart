import '../../domain/entities/address_data_entity.dart';

class AddressDataEntityMapper {
  static AddressDataEntity fromMap(Map<String, dynamic> map) {
    return AddressDataEntity(
      code: map['code'],
      postalCode: map['postalCode'],
      complement: map['complement'],
      fullAddress: map['fullAddress'],
      number: map['number'],
      latitude: map['latitude'],
      longitude: map['longitude'],
    );
  }
}

import '../../domain/parameters/address_data_parameters.dart';

class AddressDataParametersMapper {
  static Map<String, dynamic> toMap(AddressDataParameters parameters) {
    return {
      'code': parameters.code,
      'postalCode': parameters.postalCode,
      'complement': parameters.complement,
      'number': parameters.number,
      'fullAddress': parameters.fullAddress,
      'latitude': parameters.latitude,
      'longitude': parameters.longitude,
    };
  }
}

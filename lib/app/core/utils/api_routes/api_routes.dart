// ignore_for_file: require_trailing_commas

import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../configuration/server_configuration.dart';

class APIRoutes {
  static const cep_service = '/cep';
  static const version = 'v1';

  static const place_service = '/place/autocomplete';
  static const geocoding_service = '/geocode';

  static String getPostalCodeData(String postalCode) {
    return '${ServerConfiguration().getBrasilAPI()}$cep_service/$version/$postalCode';
  }

  static String searchPostalCodes(String postalCode) {
    return '${ServerConfiguration().getGoogleMapsAPI()}$place_service/json?input=$postalCode&types=postal_code&components=country:br&key=${dotenv.get('GOOGLE_API_KEY')}';
  }

  static String getPostalCodePosition(
    Map<String, dynamic> decodedResponse,
  ) {
    String street = decodedResponse['street'] ?? '';
    String city = decodedResponse['city'] ?? '';
    String state = decodedResponse['state'] ?? '';
    String postalCode = (decodedResponse['cep'] ?? '').replaceAll('-', '');

    String address =
        '$street, $city, $state, $postalCode, Brasil'.replaceAll(' ', '+');

    return '${ServerConfiguration().getGoogleMapsAPI()}$geocoding_service/json?address=$address&key=${dotenv.get('GOOGLE_API_KEY')}';
  }
}

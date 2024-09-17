import 'dart:convert';

import '../../../../../core/packages/network/http_client/http_client.dart';
import '../../../../../core/shared/infrastructure/exceptions/server_exception.dart';
import '../../../../../core/utils/api_routes/api_routes.dart';
import '../../../domain/entities/postal_code_entity.dart';
import '../../../infrastructure/datasources/remote/map_remote_datasource.dart';
import '../../../infrastructure/exceptions/map_history_empty_data_exception.dart';
import '../../../infrastructure/mappers/postal_code_entity_mapper.dart';

class MapRemoteDatasourceImplementation implements MapRemoteDatasource {
  const MapRemoteDatasourceImplementation({
    required this.httpClient,
  });

  final HttpClient httpClient;

  @override
  Future<PostalCodeEntity> getPostalCodeEntity(
    String postalCode,
  ) async {
    try {
      final getPostalCodeDataEndpoint = APIRoutes.getPostalCodeData(postalCode);

      final result = await httpClient.get(getPostalCodeDataEndpoint);

      switch (result.statusCode) {
        case 200:
          {
            final decodedResponse = jsonDecode(result.data!);
            final getPostalCodeDataEndpoint =
                APIRoutes.getPostalCodePosition(decodedResponse);

            final postalCodeAddressResult =
                await httpClient.get(getPostalCodeDataEndpoint);

            List<dynamic> postalCodeAddressDecodedResponse = [];

            if (postalCodeAddressResult.data != null &&
                postalCodeAddressResult.data!.isNotEmpty) {
              postalCodeAddressDecodedResponse =
                  jsonDecode(postalCodeAddressResult.data!)['results'];
            }

            if (postalCodeAddressDecodedResponse.isNotEmpty) {
              final Map<String, dynamic> locationMap =
                  postalCodeAddressDecodedResponse.first['geometry']
                      ['location'];

              Map<String, dynamic> location = {
                'latlng': {
                  'latitude': locationMap['lat'],
                  'longitude': locationMap['lng'],
                },
              };
              decodedResponse.addAll(location);
            }

            final postalCodeEntity =
                PostalCodeEntityMapper.fromMap(decodedResponse);
            return postalCodeEntity;
          }
        default:
          throw ServerException(
            message: result.data,
            statusCode: result.statusCode!,
          );
      }
    } catch (exception) {
      rethrow;
    }
  }

  @override
  Future<List<PostalCodeEntity>> searchPostCodesEntity(
    String parameters,
  ) async {
    try {
      if (parameters.length == 8) {
        return [
          await getPostalCodeEntity(parameters),
        ];
      }
      final endpoint = APIRoutes.searchPostalCodes(parameters);

      final result = await httpClient.get(endpoint);

      switch (result.statusCode) {
        case 200:
          {
            final decodedResponse = jsonDecode(result.data!);

            final predictions =
                decodedResponse['predictions'] as List<dynamic>?;

            if (predictions == null || predictions.isEmpty) {
              throw const PostalCodesEmptyDataException();
            }

            List<PostalCodeEntity> postalCodesEntities = [];
            List<String> postalCodes = [];

            postalCodes.addAll(
              predictions
                  .map<String>(
                    (item) =>
                        (item['structured_formatting']?['main_text'] ?? '')
                            .replaceAll('-', ''),
                  )
                  .toList(),
            );

            postalCodes.removeWhere((item) => item.length != 8);

            for (final postalCode in postalCodes) {
              try {
                PostalCodeEntity postalCodeEntity =
                    await getPostalCodeEntity(postalCode);
                postalCodesEntities.add(postalCodeEntity);
              } catch (e) {
                continue;
              }
            }

            if (postalCodesEntities.isEmpty) {
              throw const PostalCodesEmptyDataException();
            }

            return postalCodesEntities;
          }
        default:
          throw ServerException(
            message: result.data,
            statusCode: result.statusCode!,
          );
      }
    } catch (exception) {
      rethrow;
    }
  }
}

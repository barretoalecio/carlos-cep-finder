import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:konsi_desafio_flutter/app/core/packages/network/http_client/http_client.dart';
import 'package:konsi_desafio_flutter/app/core/packages/network/http_client/http_response.dart';
import 'package:konsi_desafio_flutter/app/core/shared/infrastructure/exceptions/server_exception.dart';
import 'package:konsi_desafio_flutter/app/core/utils/api_routes/api_routes.dart';
import 'package:konsi_desafio_flutter/app/modules/map/external/datasources/remote/map_remote_datasource_implementation.dart';
import 'package:konsi_desafio_flutter/app/modules/map/infrastructure/datasources/remote/map_remote_datasource.dart';
import 'package:konsi_desafio_flutter/app/modules/map/infrastructure/exceptions/map_history_empty_data_exception.dart';
import 'package:konsi_desafio_flutter/app/modules/map/infrastructure/mappers/postal_code_entity_mapper.dart';
import 'package:mocktail/mocktail.dart';

class MockHttpClient extends Mock implements HttpClient {}

void main() {
  late MapRemoteDatasource datasource;
  late MockHttpClient mockHttpClient;

  setUpAll(() async {
    await dotenv.load();
  });

  setUp(() {
    mockHttpClient = MockHttpClient();
    datasource = MapRemoteDatasourceImplementation(httpClient: mockHttpClient);
  });

  const tPostalCode = '12345678';

  final tPostalCodeData = {
    'cep': tPostalCode,
    'city': 'Test City',
    'neighborhood': 'Test Neighborhood',
    'state': 'Test State',
    'street': 'Test Street',
    'latlng': {'latitude': 10.0, 'longitude': 20.0},
  };
  final tPostalCodeEntity = PostalCodeEntityMapper.fromMap(tPostalCodeData);

  group('getPostalCodeEntity', () {
    test('should be an instance of MapRemoteDatasource', () {
      expect(datasource, isA<MapRemoteDatasource>());
    });

    test(
        'should return PostalCodeEntity when the call to httpClient is successful',
        () async {
      // arrange
      final getPostalCodeDataEndpoint =
          APIRoutes.getPostalCodeData(tPostalCode);
      when(() => mockHttpClient.get(getPostalCodeDataEndpoint)).thenAnswer(
        (_) async => HttpResponse(
          statusCode: 200,
          data: jsonEncode(tPostalCodeData),
        ),
      );

      final getPostalCodePositionEndpoint =
          APIRoutes.getPostalCodePosition(tPostalCodeData);
      final tPostalCodeAddressResult = {
        'results': [
          {
            'geometry': {
              'location': {'lat': 10.0, 'lng': 20.0},
            },
          }
        ],
      };
      when(() => mockHttpClient.get(getPostalCodePositionEndpoint)).thenAnswer(
        (_) async => HttpResponse(
          statusCode: 200,
          data: jsonEncode(tPostalCodeAddressResult),
        ),
      );

      // act
      final result = await datasource.getPostalCodeEntity(tPostalCode);

      // assert
      expect(result, equals(tPostalCodeEntity));
      verify(() => mockHttpClient.get(getPostalCodeDataEndpoint)).called(1);
      verify(() => mockHttpClient.get(getPostalCodePositionEndpoint)).called(1);
    });

    test(
        'should throw ServerException when the call to httpClient is unsuccessful',
        () async {
      // arrange
      final getPostalCodeDataEndpoint =
          APIRoutes.getPostalCodeData(tPostalCode);
      when(() => mockHttpClient.get(getPostalCodeDataEndpoint)).thenAnswer(
        (_) async => const HttpResponse(
          statusCode: 404,
          data: 'Not Found',
        ),
      );

      // act
      final call = datasource.getPostalCodeEntity;

      // assert
      expect(() => call(tPostalCode), throwsA(isA<ServerException>()));
      verify(() => mockHttpClient.get(getPostalCodeDataEndpoint)).called(1);
    });
  });

  group('searchPostCodesEntity', () {
    test(
        'should return a list of PostalCodeEntity when the call to httpClient is successful',
        () async {
      // arrange
      const tParameters = '123';
      final endpoint = APIRoutes.searchPostalCodes(tParameters);
      final tPredictions = {
        'predictions': [
          {
            'structured_formatting': {'main_text': tPostalCode},
          },
        ],
      };
      when(() => mockHttpClient.get(endpoint)).thenAnswer(
        (_) async => HttpResponse(
          statusCode: 200,
          data: jsonEncode(tPredictions),
        ),
      );

      final getPostalCodeDataEndpoint =
          APIRoutes.getPostalCodeData(tPostalCode);
      when(() => mockHttpClient.get(getPostalCodeDataEndpoint)).thenAnswer(
        (_) async => HttpResponse(
          statusCode: 200,
          data: jsonEncode(tPostalCodeData),
        ),
      );

      final getPostalCodePositionEndpoint =
          APIRoutes.getPostalCodePosition(tPostalCodeData);
      final tPostalCodeAddressResult = {
        'results': [
          {
            'geometry': {
              'location': {'lat': 10.0, 'lng': 20.0},
            },
          }
        ],
      };
      when(() => mockHttpClient.get(getPostalCodePositionEndpoint)).thenAnswer(
        (_) async => HttpResponse(
          statusCode: 200,
          data: jsonEncode(tPostalCodeAddressResult),
        ),
      );

      // act
      final result = await datasource.searchPostCodesEntity(tParameters);

      // assert
      expect(result, equals([tPostalCodeEntity]));
      verify(() => mockHttpClient.get(endpoint)).called(1);
      verify(() => mockHttpClient.get(getPostalCodeDataEndpoint)).called(1);
      verify(() => mockHttpClient.get(getPostalCodePositionEndpoint)).called(1);
    });

    test(
        'should throw PostalCodesEmptyDataException when predictions list is empty',
        () async {
      // arrange
      const tParameters = '123';
      final endpoint = APIRoutes.searchPostalCodes(tParameters);
      when(() => mockHttpClient.get(endpoint)).thenAnswer(
        (_) async => HttpResponse(
          statusCode: 200,
          data: jsonEncode({'predictions': []}),
        ),
      );

      // act
      final call = datasource.searchPostCodesEntity;

      // assert
      expect(
        () => call(tParameters),
        throwsA(isA<PostalCodesEmptyDataException>()),
      );
      verify(() => mockHttpClient.get(endpoint)).called(1);
    });

    test(
        'should throw ServerException when the call to httpClient is unsuccessful',
        () async {
      // arrange
      const tParameters = '123';
      final endpoint = APIRoutes.searchPostalCodes(tParameters);
      when(() => mockHttpClient.get(endpoint)).thenAnswer(
        (_) async => const HttpResponse(
          statusCode: 404,
          data: 'Not Found',
        ),
      );

      // act
      final call = datasource.searchPostCodesEntity;

      // assert
      expect(() => call(tParameters), throwsA(isA<ServerException>()));
      verify(() => mockHttpClient.get(endpoint)).called(1);
    });
  });
}

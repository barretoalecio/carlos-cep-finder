import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:konsi_desafio_flutter/app/core/packages/cache/local_storage/local_storage_service.dart';
import 'package:konsi_desafio_flutter/app/core/utils/cache_keys/postal_codes_history_cache_keys.dart';
import 'package:konsi_desafio_flutter/app/modules/map/domain/entities/location_entity.dart';
import 'package:konsi_desafio_flutter/app/modules/map/domain/entities/postal_code_entity.dart';
import 'package:konsi_desafio_flutter/app/modules/map/external/datasources/local/map_local_datasource_implementation.dart';
import 'package:konsi_desafio_flutter/app/modules/map/infrastructure/datasources/local/map_local_datasource.dart';
import 'package:konsi_desafio_flutter/app/modules/map/infrastructure/exceptions/map_history_empty_data_exception.dart';
import 'package:konsi_desafio_flutter/app/modules/map/infrastructure/mappers/postal_code_entity_mapper.dart';
import 'package:mocktail/mocktail.dart';

class MockLocalStorageService extends Mock implements LocalStorageService {}

void main() {
  late MapLocalDatasourceImplementation datasource;
  late MockLocalStorageService mockLocalStorageService;

  setUp(() {
    mockLocalStorageService = MockLocalStorageService();
    datasource = MapLocalDatasourceImplementation(
      localStorageService: mockLocalStorageService,
    );
  });

  const tPostalCodeEntity = PostalCodeEntity(
    postalCode: '12345678',
    city: 'City',
    neighborhood: 'Neighborhood',
    state: 'State',
    street: 'Street',
    location: LocationEntity(
      latitude: 1.234,
      longitude: 5.678,
    ),
  );

  final tPostalCodesList = [tPostalCodeEntity];

  final tJson =
      jsonEncode(tPostalCodesList.map(PostalCodeEntityMapper.toMap).toList());

  group('getPostalCodesHistory', () {
    test('should be an instance of MapLocalDatasource', () {
      expect(datasource, isA<MapLocalDatasource>());
    });

    test(
        'should return a list of PostalCodeEntity when data is available and valid',
        () async {
      // arrange
      when(
        () => mockLocalStorageService.hasStoredDataInKey(
          key: PostalCodesHistoryCacheKeys.appCache,
        ),
      ).thenAnswer((_) async => true);

      when(
        () => mockLocalStorageService.getStoredData(
          key: PostalCodesHistoryCacheKeys.appCache,
        ),
      ).thenAnswer((_) async => tJson);

      // act
      final result = await datasource.getPostalCodesHistory();

      // assert
      expect(result, tPostalCodesList);
      verify(
        () => mockLocalStorageService.getStoredData(
          key: PostalCodesHistoryCacheKeys.appCache,
        ),
      ).called(1);
    });

    test('should throw PostalCodesEmptyDataException when result is null',
        () async {
      // arrange
      when(
        () => mockLocalStorageService.hasStoredDataInKey(
          key: PostalCodesHistoryCacheKeys.appCache,
        ),
      ).thenAnswer((_) async => true);

      when(
        () => mockLocalStorageService.getStoredData(
          key: PostalCodesHistoryCacheKeys.appCache,
        ),
      ).thenAnswer((_) async => null);

      // act
      final call = datasource.getPostalCodesHistory;

      // assert
      expect(() => call(), throwsA(isA<PostalCodesEmptyDataException>()));
    });

    test('should throw PostalCodesEmptyDataException when no data is stored',
        () async {
      // arrange
      when(
        () => mockLocalStorageService.hasStoredDataInKey(
          key: PostalCodesHistoryCacheKeys.appCache,
        ),
      ).thenAnswer((_) async => false);

      // act
      final call = datasource.getPostalCodesHistory;

      // assert
      expect(() => call(), throwsA(isA<PostalCodesEmptyDataException>()));
    });
  });

  group('savePostalCodeInHistory', () {
    test('should save postal code if it does not exist in history', () async {
      // arrange
      when(
        () => mockLocalStorageService.hasStoredDataInKey(
          key: PostalCodesHistoryCacheKeys.appCache,
        ),
      ).thenAnswer((_) async => true);

      final jsonWithoutPostalCode = json.encode([
        {
          'cep': '12345678',
          'city': 'City',
          'neighborhood': 'Neighborhood',
          'state': 'State',
          'street': 'Street',
        }
      ]);

      when(
        () => mockLocalStorageService.getStoredData(
          key: PostalCodesHistoryCacheKeys.appCache,
        ),
      ).thenAnswer((_) async => jsonWithoutPostalCode);

      // act
      await datasource.savePostalCodeInHistory(tPostalCodeEntity);

      // assert
      verify(
        () => mockLocalStorageService.getStoredData(
          key: PostalCodesHistoryCacheKeys.appCache,
        ),
      ).called(1);

      verifyNever(
        () => mockLocalStorageService.storeData(
          key: PostalCodesHistoryCacheKeys.appCache,
          value: any(named: 'value'),
        ),
      );
    });

    test('should not save postal code if it already exists in history',
        () async {
      // arrange
      final duplicateList = [tPostalCodeEntity];
      final tDuplicateJson =
          jsonEncode(duplicateList.map(PostalCodeEntityMapper.toMap).toList());

      when(
        () => mockLocalStorageService.hasStoredDataInKey(
          key: PostalCodesHistoryCacheKeys.appCache,
        ),
      ).thenAnswer((_) async => true);

      when(
        () => mockLocalStorageService.getStoredData(
          key: PostalCodesHistoryCacheKeys.appCache,
        ),
      ).thenAnswer((_) async => tDuplicateJson);

      // act
      await datasource.savePostalCodeInHistory(tPostalCodeEntity);

      // assert
      verifyNever(
        () => mockLocalStorageService.storeData(
          key: PostalCodesHistoryCacheKeys.appCache,
          value: any(named: 'value'),
        ),
      );
    });

    test(
        'should initialize history and save postal code when no history exists',
        () async {
      // arrange
      when(
        () => mockLocalStorageService.hasStoredDataInKey(
          key: PostalCodesHistoryCacheKeys.appCache,
        ),
      ).thenAnswer((_) async => false);

      when(
        () => mockLocalStorageService.storeData(
          key: PostalCodesHistoryCacheKeys.appCache,
          value: any(named: 'value'),
        ),
      ).thenAnswer((_) async => Future.value());

      // act
      await datasource.savePostalCodeInHistory(tPostalCodeEntity);

      // assert
      verify(
        () => mockLocalStorageService.storeData(
          key: PostalCodesHistoryCacheKeys.appCache,
          value: any(named: 'value'),
        ),
      ).called(1);
    });
  });
}

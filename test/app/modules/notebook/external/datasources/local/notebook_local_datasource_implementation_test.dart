import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:konsi_desafio_flutter/app/core/packages/cache/local_storage/local_storage_service.dart';
import 'package:konsi_desafio_flutter/app/core/utils/cache_keys/addresses_cache_keys.dart';
import 'package:konsi_desafio_flutter/app/modules/notebook/domain/entities/address_data_entity.dart';
import 'package:konsi_desafio_flutter/app/modules/notebook/domain/parameters/address_data_parameters.dart';
import 'package:konsi_desafio_flutter/app/modules/notebook/external/local/notebook_local_datasource_implementation.dart';
import 'package:konsi_desafio_flutter/app/modules/notebook/infrastructure/datasources/local/notebook_local_datasource.dart';
import 'package:konsi_desafio_flutter/app/modules/notebook/infrastructure/exceptions/address_already_existis_exception.dart';
import 'package:konsi_desafio_flutter/app/modules/notebook/infrastructure/exceptions/addresses_empty_data_exception.dart';
import 'package:mocktail/mocktail.dart';

class MockLocalStorageService extends Mock
    implements LocalStorageServiceImplementation {}

void main() {
  late NotebookLocalDatasourceImplementation datasource;
  late MockLocalStorageService mockLocalStorageService;

  setUp(() {
    mockLocalStorageService = MockLocalStorageService();
    datasource = NotebookLocalDatasourceImplementation(mockLocalStorageService);
  });

  final tJson = jsonEncode([
    {
      'code': 'code',
      'postalCode': 'postalCode',
      'fullAddress': 'fullAddress',
      'complement': 'complement',
      'number': 0,
      'latitude': 0.0,
      'longitude': 0.0,
    }
  ]);

  final tAddresses = [
    const AddressDataEntity(
      code: 'code',
      postalCode: 'postalCode',
      fullAddress: 'fullAddress',
      complement: 'complement',
      number: 0,
      latitude: 0.0,
      longitude: 0.0,
    ),
  ];

  final tAddressDataParameters = AddressDataParameters(
    postalCode: 'postalCode',
    fullAddress: 'fullAddress',
    complement: 'complement',
    number: 0,
    latitude: 0.0,
    longitude: 0.0,
  );

  setUpAll(() {
    registerFallbackValue(tJson);
    registerFallbackValue(tAddresses);
    registerFallbackValue(tAddressDataParameters);
  });

  group('getAddresses', () {
    test('should be an instance of NotebookLocalDatasource', () {
      expect(datasource, isA<NotebookLocalDatasource>());
    });

    test(
        'should return a list of AddressDataEntity when the data is available and valid',
        () async {
      // arrange
      when(() => mockLocalStorageService.getStoredData(key: any(named: 'key')))
          .thenAnswer((_) async => tJson);
      when(
        () =>
            mockLocalStorageService.hasStoredDataInKey(key: any(named: 'key')),
      ).thenAnswer((_) async => true);

      // act
      final result = await datasource.getAddresses('postalCode');

      // assert
      expect(result, tAddresses);
      verify(
        () => mockLocalStorageService.getStoredData(
          key: AddressesCacheKeys.appCache,
        ),
      ).called(1);
    });

    test('should throw AddressesEmptyDataException when result is null',
        () async {
      // arrange
      when(
        () => mockLocalStorageService.hasStoredDataInKey(
          key: any(named: 'key'),
        ),
      ).thenAnswer((_) async => true);

      when(() => mockLocalStorageService.getStoredData(key: any(named: 'key')))
          .thenAnswer((_) async => null);

      // act
      final call = datasource.getAddresses;

      // assert
      expect(
        () => call('postalCode'),
        throwsA(isA<AddressesEmptyDataException>()),
      );
    });

    test(
        'should throw AddressesEmptyDataException when no data matches the parameter',
        () async {
      // arrange
      when(
        () => mockLocalStorageService.hasStoredDataInKey(
          key: any(named: 'key'),
        ),
      ).thenAnswer((_) async => true);

      when(() => mockLocalStorageService.getStoredData(key: any(named: 'key')))
          .thenAnswer((_) async => tJson);

      // act
      final call = datasource.getAddresses;

      // assert
      expect(
        () => call('nonExistingPostalCode'),
        throwsA(isA<AddressesEmptyDataException>()),
      );
    });

    test(
        'should throw AddressesEmptyDataException when key does not have stored data',
        () async {
      // arrange
      when(
        () =>
            mockLocalStorageService.hasStoredDataInKey(key: any(named: 'key')),
      ).thenAnswer((_) async => false);

      // act
      final call = datasource.getAddresses;

      // assert
      expect(() => call(), throwsA(isA<AddressesEmptyDataException>()));
    });

    test(
        'should throw AddressesEmptyDataException when no data matches the parameter',
        () async {
      // arrange
      when(
        () => mockLocalStorageService.hasStoredDataInKey(
          key: any(named: 'key'),
        ),
      ).thenAnswer((_) async => true);
      when(
        () => mockLocalStorageService.getStoredData(
          key: any(named: 'key'),
        ),
      ).thenAnswer(
        (_) async => jsonEncode(
          [],
        ),
      );

      // act
      final call = datasource.getAddresses;

      // assert
      expect(
        () => call('nonExistingPostalCode'),
        throwsA(isA<AddressesEmptyDataException>()),
      );
    });
  });

  group('saveAddress', () {
    test(
        'should throw AddressAlreadyExistsException when the address already exists',
        () async {
      // arrange
      when(
        () => mockLocalStorageService.hasStoredDataInKey(
          key: any(named: 'key'),
        ),
      ).thenAnswer((_) async => true);
      when(() => mockLocalStorageService.getStoredData(key: any(named: 'key')))
          .thenAnswer(
        (_) async => tJson,
      );

      // act
      final call = datasource.saveAddress;

      // assert
      expect(
        () => call(tAddressDataParameters),
        throwsA(isA<AddressAlreadyExistsException>()),
      );
    });
  });

  group('deleteAddressByCode', () {
    const tCode = 'code';

    test('should remove address and store the updated list when address exists',
        () async {
      // arrange
      when(() => mockLocalStorageService.getStoredData(key: any(named: 'key')))
          .thenAnswer(
        (_) async => tJson,
      );

      when(
        () => mockLocalStorageService.deleteStoredData(
          key: AddressesCacheKeys.appCache,
        ),
      ).thenAnswer((_) async {});

      when(
        () => mockLocalStorageService.storeData(
          key: AddressesCacheKeys.appCache,
          value: jsonEncode(
            [],
          ),
        ),
      ).thenAnswer((_) async {});

      // act
      await datasource.deleteAddressByCode(tCode);

      // assert
      verify(
        () => mockLocalStorageService.getStoredData(
          key: AddressesCacheKeys.appCache,
        ),
      ).called(1);
      verify(
        () => mockLocalStorageService.deleteStoredData(
          key: AddressesCacheKeys.appCache,
        ),
      ).called(1);
      verify(
        () => mockLocalStorageService.storeData(
          key: AddressesCacheKeys.appCache,
          value: jsonEncode(
            [],
          ),
        ),
      ).called(1);
    });

    test(
        'should throw AddressesEmptyDataException when no addresses are stored',
        () async {
      // arrange
      when(() => mockLocalStorageService.getStoredData(key: any(named: 'key')))
          .thenThrow(const AddressesEmptyDataException());

      // act
      final call = datasource.deleteAddressByCode;

      // assert
      expect(() => call(tCode), throwsA(isA<AddressesEmptyDataException>()));
    });

    test('should throw exception when an unexpected error occurs', () async {
      // arrange
      when(() => mockLocalStorageService.getStoredData(key: any(named: 'key')))
          .thenAnswer((_) async => tJson);
      when(
        () => mockLocalStorageService.deleteStoredData(key: any(named: 'key')),
      ).thenThrow(Exception('Unexpected error'));

      // act
      final call = datasource.deleteAddressByCode;

      // assert
      expect(() => call(tCode), throwsA(isA<Exception>()));
    });
  });
}

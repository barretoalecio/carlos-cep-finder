import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:konsi_desafio_flutter/app/core/shared/domain/failures/empty_data_failure.dart';
import 'package:konsi_desafio_flutter/app/core/shared/domain/failures/failure.dart';
import 'package:konsi_desafio_flutter/app/modules/notebook/domain/entities/address_data_entity.dart';
import 'package:konsi_desafio_flutter/app/modules/notebook/domain/failures/address_already_exists_failure.dart';
import 'package:konsi_desafio_flutter/app/modules/notebook/domain/parameters/address_data_parameters.dart';
import 'package:konsi_desafio_flutter/app/modules/notebook/domain/repositories/notebook_repository.dart';
import 'package:konsi_desafio_flutter/app/modules/notebook/infrastructure/datasources/local/notebook_local_datasource.dart';
import 'package:konsi_desafio_flutter/app/modules/notebook/infrastructure/exceptions/address_already_existis_exception.dart';
import 'package:konsi_desafio_flutter/app/modules/notebook/infrastructure/exceptions/addresses_empty_data_exception.dart';
import 'package:konsi_desafio_flutter/app/modules/notebook/infrastructure/repositories/notebook_repository_implementation.dart';
import 'package:mocktail/mocktail.dart';

class MockNotebookLocalDatasource extends Mock
    implements NotebookLocalDatasource {}

void main() {
  late NotebookRepositoryImplementation repository;
  late MockNotebookLocalDatasource mockLocalDatasource;

  setUp(() {
    mockLocalDatasource = MockNotebookLocalDatasource();
    repository = NotebookRepositoryImplementation(mockLocalDatasource);
  });

  final tAddresses = <AddressDataEntity>[
    const AddressDataEntity(
      postalCode: 'postalCode',
      fullAddress: 'fullAddress',
      complement: 'complement',
      number: 0,
      latitude: 0.0,
      longitude: 0.0,
      code: 'code',
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
    registerFallbackValue(tAddresses);
    registerFallbackValue(tAddressDataParameters);
  });

  group('getAddresses', () {
    test('should be an instance of NotebookRepository', () {
      expect(repository, isA<NotebookRepository>());
    });

    test(
        'should return a list of AddressDataEntity when the datasource call is successful',
        () async {
      // arrange
      when(() => mockLocalDatasource.getAddresses(any()))
          .thenAnswer((_) async => tAddresses);

      // act
      final result = await repository.getAddresses('postalCode');

      // assert
      expect(result, Right(tAddresses));
      verify(() => mockLocalDatasource.getAddresses('postalCode')).called(1);
    });

    test(
        'should return EmptyDataFailure when the datasource throws AddressesEmptyDataException',
        () async {
      // arrange
      when(() => mockLocalDatasource.getAddresses(any()))
          .thenThrow(const AddressesEmptyDataException());

      // act
      final result = await repository.getAddresses('postalCode');

      // assert
      expect(result, const Left(EmptyDataFailure()));
      verify(() => mockLocalDatasource.getAddresses('postalCode')).called(1);
    });

    test(
        'should return Failure when the datasource throws an unexpected exception',
        () async {
      // arrange
      const exceptionMessage = 'Unexpected error';
      when(() => mockLocalDatasource.getAddresses(any()))
          .thenThrow(Exception(exceptionMessage));

      // act
      final result = await repository.getAddresses('postalCode');

      // assert
      expect(result, const Left(Failure('Exception: $exceptionMessage')));
      verify(() => mockLocalDatasource.getAddresses('postalCode')).called(1);
    });
  });

  group('saveAddress', () {
    test('should return unit when the datasource call is successful', () async {
      // arrange
      when(() => mockLocalDatasource.saveAddress(any())).thenAnswer(
        (_) async => unit,
      );

      // act
      final result = await repository.saveAddress(tAddressDataParameters);

      // assert
      expect(result, const Right(unit));
      verify(() => mockLocalDatasource.saveAddress(tAddressDataParameters))
          .called(1);
    });

    test(
        'should return AddressAlreadyExistsFailure when the datasource throws AddressAlreadyExistsException',
        () async {
      // arrange
      when(() => mockLocalDatasource.saveAddress(any()))
          .thenThrow(const AddressAlreadyExistsException());

      // act
      final result = await repository.saveAddress(tAddressDataParameters);

      // assert
      expect(result, const Left(AddressAlreadyExistsFailure()));
      verify(() => mockLocalDatasource.saveAddress(tAddressDataParameters))
          .called(1);
    });

    test(
        'should return Failure when the datasource throws an unexpected exception',
        () async {
      // arrange
      const exceptionMessage = 'Unexpected error';
      when(() => mockLocalDatasource.saveAddress(any()))
          .thenThrow(Exception(exceptionMessage));

      // act
      final result = await repository.saveAddress(tAddressDataParameters);

      // assert
      expect(result, const Left(Failure('Exception: $exceptionMessage')));
      verify(() => mockLocalDatasource.saveAddress(tAddressDataParameters))
          .called(1);
    });
  });

  group('deleteAddressByCode', () {
    const tCode = 'code';

    test('should return unit when the datasource call is successful', () async {
      // arrange
      when(() => mockLocalDatasource.deleteAddressByCode(any()))
          .thenAnswer((_) async => unit);
      // act
      final result = await repository.deleteAddressByCode(tCode);

      // assert
      expect(result, const Right(unit));
      verify(() => mockLocalDatasource.deleteAddressByCode(tCode)).called(1);
    });

    test(
        'should return Failure when the datasource throws an unexpected exception',
        () async {
      // arrange
      const exceptionMessage = 'Unexpected error';
      when(() => mockLocalDatasource.deleteAddressByCode(any()))
          .thenThrow(Exception(exceptionMessage));

      // act
      final result = await repository.deleteAddressByCode(tCode);

      // assert
      expect(
        result,
        const Left(
          Failure(
            'Exception: $exceptionMessage',
          ),
        ),
      );
      verify(() => mockLocalDatasource.deleteAddressByCode(tCode)).called(1);
    });
  });
}

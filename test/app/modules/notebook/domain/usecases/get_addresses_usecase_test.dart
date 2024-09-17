import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:konsi_desafio_flutter/app/core/shared/domain/usecases/async_usecase.dart';
import 'package:konsi_desafio_flutter/app/modules/notebook/domain/entities/address_data_entity.dart';
import 'package:konsi_desafio_flutter/app/modules/notebook/domain/failures/notebook_failure.dart';
import 'package:konsi_desafio_flutter/app/modules/notebook/domain/repositories/notebook_repository.dart';
import 'package:konsi_desafio_flutter/app/modules/notebook/domain/usecases/get_addresses_usecase.dart';
import 'package:mocktail/mocktail.dart';

class MockNotebookRepository extends Mock implements NotebookRepository {}

void main() {
  late GetAddressesUsecase usecase;
  late MockNotebookRepository mockRepository;

  setUp(() {
    mockRepository = MockNotebookRepository();
    usecase = GetAddressesUsecaseImplementation(mockRepository);
  });

  const tAddresses = <AddressDataEntity>[
    AddressDataEntity(
      postalCode: 'postalCode',
      fullAddress: 'fullAddress',
      complement: 'complement',
      number: 0,
      latitude: 0.0,
      longitude: 0.0,
      code: 'code',
    ),
  ];

  test('should be an instance of AsyncUsecase', () {
    expect(usecase, isA<AsyncUsecase>());
  });

  test(
      'should return List<AddressDataEntity> when repository call is successful',
      () async {
    // arrange
    when(() => mockRepository.getAddresses(any()))
        .thenAnswer((_) async => const Right(tAddresses));

    // act
    final result = await usecase(null);

    // assert
    expect(result, const Right(tAddresses));
    verify(() => mockRepository.getAddresses(null)).called(1);
  });

  test('should return NotebookFailure when repository throws an exception',
      () async {
    // arrange
    const exceptionMessage = 'Unexpected error';
    when(() => mockRepository.getAddresses(any()))
        .thenThrow(Exception(exceptionMessage));

    // act
    final result = await usecase(null);

    // assert
    expect(
      result,
      const Left(NotebookFailure('Exception: Unexpected error')),
    );
    verify(() => mockRepository.getAddresses(null)).called(1);
  });
}

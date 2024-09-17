import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:konsi_desafio_flutter/app/core/shared/domain/usecases/async_usecase.dart';
import 'package:konsi_desafio_flutter/app/modules/notebook/domain/failures/notebook_failure.dart';
import 'package:konsi_desafio_flutter/app/modules/notebook/domain/parameters/address_data_parameters.dart';
import 'package:konsi_desafio_flutter/app/modules/notebook/domain/repositories/notebook_repository.dart';
import 'package:konsi_desafio_flutter/app/modules/notebook/domain/usecases/save_address_usecase.dart';
import 'package:mocktail/mocktail.dart';

class MockNotebookRepository extends Mock implements NotebookRepository {}

void main() {
  late SaveAddressUsecase usecase;
  late MockNotebookRepository mockRepository;

  setUp(() {
    mockRepository = MockNotebookRepository();
    usecase = SaveAddressUsecaseImplementation(mockRepository);
  });

  final tParameters = AddressDataParameters(
    postalCode: 'postalCode',
    fullAddress: 'fullAddress',
    complement: 'complement',
    number: 0,
    latitude: 0.0,
    longitude: 0.0,
  );

  setUpAll(() {
    registerFallbackValue(tParameters);
  });

  test('should be an instance of AsyncUsecase', () {
    expect(usecase, isA<AsyncUsecase>());
  });

  test('should return void when repository call is successful', () async {
    // arrange
    when(() => mockRepository.saveAddress(any()))
        .thenAnswer((_) async => const Right(unit));

    // act
    final result = await usecase(tParameters);

    // assert
    expect(result, const Right(unit));
    verify(() => mockRepository.saveAddress(tParameters)).called(1);
  });

  test('should return NotebookFailure when repository throws an exception',
      () async {
    // arrange
    const exceptionMessage = 'Unexpected error';
    when(() => mockRepository.saveAddress(any()))
        .thenThrow(Exception(exceptionMessage));

    // act
    final result = await usecase(tParameters);

    // assert
    expect(
      result,
      const Left(NotebookFailure('Exception: Unexpected error')),
    );
    verify(() => mockRepository.saveAddress(tParameters)).called(1);
  });
}

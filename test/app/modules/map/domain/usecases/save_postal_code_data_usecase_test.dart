import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:konsi_desafio_flutter/app/core/shared/domain/usecases/async_usecase.dart';
import 'package:konsi_desafio_flutter/app/modules/map/domain/entities/postal_code_entity.dart';
import 'package:konsi_desafio_flutter/app/modules/map/domain/failures/map_failure.dart';
import 'package:konsi_desafio_flutter/app/modules/map/domain/repositories/map_repository.dart';
import 'package:konsi_desafio_flutter/app/modules/map/domain/usecases/save_postal_code_data_usecase.dart';
import 'package:mocktail/mocktail.dart';

class MockMapRepository extends Mock implements MapRepository {}

void main() {
  late SavePostalCodeDataUsecase savePostalCodeDataUsecase;
  late MockMapRepository mockRepository;

  setUp(() {
    mockRepository = MockMapRepository();
    savePostalCodeDataUsecase =
        SavePostalCodeDataUsecaseImplementation(mockRepository);
  });

  const tPostalCodeEntity = PostalCodeEntity(
    postalCode: '42701740',
    street: 'Street',
    city: 'City',
    state: 'State',
    neighborhood: 'neighborhood',
  );

  setUpAll(() {
    registerFallbackValue(tPostalCodeEntity);
  });

  test('should be an instance of AsyncUsecase', () {
    expect(savePostalCodeDataUsecase, isA<AsyncUsecase>());
  });

  test(
      'should call repository.savePostalCodeData when repository call is successful',
      () async {
    // arrange
    when(() => mockRepository.savePostalCodeData(any()))
        .thenAnswer((_) async => const Right(unit));

    // act
    final result = await savePostalCodeDataUsecase(tPostalCodeEntity);

    // assert
    expect(result, const Right(unit));
    verify(() => mockRepository.savePostalCodeData(tPostalCodeEntity))
        .called(1);
  });

  test('should return MapFailure when repository throws an exception',
      () async {
    // arrange
    const exceptionMessage = 'Unexpected error';
    when(() => mockRepository.savePostalCodeData(any()))
        .thenThrow(Exception(exceptionMessage));

    // act
    final result = await savePostalCodeDataUsecase(tPostalCodeEntity);

    // assert
    expect(
      result,
      const Left(MapFailure('Exception: $exceptionMessage')),
    );
    verify(() => mockRepository.savePostalCodeData(tPostalCodeEntity))
        .called(1);
  });
}

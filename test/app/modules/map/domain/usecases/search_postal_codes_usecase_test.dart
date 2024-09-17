import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:konsi_desafio_flutter/app/core/shared/domain/usecases/async_usecase.dart';
import 'package:konsi_desafio_flutter/app/modules/map/domain/entities/postal_code_entity.dart';
import 'package:konsi_desafio_flutter/app/modules/map/domain/failures/map_failure.dart';
import 'package:konsi_desafio_flutter/app/modules/map/domain/repositories/map_repository.dart';
import 'package:konsi_desafio_flutter/app/modules/map/domain/usecases/search_postal_codes_usecases.dart';
import 'package:mocktail/mocktail.dart';

class MockMapRepository extends Mock implements MapRepository {}

void main() {
  late SearchPostalCodesUsecase usecase;
  late MockMapRepository mockRepository;

  setUp(() {
    mockRepository = MockMapRepository();
    usecase =
        SearchPostalCodesUsecaseImplementation(repository: mockRepository);
  });

  const tPostalCodes = [
    PostalCodeEntity(
      postalCode: '42701740',
      street: 'Street',
      city: 'City',
      state: 'State',
      neighborhood: 'neighborhood',
    ),
    PostalCodeEntity(
      postalCode: '427011741',
      street: 'Street',
      city: 'City',
      state: 'State',
      neighborhood: 'neighborhood',
    ),
  ];

  const tPostalCode = '42701';

  test('should be an instance of AsyncUsecase', () {
    expect(usecase, isA<AsyncUsecase>());
  });

  test(
      'should return List<PostalCodeEntity> when repository call is successful',
      () async {
    // arrange
    when(() => mockRepository.searchPostalCodes(any()))
        .thenAnswer((_) async => const Right(tPostalCodes));

    // act
    final result = await usecase(tPostalCode);

    // assert
    expect(result, const Right(tPostalCodes));
    verify(() => mockRepository.searchPostalCodes(tPostalCode)).called(1);
  });

  test('should return MapFailure when repository throws an exception',
      () async {
    // arrange
    const exceptionMessage = 'Unexpected error';
    when(() => mockRepository.searchPostalCodes(any()))
        .thenThrow(Exception(exceptionMessage));

    // act
    final result = await usecase(tPostalCode);

    // assert
    expect(
      result,
      const Left(MapFailure('Exception: $exceptionMessage')),
    );
    verify(() => mockRepository.searchPostalCodes(tPostalCode)).called(1);
  });
}

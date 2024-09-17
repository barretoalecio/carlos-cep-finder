import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:konsi_desafio_flutter/app/core/shared/domain/usecases/async_usecase.dart';
import 'package:konsi_desafio_flutter/app/modules/notebook/domain/failures/notebook_failure.dart';
import 'package:konsi_desafio_flutter/app/modules/notebook/domain/repositories/notebook_repository.dart';
import 'package:konsi_desafio_flutter/app/modules/notebook/domain/usecases/delete_address_by_code_usecase.dart';
import 'package:mocktail/mocktail.dart';

class MockNotebookRepository extends Mock implements NotebookRepository {}

void main() {
  late DeleteAddressByCodeUsecase usecase;
  late MockNotebookRepository mockRepository;

  setUp(() {
    mockRepository = MockNotebookRepository();
    usecase = DeleteAddressByCodeUsecaseImplementation(mockRepository);
  });

  const tCode = 'code';

  test('should be an instance of AsyncUsecase', () {
    expect(usecase, isA<AsyncUsecase>());
  });

  test('should return void when repository call is successful', () async {
    // arrange
    when(() => mockRepository.deleteAddressByCode(any()))
        .thenAnswer((_) async => const Right(unit));

    // act
    final result = await usecase(tCode);

    // assert
    expect(result, const Right(unit));
    verify(() => mockRepository.deleteAddressByCode(tCode)).called(1);
  });

  test('should return NotebookFailure when repository throws an exception',
      () async {
    // arrange
    const exceptionMessage = 'Unexpected error';
    when(() => mockRepository.deleteAddressByCode(any()))
        .thenThrow(Exception(exceptionMessage));

    // act
    final result = await usecase(tCode);

    // assert
    expect(
      result,
      const Left(NotebookFailure('Exception: Unexpected error')),
    );
    verify(() => mockRepository.deleteAddressByCode(tCode)).called(1);
  });
}

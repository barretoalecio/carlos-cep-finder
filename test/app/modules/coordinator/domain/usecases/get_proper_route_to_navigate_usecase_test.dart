import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:konsi_desafio_flutter/app/core/shared/domain/parameters/zero_parameters.dart';
import 'package:konsi_desafio_flutter/app/core/shared/domain/usecases/async_usecase.dart';
import 'package:konsi_desafio_flutter/app/core/utils/app_routes/outlet_module_routes.dart';
import 'package:konsi_desafio_flutter/app/modules/coordinator/domain/entities/coordinator_result_entity.dart';
import 'package:konsi_desafio_flutter/app/modules/coordinator/domain/failures/coordinator_failure.dart';
import 'package:konsi_desafio_flutter/app/modules/coordinator/domain/repositories/coordinator_repository.dart';
import 'package:konsi_desafio_flutter/app/modules/coordinator/domain/usecases/get_proper_route_to_navigate_usecase.dart';
import 'package:mocktail/mocktail.dart';

class MockCoordinatorRepository extends Mock implements CoordinatorRepository {}

class FakeZeroParameters extends Fake implements ZeroParameters {}

void main() {
  late GetProperRouteToNavigateUsecase usecase;
  late MockCoordinatorRepository mockRepository;

  setUpAll(() {
    registerFallbackValue(FakeZeroParameters());
  });

  setUp(() {
    mockRepository = MockCoordinatorRepository();
    usecase = GetProperRouteToNavigateUsecaseImplementation(mockRepository);
  });

  const tZeroParameters = ZeroParameters();

  const tCoordinatorResultEntity = CoordinatorResultEntity(
    properRouteToNavigate:
        '${OutletModuleRoutes.moduleName}${OutletModuleRoutes.initialRoute}',
  );

  group('GetProperRouteToNavigateUseCase', () {
    test('should be an instance of AsyncUsecase', () {
      expect(usecase, isA<AsyncUsecase>());
    });

    test(
        'should return CoordinatorResultEntity when repository call is successful',
        () async {
      // arrange
      when(() => mockRepository.getProperRouteToNavigate())
          .thenAnswer((_) async => const Right(tCoordinatorResultEntity));

      // act
      final result = await usecase(tZeroParameters);

      // assert
      expect(result, const Right(tCoordinatorResultEntity));
      verify(() => mockRepository.getProperRouteToNavigate()).called(1);
    });

    test('should return CoordinatorFailure when repository throws an exception',
        () async {
      // arrange
      const exceptionMessage = 'Unexpected error';
      when(() => mockRepository.getProperRouteToNavigate())
          .thenThrow(Exception(exceptionMessage));

      // act
      final result = await usecase(tZeroParameters);

      // assert
      expect(
        result,
        const Left(CoordinatorFailure('Exception: Unexpected error')),
      );
      verify(() => mockRepository.getProperRouteToNavigate()).called(1);
    });
  });
}

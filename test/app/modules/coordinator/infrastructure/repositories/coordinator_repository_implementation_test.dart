import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';
import 'package:konsi_desafio_flutter/app/core/packages/location/location_service.dart';
import 'package:konsi_desafio_flutter/app/core/utils/app_routes/outlet_module_routes.dart';
import 'package:konsi_desafio_flutter/app/modules/coordinator/domain/entities/coordinator_result_entity.dart';
import 'package:konsi_desafio_flutter/app/modules/coordinator/domain/repositories/coordinator_repository.dart';
import 'package:konsi_desafio_flutter/app/modules/coordinator/infrastructure/exceptions/unable_to_ger_proper_route_to_navigate_exception.dart';
import 'package:konsi_desafio_flutter/app/modules/coordinator/infrastructure/repositories/coordinator_repository_implementation.dart';
import 'package:mocktail/mocktail.dart';

class MockCoordinatorRepositoryImplementation extends Mock
    implements CoordinatorRepositoryImplementation {}

class MockLocationService extends Mock
    implements LocationServiceImplementation {}

void main() {
  late CoordinatorRepositoryImplementation repository;
  late MockLocationService mockLocationService;

  setUp(() {
    mockLocationService = MockLocationService();
    repository = CoordinatorRepositoryImplementation(mockLocationService);
  });

  final tPosition = Position(
    latitude: 12.345678,
    longitude: 98.765432,
    timestamp: DateTime.now(),
    accuracy: 1.0,
    altitude: 0,
    heading: 0,
    speed: 0,
    speedAccuracy: 0,
    altitudeAccuracy: 0,
    headingAccuracy: 0,
  );

  group('CoordinatorRepository', () {
    test('should be an abstraction of CoordinatorRepository', () {
      expect(repository, isA<CoordinatorRepository>());
    });

    test('should return the proper route to navigate successfully', () async {
      // Arrange
      const expectedRoute =
          '${OutletModuleRoutes.moduleName}${OutletModuleRoutes.initialRoute}';
      const expectedResult = CoordinatorResultEntity(
        properRouteToNavigate: expectedRoute,
        arguments: {
          'index': 0,
          'latitude': 12.345678,
          'longitude': 98.765432,
        },
      );

      when(() => mockLocationService.getCurrentLocation())
          .thenAnswer((_) async => tPosition);

      // Act
      final result = await repository.getProperRouteToNavigate();

      // Assert
      expect(result, equals(const Right(expectedResult)));
    });

    test('should throw UnableToGetProperRouteToNavigateException on error',
        () async {
      // Arrange
      final mockRepository = MockCoordinatorRepositoryImplementation();
      when(() => mockRepository.getProperRouteToNavigate())
          .thenThrow(const UnableToGetProperRouteToNavigateException());

      // Act & Assert
      expect(
        () async => await mockRepository.getProperRouteToNavigate(),
        throwsA(isA<UnableToGetProperRouteToNavigateException>()),
      );
    });
  });
}

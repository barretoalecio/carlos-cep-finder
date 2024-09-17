import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:konsi_desafio_flutter/app/core/packages/network/network_status/network_status.dart';
import 'package:konsi_desafio_flutter/app/core/shared/domain/failures/empty_data_failure.dart';
import 'package:konsi_desafio_flutter/app/core/shared/domain/failures/failure.dart';
import 'package:konsi_desafio_flutter/app/core/shared/domain/failures/no_internet_connection_failure.dart';
import 'package:konsi_desafio_flutter/app/modules/map/domain/entities/postal_code_entity.dart';
import 'package:konsi_desafio_flutter/app/modules/map/domain/repositories/map_repository.dart';
import 'package:konsi_desafio_flutter/app/modules/map/infrastructure/datasources/local/map_local_datasource.dart';
import 'package:konsi_desafio_flutter/app/modules/map/infrastructure/datasources/remote/map_remote_datasource.dart';
import 'package:konsi_desafio_flutter/app/modules/map/infrastructure/exceptions/map_history_empty_data_exception.dart';
import 'package:konsi_desafio_flutter/app/modules/map/infrastructure/repositories/map_repository_implementation.dart';
import 'package:mocktail/mocktail.dart';

class MockMapRemoteDatasource extends Mock implements MapRemoteDatasource {}

class MockMapLocalDatasource extends Mock implements MapLocalDatasource {}

class MockNetworkService extends Mock implements NetworkService {}

void main() {
  late MapRepository repository;
  late MockMapRemoteDatasource mockRemoteDatasource;
  late MockMapLocalDatasource mockLocalDatasource;
  late MockNetworkService mockNetworkService;

  setUp(() {
    mockRemoteDatasource = MockMapRemoteDatasource();
    mockLocalDatasource = MockMapLocalDatasource();
    mockNetworkService = MockNetworkService();
    repository = MapRepositoryImplementation(
      remoteDatasource: mockRemoteDatasource,
      networkService: mockNetworkService,
      localDatasource: mockLocalDatasource,
    );
  });

  const tPostalCodeEntity = PostalCodeEntity(
    postalCode: '42701',
    street: 'Street',
    city: 'City',
    state: 'State',
    neighborhood: 'neighborhood',
  );

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

  const tPostalCode = '12345';

  setUpAll(() {
    registerFallbackValue(tPostalCodeEntity);
    registerFallbackValue(tPostalCodes);
  });

  group('getPostalCodeData', () {
    test('should be an instance of MapRepository', () {
      expect(repository, isA<MapRepository>());
    });

    group('searchPostalCodes', () {
      test(
          'should return List<PostalCodeEntity> when the remote datasource call is successful and network is active',
          () async {
        // arrange
        when(() => mockNetworkService.hasActiveNetwork)
            .thenAnswer((_) async => true);
        when(() => mockRemoteDatasource.searchPostCodesEntity(any()))
            .thenAnswer((_) async => tPostalCodes);

        // act
        final result = await repository.searchPostalCodes(tPostalCode);

        // assert
        expect(result, const Right(tPostalCodes));
        verify(() => mockNetworkService.hasActiveNetwork).called(1);
        verify(() => mockRemoteDatasource.searchPostCodesEntity(tPostalCode))
            .called(1);
      });

      test(
          'should return NoInternetConnectionFailure when there is no active network',
          () async {
        // arrange
        when(() => mockNetworkService.hasActiveNetwork)
            .thenAnswer((_) async => false);

        // act
        final result = await repository.searchPostalCodes(tPostalCode);

        // assert
        expect(result, const Left(NoInternetConnectionFailure()));
        verify(() => mockNetworkService.hasActiveNetwork).called(1);
        verifyNever(() => mockRemoteDatasource.searchPostCodesEntity(any()));
      });

      test(
          'should return EmptyDataFailure when the remote datasource throws PostalCodesEmptyDataException',
          () async {
        // arrange
        when(() => mockNetworkService.hasActiveNetwork)
            .thenAnswer((_) async => true);
        when(() => mockRemoteDatasource.searchPostCodesEntity(any()))
            .thenThrow(const PostalCodesEmptyDataException());

        // act
        final result = await repository.searchPostalCodes(tPostalCode);

        // assert
        expect(result, const Left(EmptyDataFailure()));
        verify(() => mockNetworkService.hasActiveNetwork).called(1);
        verify(() => mockRemoteDatasource.searchPostCodesEntity(tPostalCode))
            .called(1);
      });

      test(
          'should return Failure when the remote datasource throws an unexpected exception',
          () async {
        // arrange
        const exceptionMessage = 'Unexpected error';
        when(() => mockNetworkService.hasActiveNetwork)
            .thenAnswer((_) async => true);
        when(() => mockRemoteDatasource.searchPostCodesEntity(any()))
            .thenThrow(Exception(exceptionMessage));

        // act
        final result = await repository.searchPostalCodes(tPostalCode);

        // assert
        expect(result, const Left(Failure('Exception: $exceptionMessage')));
        verify(() => mockNetworkService.hasActiveNetwork).called(1);
        verify(() => mockRemoteDatasource.searchPostCodesEntity(tPostalCode))
            .called(1);
      });
    });
  });
}

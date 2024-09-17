import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:konsi_desafio_flutter/app/core/shared/domain/failures/empty_data_failure.dart';
import 'package:konsi_desafio_flutter/app/core/shared/domain/failures/no_internet_connection_failure.dart';
import 'package:konsi_desafio_flutter/app/core/shared/presentation/controllers/states/abstractions/app_state.dart';
import 'package:konsi_desafio_flutter/app/core/shared/presentation/controllers/states/global_states/empty_data_state.dart';
import 'package:konsi_desafio_flutter/app/core/shared/presentation/controllers/states/global_states/idle_state.dart';
import 'package:konsi_desafio_flutter/app/core/shared/presentation/controllers/states/global_states/no_internet_connection_state.dart';
import 'package:konsi_desafio_flutter/app/modules/map/domain/entities/location_entity.dart';
import 'package:konsi_desafio_flutter/app/modules/map/domain/entities/postal_code_entity.dart';
import 'package:konsi_desafio_flutter/app/modules/map/domain/usecases/save_postal_code_data_usecase.dart';
import 'package:konsi_desafio_flutter/app/modules/map/domain/usecases/search_postal_codes_usecases.dart';
import 'package:konsi_desafio_flutter/app/modules/map/presentation/controllers/blocs/postal_code_bloc.dart';
import 'package:konsi_desafio_flutter/app/modules/map/presentation/controllers/events/save_postal_code_history_event.dart';
import 'package:konsi_desafio_flutter/app/modules/map/presentation/controllers/events/search_postal_codes_event.dart';
import 'package:konsi_desafio_flutter/app/modules/map/presentation/controllers/states/loading_postal_codes_state.dart';
import 'package:konsi_desafio_flutter/app/modules/map/presentation/controllers/states/saving_postal_code_state.dart';
import 'package:konsi_desafio_flutter/app/modules/map/presentation/controllers/states/successfully_got_postal_codes_state.dart';
import 'package:konsi_desafio_flutter/app/modules/map/presentation/controllers/states/successfully_saved_postal_code_state.dart';
import 'package:mocktail/mocktail.dart';

class MockSearchPostalCodesUsecase extends Mock
    implements SearchPostalCodesUsecase {}

class MockSavePostalCodeDataUsecase extends Mock
    implements SavePostalCodeDataUsecase {}

void main() {
  late PostalCodeBloc bloc;
  late MockSearchPostalCodesUsecase mockSearchPostalCodesUsecase;
  late MockSavePostalCodeDataUsecase mockSavePostalCodeDataUsecase;

  setUp(() {
    mockSearchPostalCodesUsecase = MockSearchPostalCodesUsecase();
    mockSavePostalCodeDataUsecase = MockSavePostalCodeDataUsecase();
    bloc = PostalCodeBloc(
      mockSearchPostalCodesUsecase,
      mockSavePostalCodeDataUsecase,
    );
  });

  tearDown(() {
    bloc.close();
  });

  const tPostalCode = '12345';

  const tPostalCodeEntity = PostalCodeEntity(
    postalCode: '12345678',
    city: 'City',
    neighborhood: 'Neighborhood',
    state: 'State',
    street: 'Street',
    location: LocationEntity(
      latitude: 0.0,
      longitude: 0.0,
    ),
  );

  const tPostalCodes = [tPostalCodeEntity];

  setUpAll(() {
    registerFallbackValue(tPostalCodeEntity);
    registerFallbackValue(tPostalCodes);
  });

  group('PostalCodeBloc', () {
    test('should be an instance of Bloc', () {
      expect(bloc, isA<Bloc>());
    });

    test('initial state is IdleState', () {
      expect(bloc.state, equals(IdleState()));
    });

    blocTest<PostalCodeBloc, AppState>(
      'emits [LoadingPostalCodesState, SuccessfullyGotPostalCodesState] when SearchPostalCodesEvent is added and succeeds',
      build: () {
        when(() => mockSearchPostalCodesUsecase(any())).thenAnswer(
          (_) async => const Right(tPostalCodes),
        );
        return bloc;
      },
      act: (bloc) =>
          bloc.add(const SearchPostalCodesEvent(postalCode: tPostalCode)),
      expect: () => [
        const LoadingPostalCodesState(),
        const SuccessfullyGotPostalCodesState(postalCodes: tPostalCodes),
      ],
    );

    blocTest<PostalCodeBloc, AppState>(
      'emits [LoadingPostalCodesState, NoInternetConnectionState] when SearchPostalCodesEvent is added and fails with NoInternetConnectionFailure',
      build: () {
        when(() => mockSearchPostalCodesUsecase(any())).thenAnswer(
          (_) async => const Left(NoInternetConnectionFailure()),
        );
        return bloc;
      },
      act: (bloc) =>
          bloc.add(const SearchPostalCodesEvent(postalCode: tPostalCode)),
      expect: () => [
        const LoadingPostalCodesState(),
        NoInternetConnectionState(),
      ],
    );

    blocTest<PostalCodeBloc, AppState>(
      'emits [LoadingPostalCodesState, EmptyDataState] when SearchPostalCodesEvent is added and fails with EmptyDataFailure',
      build: () {
        when(() => mockSearchPostalCodesUsecase(any())).thenAnswer(
          (_) async => const Left(EmptyDataFailure()),
        );
        return bloc;
      },
      act: (bloc) =>
          bloc.add(const SearchPostalCodesEvent(postalCode: tPostalCode)),
      expect: () => [
        const LoadingPostalCodesState(),
        EmptyDataState(),
      ],
    );

    blocTest<PostalCodeBloc, AppState>(
      'emits [SavingPostalCodeState, SuccessfullySavedPostalCodeState] when SavePostalCodeHistoryEvent is added and succeeds',
      build: () {
        when(() => mockSavePostalCodeDataUsecase(any())).thenAnswer(
          (_) async => const Right(()),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(
        const SavePostalCodeHistoryEvent(
          postalCodeEntity: tPostalCodeEntity,
        ),
      ),
      expect: () => [
        SavingPostalCodeState(),
        const SuccessfullySavedPostalCodeState(
          postalCodeEntity: tPostalCodeEntity,
        ),
      ],
    );

    blocTest<PostalCodeBloc, AppState>(
      'emits [SavingPostalCodeState, NoInternetConnectionState] when SavePostalCodeHistoryEvent is added and fails with NoInternetConnectionFailure',
      build: () {
        when(() => mockSavePostalCodeDataUsecase(any())).thenAnswer(
          (_) async => const Left(NoInternetConnectionFailure()),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(
        const SavePostalCodeHistoryEvent(
          postalCodeEntity: tPostalCodeEntity,
        ),
      ),
      expect: () => [
        SavingPostalCodeState(),
        NoInternetConnectionState(),
      ],
    );

    blocTest<PostalCodeBloc, AppState>(
      'emits [SavingPostalCodeState, EmptyDataState] when SavePostalCodeHistoryEvent is added and fails with EmptyDataFailure',
      build: () {
        when(() => mockSavePostalCodeDataUsecase(any())).thenAnswer(
          (_) async => const Left(EmptyDataFailure()),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(
        const SavePostalCodeHistoryEvent(
          postalCodeEntity: tPostalCodeEntity,
        ),
      ),
      expect: () => [
        SavingPostalCodeState(),
        EmptyDataState(),
      ],
    );
  });
}

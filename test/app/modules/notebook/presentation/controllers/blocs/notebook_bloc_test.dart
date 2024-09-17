import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:konsi_desafio_flutter/app/core/shared/domain/failures/empty_data_failure.dart';
import 'package:konsi_desafio_flutter/app/core/shared/domain/failures/failure.dart';
import 'package:konsi_desafio_flutter/app/core/shared/presentation/controllers/states/abstractions/app_state.dart';
import 'package:konsi_desafio_flutter/app/core/shared/presentation/controllers/states/global_states/empty_data_state.dart';
import 'package:konsi_desafio_flutter/app/core/shared/presentation/controllers/states/global_states/idle_state.dart';
import 'package:konsi_desafio_flutter/app/modules/notebook/domain/entities/address_data_entity.dart';
import 'package:konsi_desafio_flutter/app/modules/notebook/domain/failures/address_already_exists_failure.dart';
import 'package:konsi_desafio_flutter/app/modules/notebook/domain/parameters/address_data_parameters.dart';
import 'package:konsi_desafio_flutter/app/modules/notebook/domain/usecases/delete_address_by_code_usecase.dart';
import 'package:konsi_desafio_flutter/app/modules/notebook/domain/usecases/get_addresses_usecase.dart';
import 'package:konsi_desafio_flutter/app/modules/notebook/domain/usecases/save_address_usecase.dart';
import 'package:konsi_desafio_flutter/app/modules/notebook/presentation/controllers/blocs/notebook_bloc.dart';
import 'package:konsi_desafio_flutter/app/modules/notebook/presentation/controllers/events/delete_address_by_code_event.dart';
import 'package:konsi_desafio_flutter/app/modules/notebook/presentation/controllers/events/get_addresses_event.dart';
import 'package:konsi_desafio_flutter/app/modules/notebook/presentation/controllers/events/save_address_event.dart';
import 'package:konsi_desafio_flutter/app/modules/notebook/presentation/controllers/states/address_already_exists_state.dart';
import 'package:konsi_desafio_flutter/app/modules/notebook/presentation/controllers/states/loading_addresses_state.dart';
import 'package:konsi_desafio_flutter/app/modules/notebook/presentation/controllers/states/saving_address_state.dart';
import 'package:konsi_desafio_flutter/app/modules/notebook/presentation/controllers/states/successfully_delted_address_state.dart';
import 'package:konsi_desafio_flutter/app/modules/notebook/presentation/controllers/states/successfully_got_addresses_state.dart';
import 'package:konsi_desafio_flutter/app/modules/notebook/presentation/controllers/states/successfully_saved_address_state.dart';
import 'package:konsi_desafio_flutter/app/modules/notebook/presentation/controllers/states/unable_to_delete_address_state.dart';
import 'package:mocktail/mocktail.dart';

class MockGetAddressesUsecase extends Mock implements GetAddressesUsecase {}

class MockSaveAddressUsecase extends Mock implements SaveAddressUsecase {}

class MockDeleteAddressByCodeUsecase extends Mock
    implements DeleteAddressByCodeUsecase {}

void main() {
  late NotebookBloc bloc;
  late MockGetAddressesUsecase mockGetAddressesUsecase;
  late MockSaveAddressUsecase mockSaveAddressUsecase;
  late MockDeleteAddressByCodeUsecase mockDeleteAddressByCodeUsecase;

  setUp(() {
    mockGetAddressesUsecase = MockGetAddressesUsecase();
    mockSaveAddressUsecase = MockSaveAddressUsecase();
    mockDeleteAddressByCodeUsecase = MockDeleteAddressByCodeUsecase();
    bloc = NotebookBloc(
      mockSaveAddressUsecase,
      mockGetAddressesUsecase,
      mockDeleteAddressByCodeUsecase,
    );
  });

  tearDown(() {
    bloc.close();
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

  final tAddressParameters = AddressDataParameters(
    postalCode: 'postalCode',
    fullAddress: 'fullAddress',
    complement: 'complement',
    number: 0,
    latitude: 0.0,
    longitude: 0.0,
    code: 'code',
  );

  setUpAll(() {
    registerFallbackValue(tAddresses);
    registerFallbackValue(tAddressParameters);
  });

  group('NotebookBloc', () {
    test('should be an instance of Bloc', () {
      expect(bloc, isA<Bloc>());
    });

    test('initial state is IdleState', () {
      expect(bloc.state, equals(IdleState()));
    });

    blocTest<NotebookBloc, AppState>(
      'emits [LoadingAddressesState, SuccessfullyGotAddressesState] when GetAddressesEvent is added and succeeds',
      build: () {
        when(() => mockGetAddressesUsecase(any())).thenAnswer(
          (_) async => const Right(tAddresses),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(const GetAddressesEvent(postalCode: '12345')),
      expect: () => [
        LoadingAddressesState(),
        const SuccessfullyGotAddressesState(addresses: tAddresses),
      ],
    );

    blocTest<NotebookBloc, AppState>(
      'emits [LoadingAddressesState, EmptyDataState] when GetAddressesEvent is added and fails with EmptyDataFailure',
      build: () {
        when(() => mockGetAddressesUsecase(any())).thenAnswer(
          (_) async => const Left(EmptyDataFailure()),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(const GetAddressesEvent(postalCode: '12345')),
      expect: () => [
        LoadingAddressesState(),
        EmptyDataState(),
      ],
    );

    blocTest<NotebookBloc, AppState>(
      'emits [SavingAddressState, SuccessfullySavedAddressState] when SaveAddressEvent is added and succeeds',
      build: () {
        when(() => mockSaveAddressUsecase(any())).thenAnswer(
          (_) async => const Right(()),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(SaveAddressEvent(parameters: tAddressParameters)),
      expect: () => [
        SavingAddressState(),
        SuccessfullySavedAddressState(),
      ],
    );

    blocTest<NotebookBloc, AppState>(
      'emits [SavingAddressState, AddressAlreadyExistsState] when SaveAddressEvent is added and fails with AddressAlreadyExistsFailure',
      build: () {
        when(() => mockSaveAddressUsecase(any())).thenAnswer(
          (_) async => const Left(AddressAlreadyExistsFailure()),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(SaveAddressEvent(parameters: tAddressParameters)),
      expect: () => [
        SavingAddressState(),
        AddressAlreadyExistsState(),
      ],
    );

    blocTest<NotebookBloc, AppState>(
      'emits [SavingAddressState, SuccessfullyDeletedAddressState] when DeleteAddressByCodeEvent is added and succeeds',
      build: () {
        when(() => mockDeleteAddressByCodeUsecase(any())).thenAnswer(
          (_) async => const Right(()),
        );
        return bloc;
      },
      act: (bloc) =>
          bloc.add(const DeleteAddressByCodeEvent(parameters: 'code')),
      expect: () => [
        SavingAddressState(),
        SuccessfullyDeletedAddressState(),
      ],
    );

    blocTest<NotebookBloc, AppState>(
      'emits [SavingAddressState, UnableToDeleteAddressState] when DeleteAddressByCodeEvent is added and fails',
      build: () {
        when(() => mockDeleteAddressByCodeUsecase(any())).thenAnswer(
          (_) async => const Left(Failure()),
        );
        return bloc;
      },
      act: (bloc) =>
          bloc.add(const DeleteAddressByCodeEvent(parameters: 'code')),
      expect: () => [
        SavingAddressState(),
        UnableToDeleteAddressState(),
      ],
    );
  });
}

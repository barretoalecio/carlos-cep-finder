import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:konsi_desafio_flutter/app/core/shared/domain/parameters/zero_parameters.dart';
import 'package:konsi_desafio_flutter/app/core/shared/presentation/controllers/states/abstractions/app_state.dart';
import 'package:konsi_desafio_flutter/app/core/shared/presentation/controllers/states/global_states/idle_state.dart';
import 'package:konsi_desafio_flutter/app/core/utils/app_routes/outlet_module_routes.dart';
import 'package:konsi_desafio_flutter/app/modules/coordinator/domain/entities/coordinator_result_entity.dart';
import 'package:konsi_desafio_flutter/app/modules/coordinator/domain/failures/unable_to_get_proper_route_to_navigate_failure.dart';
import 'package:konsi_desafio_flutter/app/modules/coordinator/domain/usecases/get_proper_route_to_navigate_usecase.dart';
import 'package:konsi_desafio_flutter/app/modules/coordinator/presentation/controllers/blocs/coordinator_bloc.dart';
import 'package:konsi_desafio_flutter/app/modules/coordinator/presentation/controllers/events/get_proper_route_to_navigate_event.dart';
import 'package:konsi_desafio_flutter/app/modules/coordinator/presentation/controllers/states/getting_proper_route_to_navigate_state.dart';
import 'package:konsi_desafio_flutter/app/modules/coordinator/presentation/controllers/states/successfully_got_proper_route_to_navigate_state.dart';
import 'package:konsi_desafio_flutter/app/modules/coordinator/presentation/controllers/states/unable_to_get_proper_route_to_navigate_state.dart';
import 'package:mocktail/mocktail.dart';

class MockGetProperRouteToNavigateUsecase extends Mock
    implements GetProperRouteToNavigateUsecase {}

void main() {
  late CoordinatorBloc bloc;
  late MockGetProperRouteToNavigateUsecase mockUsecase;

  setUp(() {
    mockUsecase = MockGetProperRouteToNavigateUsecase();
    bloc = CoordinatorBloc(mockUsecase);
  });

  tearDown(() {
    bloc.dispose();
  });

  group('CoordinatorBloc', () {
    test('Should be an abstraction of Bloc', () {
      expect(bloc, isA<Bloc>());
    });

    blocTest<CoordinatorBloc, AppState>(
      'initial state should be IdleState',
      build: () => CoordinatorBloc(mockUsecase),
      verify: (bloc) => expect(bloc.state, IdleState()),
    );

    blocTest<CoordinatorBloc, AppState>(
      'should emit [GettingProperRouteToNavigateState, SuccessfullyGotProperRouteToNavigateState] on success',
      build: () {
        const expectedRoute =
            '${OutletModuleRoutes.moduleName}${OutletModuleRoutes.initialRoute}';
        const expectedResult = CoordinatorResultEntity(
          properRouteToNavigate: expectedRoute,
          arguments: {'index': 0},
        );
        when(() => mockUsecase(const ZeroParameters()))
            .thenAnswer((_) async => const Right(expectedResult));
        return CoordinatorBloc(mockUsecase);
      },
      act: (bloc) => bloc.add(const GetProperRouteToNavigateEvent()),
      expect: () => [
        GettingProperRouteToNavigateState(),
        const SuccessfullyGotProperRouteToNavigateState(
          CoordinatorResultEntity(
            properRouteToNavigate:
                '${OutletModuleRoutes.moduleName}${OutletModuleRoutes.initialRoute}',
            arguments: {'index': 0},
          ),
        ),
      ],
    );

    blocTest<CoordinatorBloc, AppState>(
      'should emit [GettingProperRouteToNavigateState, UnableToGetProperRouteToNavigateState] on failure',
      build: () {
        when(() => mockUsecase(const ZeroParameters())).thenAnswer(
          (_) async => const Left(UnableToGetProperRouteToNavigateFailure()),
        );
        return CoordinatorBloc(mockUsecase);
      },
      act: (bloc) => bloc.add(const GetProperRouteToNavigateEvent()),
      expect: () => [
        GettingProperRouteToNavigateState(),
        UnableToGetProperRouteToNavigateState(),
      ],
    );
  });
}

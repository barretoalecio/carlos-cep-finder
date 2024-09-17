import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:konsi_desafio_flutter/app/core/shared/presentation/controllers/states/abstractions/app_state.dart';
import 'package:konsi_desafio_flutter/app/core/shared/presentation/controllers/states/global_states/idle_state.dart';
import 'package:konsi_desafio_flutter/app/modules/outlet/presentation/controllers/blocs/location_bloc.dart';
import 'package:konsi_desafio_flutter/app/modules/outlet/presentation/controllers/events/get_current_location_event.dart';
import 'package:konsi_desafio_flutter/app/modules/outlet/presentation/controllers/states/loading_location_state.dart';
import 'package:konsi_desafio_flutter/app/modules/outlet/presentation/controllers/states/successfully_got_location_state.dart';

void main() {
  late LocationBloc bloc;

  setUp(() {
    bloc = LocationBloc();
  });

  tearDown(() {
    bloc.dispose();
  });

  group('LocationBloc', () {
    test('Should be an abstraction of Bloc', () {
      expect(bloc, isA<Bloc>());
    });

    test('initial state should be IdleState', () {
      expect(bloc.state, IdleState());
    });

    blocTest<LocationBloc, AppState>(
      'emits [LoadingLocationState, SuccessfullyGotLocationState] when GetCurrentLocationEvent is added',
      build: () => bloc,
      act: (bloc) => bloc.add(
        const GetCurrentLocationEvent(latitude: 0.0, longitude: 0.0),
      ),
      expect: () => [
        LoadingLocationState(),
        SuccessfullyGotLocationState(),
      ],
    );

    blocTest<LocationBloc, AppState>(
      'updates latitude and longitude when GetCurrentLocationEvent is added',
      build: () => bloc,
      act: (bloc) {
        bloc.add(
          const GetCurrentLocationEvent(
            latitude: 37.7749,
            longitude: -122.4194,
          ),
        );
      },
      expect: () => [
        LoadingLocationState(),
        SuccessfullyGotLocationState(),
      ],
      verify: (_) {
        expect(bloc.latitude, 37.7749);
        expect(bloc.longitude, -122.4194);
      },
    );
  });
}

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:konsi_desafio_flutter/app/core/shared/presentation/controllers/states/abstractions/app_state.dart';
import 'package:konsi_desafio_flutter/app/core/shared/presentation/controllers/states/global_states/idle_state.dart';
import 'package:konsi_desafio_flutter/app/modules/map/domain/entities/location_entity.dart';
import 'package:konsi_desafio_flutter/app/modules/map/domain/entities/postal_code_entity.dart';
import 'package:konsi_desafio_flutter/app/modules/map/presentation/controllers/blocs/map_control_bloc.dart';
import 'package:konsi_desafio_flutter/app/modules/map/presentation/controllers/events/add_marker_event.dart';
import 'package:konsi_desafio_flutter/app/modules/map/presentation/controllers/events/clear_marker_event.dart';
import 'package:konsi_desafio_flutter/app/modules/map/presentation/controllers/states/adding_marker_state.dart';
import 'package:konsi_desafio_flutter/app/modules/map/presentation/controllers/states/successfully_added_marker_state.dart';
import 'package:konsi_desafio_flutter/app/modules/map/presentation/controllers/states/successfully_cleared_marker_state.dart';

void main() {
  late MapControlBloc bloc;

  setUp(() {
    bloc = MapControlBloc();
  });

  tearDown(() {
    bloc.close();
  });

  const tMarker = Marker(
    markerId: MarkerId('_'),
    position: LatLng(0.0, 0.0),
    icon: BitmapDescriptor.defaultMarker,
  );

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

  group('MapControlBloc', () {
    test('should be an instance of Bloc', () {
      expect(bloc, isA<Bloc>());
    });

    test('initial state is IdleState', () {
      expect(bloc.state, equals(IdleState()));
    });

    blocTest<MapControlBloc, AppState>(
      'emits [AddingMarkerState, SuccessfullyAddedMarkerState] when AddMarkerEvent is added',
      build: () {
        return bloc;
      },
      act: (bloc) =>
          bloc.add(const AddMarkerEvent(postalCodeEntity: tPostalCodeEntity)),
      expect: () => [
        AddingMarkerState(),
        const SuccessfullyAddedMarkerState(
          marker: tMarker,
          postalCodeEntity: tPostalCodeEntity,
        ),
      ],
    );

    blocTest<MapControlBloc, AppState>(
      'emits [SuccessfullyClearedMarkerState] when ClearMarkerEvent is added',
      build: () {
        return bloc;
      },
      act: (bloc) => bloc.add(const ClearMarkerEvent()),
      expect: () => [
        SuccessfullyClearedMarkerState(),
      ],
    );
  });
}

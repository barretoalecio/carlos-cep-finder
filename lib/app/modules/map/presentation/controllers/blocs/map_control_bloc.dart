import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../../core/shared/presentation/controllers/states/abstractions/app_state.dart';
import '../../../../../core/shared/presentation/controllers/states/global_states/idle_state.dart';
import '../events/add_marker_event.dart';
import '../events/clear_marker_event.dart';
import '../events/map_event.dart';
import '../states/adding_marker_state.dart';
import '../states/successfully_added_marker_state.dart';
import '../states/successfully_cleared_marker_state.dart';

class MapControlBloc extends Bloc<MapEvent, AppState> implements Disposable {
  MapControlBloc() : super(IdleState()) {
    on<AddMarkerEvent>(
      _onAddMarkerEvent,
    );
    on<ClearMarkerEvent>(
      _onClearMarkerEvent,
    );
  }

  @override
  void dispose() => close();

  FutureOr<void> _onAddMarkerEvent(
    AddMarkerEvent event,
    Emitter<AppState> emit,
  ) {
    emit(AddingMarkerState());
    Marker newMarker = Marker(
      markerId: const MarkerId('_'),
      position: LatLng(
        event.postalCodeEntity.location!.latitude,
        event.postalCodeEntity.location!.longitude,
      ),
      icon: BitmapDescriptor.defaultMarker,
    );
    emit(
      SuccessfullyAddedMarkerState(
        marker: newMarker,
        postalCodeEntity: event.postalCodeEntity,
      ),
    );
  }

  FutureOr<void> _onClearMarkerEvent(
    ClearMarkerEvent event,
    Emitter<AppState> emit,
  ) async {
    emit(SuccessfullyClearedMarkerState());
  }
}

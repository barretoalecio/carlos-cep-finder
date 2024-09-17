import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../core/shared/presentation/controllers/states/abstractions/app_state.dart';
import '../../../../../core/shared/presentation/controllers/states/global_states/idle_state.dart';
import '../events/get_current_location_event.dart';
import '../events/outlet_event.dart';
import '../states/loading_location_state.dart';
import '../states/successfully_got_location_state.dart';

class LocationBloc extends Bloc<OutletEvent, AppState> implements Disposable {
  LocationBloc() : super(IdleState()) {
    on<GetCurrentLocationEvent>(
      _onGetCurrentLocationEvent,
    );
  }

  double latitude = -13.0006552;
  double longitude = -38.5114449;

  @override
  void dispose() => close();

  FutureOr<void> _onGetCurrentLocationEvent(
    GetCurrentLocationEvent event,
    Emitter<AppState> emit,
  ) {
    emit(LoadingLocationState());
    latitude = event.latitude;
    longitude = event.longitude;
    emit(SuccessfullyGotLocationState());
  }
}

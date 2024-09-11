import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../core/shared/domain/parameters/zero_parameters.dart';
import '../../../../../core/shared/presentation/controllers/states/abstractions/app_state.dart';
import '../../../../../core/shared/presentation/controllers/states/global_states/idle_state.dart';
import '../../../domain/usecases/get_proper_route_to_navigate.dart';
import '../events/coordinator_events.dart';
import '../events/get_proper_route_to_navigate_event.dart';
import '../states/getting_proper_route_to_navigate_state.dart';
import '../states/successfully_got_proper_route_to_navigate_state.dart';
import '../states/unable_to_get_proper_route_to_navigate_state.dart';

class CoordinatorBloc extends Bloc<CoordinatorEvents, AppState>
    implements Disposable {
  CoordinatorBloc(
    this._getProperRouteToNavigate,
  ) : super(IdleState()) {
    on<GetProperRouteToNavigateEvent>(
      _onGetProperRouteToNavigateEvent,
    );
  }

  final GetProperRouteToNavigate _getProperRouteToNavigate;

  FutureOr<void> _onGetProperRouteToNavigateEvent(
    GetProperRouteToNavigateEvent event,
    Emitter<AppState> emit,
  ) async {
    emit(GettingProperRouteToNavigateState());
    final result = await _getProperRouteToNavigate(const ZeroParameters());
    emit(
      result.fold(
        (failure) => UnableToGetProperRouteToNavigateState(),
        (success) => SuccessfullyGotProperRouteToNavigateState(success),
      ),
    );
  }

  @override
  void dispose() => close();
}
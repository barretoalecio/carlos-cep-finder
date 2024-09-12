import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../core/shared/presentation/controllers/states/abstractions/app_state.dart';
import '../../../../../core/shared/presentation/controllers/states/global_states/idle_state.dart';
import '../events/change_current_outlet_index_event.dart';
import '../events/outlet_events.dart';
import '../states/modifying_current_outlet_index_state.dart';
import '../states/successfully_modified_outlet_index_state.dart';

class UpdateCurrentIndexBloc extends Bloc<OutletEvents, AppState>
    implements Disposable {
  UpdateCurrentIndexBloc() : super(IdleState()) {
    on<ChangeCurrentOutletIndexEvent>(
      _onChangeCurrentOutletIndexEvent,
    );
  }

  @override
  void dispose() => close();

  FutureOr<void> _onChangeCurrentOutletIndexEvent(
    ChangeCurrentOutletIndexEvent event,
    Emitter<AppState> emit,
  ) {
    emit(ModifyingCurrentOutletIndexState());
    emit(SuccessfullyModifiedOutletIndexState(index: event.index));
  }
}

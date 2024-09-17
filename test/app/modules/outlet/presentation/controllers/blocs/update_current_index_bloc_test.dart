import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:konsi_desafio_flutter/app/core/shared/presentation/controllers/states/abstractions/app_state.dart';
import 'package:konsi_desafio_flutter/app/core/shared/presentation/controllers/states/global_states/idle_state.dart';
import 'package:konsi_desafio_flutter/app/modules/outlet/presentation/controllers/blocs/update_current_index_bloc.dart';
import 'package:konsi_desafio_flutter/app/modules/outlet/presentation/controllers/events/change_current_outlet_index_event.dart';
import 'package:konsi_desafio_flutter/app/modules/outlet/presentation/controllers/states/modifying_current_outlet_index_state.dart';
import 'package:konsi_desafio_flutter/app/modules/outlet/presentation/controllers/states/successfully_modified_outlet_index_state.dart';

void main() {
  late UpdateCurrentIndexBloc bloc;

  setUp(() {
    bloc = UpdateCurrentIndexBloc();
  });

  tearDown(() {
    bloc.dispose();
  });

  group('CoordinatorBloc', () {
    test('Should be a abstraction of Bloc', () {
      expect(bloc, isA<Bloc>());
    });

    test('initial state should be IdleState', () {
      expect(bloc.state, IdleState());
    });

    blocTest<UpdateCurrentIndexBloc, AppState>(
      'emits [ModifyingCurrentOutletIndexState, SuccessfullyModifiedOutletIndexState] when ChangeCurrentOutletIndexEvent is added',
      build: () => bloc,
      act: (bloc) => bloc.add(const ChangeCurrentOutletIndexEvent(index: 1)),
      expect: () => [
        ModifyingCurrentOutletIndexState(),
        const SuccessfullyModifiedOutletIndexState(index: 1),
      ],
    );
  });
}

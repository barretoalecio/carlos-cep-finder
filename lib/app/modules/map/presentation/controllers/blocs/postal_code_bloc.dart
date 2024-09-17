import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../core/shared/domain/failures/empty_data_failure.dart';
import '../../../../../core/shared/domain/failures/no_internet_connection_failure.dart';
import '../../../../../core/shared/presentation/controllers/states/abstractions/app_state.dart';
import '../../../../../core/shared/presentation/controllers/states/global_states/empty_data_state.dart';
import '../../../../../core/shared/presentation/controllers/states/global_states/idle_state.dart';
import '../../../../../core/shared/presentation/controllers/states/global_states/no_internet_connection_state.dart';
import '../../../domain/failures/idle_data_failure.dart';
import '../../../domain/usecases/save_postal_code_data_usecase.dart';
import '../../../domain/usecases/search_postal_codes_usecases.dart';
import '../events/map_event.dart';
import '../events/save_postal_code_history_event.dart';
import '../events/search_postal_codes_event.dart';
import '../states/loading_postal_codes_state.dart';
import '../states/saving_postal_code_state.dart';
import '../states/search_postal_codes_empty_parameters_state.dart';
import '../states/successfully_got_postal_codes_state.dart';
import '../states/successfully_saved_postal_code_state.dart';
import '../states/unable_to_get_postal_codes_state.dart';
import '../states/unable_to_save_postal_code_state.dart';

class PostalCodeBloc extends Bloc<MapEvent, AppState> implements Disposable {
  PostalCodeBloc(
    this._searchPostalCodesUsecase,
    this._savePostalCodeDataUsecase,
  ) : super(IdleState()) {
    on<SearchPostalCodesEvent>(
      _onSearchPostalCodesEvent,
    );
    on<SavePostalCodeHistoryEvent>(
      _onSavePostalCodeHistoryEvent,
    );
  }
  final SearchPostalCodesUsecase _searchPostalCodesUsecase;
  final SavePostalCodeDataUsecase _savePostalCodeDataUsecase;

  @override
  void dispose() => close();

  FutureOr<void> _onSearchPostalCodesEvent(
    SearchPostalCodesEvent event,
    Emitter<AppState> emit,
  ) async {
    emit(const LoadingPostalCodesState());
    final result = await _searchPostalCodesUsecase(event.postalCode);
    emit(
      result.fold(
        (failure) {
          switch (failure.runtimeType) {
            case NoInternetConnectionFailure:
              return NoInternetConnectionState();
            case EmptyDataFailure:
              return EmptyDataState();
            case IdleDataFailure:
              return SearchPostalCodesEmptyParametersState();
            default:
              return const UnableToGetPostalCodesState();
          }
        },
        (success) => SuccessfullyGotPostalCodesState(postalCodes: success),
      ),
    );
  }

  FutureOr<void> _onSavePostalCodeHistoryEvent(
    SavePostalCodeHistoryEvent event,
    Emitter<AppState> emit,
  ) async {
    emit(SavingPostalCodeState());
    final result = await _savePostalCodeDataUsecase(event.postalCodeEntity);
    emit(
      result.fold(
        (failure) {
          switch (failure.runtimeType) {
            case NoInternetConnectionFailure:
              return NoInternetConnectionState();
            case EmptyDataFailure:
              return EmptyDataState();
            default:
              return UnableToSavePostalCodeState();
          }
        },
        (success) => SuccessfullySavedPostalCodeState(
          postalCodeEntity: event.postalCodeEntity,
        ),
      ),
    );
  }
}

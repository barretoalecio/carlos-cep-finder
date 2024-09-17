import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../core/shared/domain/failures/empty_data_failure.dart';
import '../../../../../core/shared/presentation/controllers/states/abstractions/app_state.dart';
import '../../../../../core/shared/presentation/controllers/states/global_states/empty_data_state.dart';
import '../../../../../core/shared/presentation/controllers/states/global_states/idle_state.dart';
import '../../../domain/failures/address_already_exists_failure.dart';
import '../../../domain/usecases/delete_address_by_code_usecase.dart';
import '../../../domain/usecases/get_addresses_usecase.dart';
import '../../../domain/usecases/save_address_usecase.dart';
import '../events/delete_address_by_code_event.dart';
import '../events/get_addresses_event.dart';
import '../events/notebook_event.dart';
import '../events/save_address_event.dart';
import '../states/address_already_exists_state.dart';
import '../states/loading_addresses_state.dart';
import '../states/saving_address_state.dart';
import '../states/successfully_delted_address_state.dart';
import '../states/successfully_got_addresses_state.dart';
import '../states/successfully_saved_address_state.dart';
import '../states/unable_to_delete_address_state.dart';
import '../states/unable_to_get_addresses_state.dart';
import '../states/unable_to_save_address_state.dart';

class NotebookBloc extends Bloc<NotebookEvent, AppState> implements Disposable {
  NotebookBloc(
    this._saveAddressUsecase,
    this._getAddressesUsecase,
    this._deleteAddressByCodeUsecase,
  ) : super(IdleState()) {
    on<GetAddressesEvent>(
      _onGetAddressesEvent,
    );
    on<SaveAddressEvent>(
      _onSaveAddressEvent,
    );
    on<DeleteAddressByCodeEvent>(
      _onDeleteAddressByCodeEvent,
    );
  }

  final GetAddressesUsecase _getAddressesUsecase;
  final SaveAddressUsecase _saveAddressUsecase;
  final DeleteAddressByCodeUsecase _deleteAddressByCodeUsecase;

  @override
  void dispose() => close();

  FutureOr<void> _onGetAddressesEvent(
    GetAddressesEvent event,
    Emitter<AppState> emit,
  ) async {
    emit(LoadingAddressesState());
    final result = await _getAddressesUsecase(event.postalCode);
    emit(
      result.fold(
        (failure) {
          switch (failure.runtimeType) {
            case EmptyDataFailure:
              return EmptyDataState();
            default:
              return UnableToGetAddressesState();
          }
        },
        (success) => SuccessfullyGotAddressesState(addresses: success),
      ),
    );
  }

  FutureOr<void> _onSaveAddressEvent(
    SaveAddressEvent event,
    Emitter<AppState> emit,
  ) async {
    emit(SavingAddressState());
    final result = await _saveAddressUsecase(event.parameters);
    emit(
      result.fold(
        (failure) {
          switch (failure.runtimeType) {
            case EmptyDataFailure:
              return EmptyDataState();
            case AddressAlreadyExistsFailure:
              return AddressAlreadyExistsState();
            default:
              return UnableToSaveAddressState();
          }
        },
        (success) => SuccessfullySavedAddressState(),
      ),
    );
  }

  FutureOr<void> _onDeleteAddressByCodeEvent(
    DeleteAddressByCodeEvent event,
    Emitter<AppState> emit,
  ) async {
    emit(SavingAddressState());
    final result = await _deleteAddressByCodeUsecase(event.parameters);
    emit(
      result.fold(
        (failure) {
          switch (failure.runtimeType) {
            case EmptyDataFailure:
              return EmptyDataState();
            default:
              return UnableToDeleteAddressState();
          }
        },
        (success) => SuccessfullyDeletedAddressState(),
      ),
    );
  }
}

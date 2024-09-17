import 'package:equatable/equatable.dart';

import '../../../../../core/shared/presentation/controllers/states/abstractions/success_state.dart';
import '../../../domain/entities/address_data_entity.dart';
import '../../../utils/messages/states/notebook_state_messages.dart';

class SuccessfullyGotAddressesState extends Equatable implements SuccessState {
  const SuccessfullyGotAddressesState({
    required this.addresses,
  });

  final List<AddressDataEntity> addresses;
  @override
  String get message => NotebookStateMessages.successfullyGotAddresses;

  @override
  List<Object?> get props => [addresses];
}

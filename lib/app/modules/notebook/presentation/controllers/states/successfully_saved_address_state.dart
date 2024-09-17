import 'package:equatable/equatable.dart';

import '../../../../../core/shared/presentation/controllers/states/abstractions/success_state.dart';
import '../../../utils/messages/states/notebook_state_messages.dart';

class SuccessfullySavedAddressState extends Equatable implements SuccessState {
  @override
  String get message => NotebookStateMessages.successfullySavedAddress;

  @override
  List<Object?> get props => [];
}

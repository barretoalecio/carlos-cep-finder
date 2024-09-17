import 'package:equatable/equatable.dart';

import '../../../../../core/shared/presentation/controllers/states/abstractions/success_state.dart';
import '../../../utils/messages/states/notebook_state_messages.dart';

class SuccessfullyDeletedAddressState extends Equatable implements SuccessState {
  @override
  String get message => NotebookStateMessages.successfullyDeletedAddress;
  
  @override
  List<Object?> get props => [];
}

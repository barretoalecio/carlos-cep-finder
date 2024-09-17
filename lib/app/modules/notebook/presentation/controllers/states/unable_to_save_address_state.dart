import 'package:equatable/equatable.dart';

import '../../../../../core/shared/presentation/controllers/states/abstractions/error_state.dart';
import '../../../utils/messages/states/notebook_state_messages.dart';

class UnableToSaveAddressState extends Equatable implements ErrorState {
  @override
  String get message => NotebookStateMessages.unableToSaveAddress;
  
  @override
  List<Object?> get props => [];
}

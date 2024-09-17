import 'package:equatable/equatable.dart';

import '../../../../../core/shared/presentation/controllers/states/abstractions/processing_state.dart';
import '../../../utils/messages/states/notebook_state_messages.dart';

class DeletingAddressState extends Equatable implements ProcessingState {
  @override
  String get message => NotebookStateMessages.deletingAddress;
  
  @override
  List<Object?> get props => [];
}

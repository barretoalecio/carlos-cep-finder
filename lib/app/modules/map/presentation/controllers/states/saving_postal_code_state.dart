import 'package:equatable/equatable.dart';

import '../../../../../core/shared/presentation/controllers/states/abstractions/processing_state.dart';
import '../../../utils/messages/states/map_state_messages.dart';

class SavingPostalCodeState extends Equatable implements ProcessingState {
  @override
  String get message => MapStateMessages.savingPostalCode;

  @override
  List<Object?> get props => [];
}

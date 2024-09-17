import 'package:equatable/equatable.dart';

import '../../../../../core/shared/presentation/controllers/states/abstractions/error_state.dart';
import '../../../utils/messages/states/map_state_messages.dart';

class UnableToSavePostalCodeState extends Equatable implements ErrorState {
  @override
  String get message => MapStateMessages.unableToSavePostalCode;

  @override
  List<Object?> get props => [];
}

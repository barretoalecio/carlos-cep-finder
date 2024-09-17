import 'package:equatable/equatable.dart';

import '../../../../../core/shared/presentation/controllers/states/abstractions/error_state.dart';
import '../../../utils/messages/states/map_state_messages.dart';

class InvalidPostalCodeState extends Equatable implements ErrorState {
  @override
  String get message => MapStateMessages.invalidPostalCode;

  @override
  List<Object?> get props => [];
}

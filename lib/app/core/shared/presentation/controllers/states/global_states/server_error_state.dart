import 'package:equatable/equatable.dart';

import '../../../../../utils/messages/states/core_state_messages.dart';
import '../abstractions/error_state.dart';

class ServerErrorState extends Equatable implements ErrorState {
  ServerErrorState([String? message]) {
    this.message = message ?? CoreStateMessages.serverError;
  }

  @override
  late final String message;

  @override
  List<Object?> get props => [message];
}

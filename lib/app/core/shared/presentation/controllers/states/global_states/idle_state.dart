import 'package:equatable/equatable.dart';

import '../../../../../utils/messages/states/core_state_messages.dart';
import '../abstractions/app_state.dart';

class IdleState extends Equatable implements AppState {
  @override
  String get message => CoreStateMessages.idleState;

  @override
  List<Object?> get props => [];
}

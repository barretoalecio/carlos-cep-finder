import '../../../../../utils/messages/states/core_state_messages.dart';
import '../abstractions/app_state.dart';

class IdleState implements AppState {
  @override
  String get message => CoreStateMessages.idleState;
}

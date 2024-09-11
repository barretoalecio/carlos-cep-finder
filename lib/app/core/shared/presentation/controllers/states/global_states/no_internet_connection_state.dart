import '../../../../../utils/messages/states/core_state_messages.dart';
import '../abstractions/error_state.dart';

class NoInternetConnectionState implements ErrorState {
  @override
  String get message => CoreStateMessages.noInternetConnection;
}

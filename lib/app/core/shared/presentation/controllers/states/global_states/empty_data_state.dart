import 'package:equatable/equatable.dart';

import '../../../../../utils/messages/states/core_state_messages.dart';
import '../abstractions/error_state.dart';

class EmptyDataState extends Equatable implements ErrorState {
  @override
  String get message => CoreStateMessages.emptyData;

  @override
  List<Object?> get props => [
        message,
      ];
}

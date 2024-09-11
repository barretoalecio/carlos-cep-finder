import 'package:equatable/equatable.dart';

import '../../../../../core/shared/presentation/controllers/states/abstractions/processing_state.dart';
import '../../../utils/messages/states/coordinator_state_messages.dart';

class GettingProperRouteToNavigateState extends Equatable
    implements ProcessingState {
  @override
  String get message => CoordinatorStateMessages.gettingProperRouteToNavigate;

  @override
  List<Object?> get props => [
        message,
      ];

  @override
  bool? get stringify => true;
}

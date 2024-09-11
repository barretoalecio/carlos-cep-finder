import 'package:equatable/equatable.dart';

import '../../../../../core/shared/presentation/controllers/states/abstractions/error_state.dart';
import '../../../utils/messages/states/coordinator_state_messages.dart';

class UnableToGetProperRouteToNavigateState extends Equatable
    implements ErrorState {
  @override
  String get message =>
      CoordinatorStateMessages.unableToGetProperRouteToNavigate;

  @override
  List<Object?> get props => [
        message,
      ];

  @override
  bool? get stringify => true;
}

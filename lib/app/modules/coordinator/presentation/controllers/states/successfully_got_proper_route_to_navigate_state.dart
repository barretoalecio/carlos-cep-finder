import 'package:equatable/equatable.dart';

import '../../../../../core/shared/presentation/controllers/states/abstractions/processing_state.dart';
import '../../../domain/entities/coordinator_result_entity.dart';
import '../../../utils/messages/states/coordinator_state_messages.dart';

class SuccessfullyGotProperRouteToNavigateState extends Equatable
    implements ProcessingState {
  const SuccessfullyGotProperRouteToNavigateState(this.coordinatorResultEntity);

  final CoordinatorResultEntity coordinatorResultEntity;

  @override
  String get message => CoordinatorStateMessages.gettingProperRouteToNavigate;

  @override
  List<Object?> get props => [
        coordinatorResultEntity,
        message,
      ];

  @override
  bool? get stringify => true;
}

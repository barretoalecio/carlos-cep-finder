import 'package:equatable/equatable.dart';

import '../../../../../core/shared/presentation/controllers/states/abstractions/success_state.dart';
import '../../../utils/messages/states/map_state_messages.dart';

class SuccessfullyClearedMarkerState extends Equatable implements SuccessState {
  @override
  String get message => MapStateMessages.successfullyClearedMarker;

  @override
  List<Object?> get props => [];
}

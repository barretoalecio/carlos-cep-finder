import 'package:equatable/equatable.dart';

import '../../../../../core/shared/presentation/controllers/states/abstractions/processing_state.dart';
import '../../../utils/messages/states/map_state_messages.dart';

class LoadingPostalCodesState extends Equatable implements ProcessingState {
  const LoadingPostalCodesState();

  @override
  String get message => MapStateMessages.loadingPostalCodes;

  @override
  List<Object?> get props => [];
}

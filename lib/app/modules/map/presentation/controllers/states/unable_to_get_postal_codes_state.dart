import 'package:equatable/equatable.dart';

import '../../../../../core/shared/presentation/controllers/states/abstractions/error_state.dart';
import '../../../utils/messages/states/map_state_messages.dart';

class UnableToGetPostalCodesState extends Equatable implements ErrorState {
  const UnableToGetPostalCodesState();

  @override
  String get message => MapStateMessages.unableToGetPostalCodes;

  @override
  List<Object?> get props => [];
}

import 'package:equatable/equatable.dart';

import '../../../../../core/shared/presentation/controllers/states/abstractions/error_state.dart';
import '../../../utils/messages/states/map_state_messages.dart';

class SearchPostalCodesEmptyParametersState extends Equatable implements ErrorState {
  @override
  String get message => MapStateMessages.searchPostalCodesEmptyParameters;

  @override
  List<Object?> get props => [];
}

import 'package:equatable/equatable.dart';

import '../../../../../core/shared/presentation/controllers/states/abstractions/success_state.dart';
import '../../../utils/messages/states/outlet_state_messages.dart';

class SuccessfullyModifiedOutletIndexState extends Equatable
    implements SuccessState {
  const SuccessfullyModifiedOutletIndexState({required this.index});

  final int index;

  @override
  String get message => OutletStateMessages.successfullyModifiedOutletIndex;

  @override
  List<Object?> get props => [index];
}

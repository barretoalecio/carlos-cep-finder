import 'package:equatable/equatable.dart';

import '../../../../../core/shared/presentation/controllers/states/abstractions/processing_state.dart';
import '../../../utils/messages/states/outlet_state_messages.dart';

class ModifyingCurrentOutletIndexState extends Equatable
    implements ProcessingState {
  @override
  String get message => OutletStateMessages.modifyingCurrentOutletIndex;

  @override
  List<Object?> get props => [];
}

import '../../../../../core/shared/presentation/controllers/states/abstractions/processing_state.dart';
import '../../../utils/messages/states/outlet_state_messages.dart';

class ModifyingCurrentOutletIndexState implements ProcessingState {
  @override
  String get message => OutletStateMessages.modifyingCurrentOutletIndex;
}
import 'package:equatable/equatable.dart';

import '../../../../../core/shared/presentation/controllers/states/abstractions/success_state.dart';
import '../../../domain/entities/postal_code_entity.dart';
import '../../../utils/messages/states/map_state_messages.dart';

class SuccessfullySavedPostalCodeState extends Equatable
    implements SuccessState {
  const SuccessfullySavedPostalCodeState({required this.postalCodeEntity});

  final PostalCodeEntity postalCodeEntity;

  @override
  String get message => MapStateMessages.successfullySavedPostalCode;

  @override
  List<Object?> get props => [];
}

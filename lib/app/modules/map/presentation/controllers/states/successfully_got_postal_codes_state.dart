import 'package:equatable/equatable.dart';

import '../../../../../core/shared/presentation/controllers/states/abstractions/success_state.dart';
import '../../../domain/entities/postal_code_entity.dart';
import '../../../utils/messages/states/map_state_messages.dart';

class SuccessfullyGotPostalCodesState extends Equatable
    implements SuccessState {
  const SuccessfullyGotPostalCodesState({required this.postalCodes});

  final List<PostalCodeEntity> postalCodes;

  @override
  String get message => MapStateMessages.successfullyGotPostalCodes;

  @override
  List<Object?> get props => [postalCodes];
}

import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../../core/shared/presentation/controllers/states/abstractions/success_state.dart';
import '../../../domain/entities/postal_code_entity.dart';
import '../../../utils/messages/states/map_state_messages.dart';

class SuccessfullyAddedMarkerState extends Equatable implements SuccessState {
  const SuccessfullyAddedMarkerState({
    required this.marker,
    required this.postalCodeEntity,
  });

  final Marker marker;
  final PostalCodeEntity postalCodeEntity;

  @override
  String get message => MapStateMessages.successfullyAddedMarker;

  @override
  List<Object?> get props => [marker, postalCodeEntity];
}

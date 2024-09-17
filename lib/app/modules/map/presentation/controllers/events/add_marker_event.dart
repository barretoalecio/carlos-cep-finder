import '../../../domain/entities/postal_code_entity.dart';
import 'map_event.dart';

class AddMarkerEvent implements MapEvent {
  const AddMarkerEvent({
    required this.postalCodeEntity,
  });

  final PostalCodeEntity postalCodeEntity;
}

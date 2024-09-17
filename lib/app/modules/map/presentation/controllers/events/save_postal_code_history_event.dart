import '../../../domain/entities/postal_code_entity.dart';
import 'map_event.dart';

class SavePostalCodeHistoryEvent implements MapEvent {
  const SavePostalCodeHistoryEvent({
    required this.postalCodeEntity,
  });

  final PostalCodeEntity postalCodeEntity;
}

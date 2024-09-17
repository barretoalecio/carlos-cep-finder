import '../../../domain/parameters/address_data_parameters.dart';
import 'notebook_event.dart';

class SaveAddressEvent implements NotebookEvent {
  const SaveAddressEvent({required this.parameters});

  final AddressDataParameters parameters;
}

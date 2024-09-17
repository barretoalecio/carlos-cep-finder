import 'notebook_event.dart';

class GetAddressesByPostalCodeEvent implements NotebookEvent {
  const GetAddressesByPostalCodeEvent({
    required this.postalCode,
  });

  final String postalCode;
}

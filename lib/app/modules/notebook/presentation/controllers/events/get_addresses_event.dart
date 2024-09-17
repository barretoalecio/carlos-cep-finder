import 'notebook_event.dart';

class GetAddressesEvent implements NotebookEvent {
  const GetAddressesEvent({this.postalCode});

  final String? postalCode;
}

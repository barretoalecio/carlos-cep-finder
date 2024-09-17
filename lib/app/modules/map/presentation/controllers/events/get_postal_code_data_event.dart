import 'map_event.dart';

class GetPostalCodeDataEvent implements MapEvent {
  const GetPostalCodeDataEvent({
    required this.postalCode,
  });

  final String postalCode;
}

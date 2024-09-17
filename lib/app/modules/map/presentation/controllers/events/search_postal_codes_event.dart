import 'map_event.dart';

class SearchPostalCodesEvent implements MapEvent {
  const SearchPostalCodesEvent({
    required this.postalCode,
  });

  final String postalCode;
}

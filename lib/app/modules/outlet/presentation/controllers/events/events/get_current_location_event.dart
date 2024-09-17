import '../outlet_event.dart';

class GetCurrentLocationEvent extends OutletEvent {
  const GetCurrentLocationEvent({
    required this.latitude,
    required this.longitude,
  });

  final double latitude;
  final double longitude;
}

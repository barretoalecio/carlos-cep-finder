import 'outlet_events.dart';

class ChangeCurrentOutletIndexEvent implements OutletEvents {
  const ChangeCurrentOutletIndexEvent({required this.index});

  final int index;
}

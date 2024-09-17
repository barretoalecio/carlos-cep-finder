import 'outlet_event.dart';

class ChangeCurrentOutletIndexEvent implements OutletEvent {
  const ChangeCurrentOutletIndexEvent({required this.index});

  final int index;
}

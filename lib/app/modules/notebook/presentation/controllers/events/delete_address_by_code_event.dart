import 'notebook_event.dart';

class DeleteAddressByCodeEvent implements NotebookEvent {
  const DeleteAddressByCodeEvent({required this.parameters});

  final String parameters;
}

import 'notebook_exception.dart';

class AddressAlreadyExistsException implements NotebookException {
  const AddressAlreadyExistsException([this.message]);

  @override
  final String? message;
}

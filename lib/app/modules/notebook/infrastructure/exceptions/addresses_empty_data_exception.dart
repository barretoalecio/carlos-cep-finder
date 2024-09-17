import 'notebook_exception.dart';

class AddressesEmptyDataException implements NotebookException {
  const AddressesEmptyDataException([this.message]);

  @override
  final String? message;
}

import '../../../../core/shared/infrastructure/exceptions/core_exception.dart';

class NotebookException implements CoreException {
  const NotebookException([this.message]);

  @override
  final String? message;
}

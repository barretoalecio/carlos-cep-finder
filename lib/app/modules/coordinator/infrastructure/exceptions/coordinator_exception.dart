import '../../../../core/shared/infrastructure/exceptions/core_exception.dart';

class CoordinatorException implements CoreException {
  const CoordinatorException([this.message]);

  @override
  final String? message;
}

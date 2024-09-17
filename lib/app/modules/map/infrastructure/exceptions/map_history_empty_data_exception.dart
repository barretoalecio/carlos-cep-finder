import '../../../../core/shared/infrastructure/exceptions/core_exception.dart';

class PostalCodesEmptyDataException implements CoreException {
  const PostalCodesEmptyDataException([this.message]);

  @override
  final String? message;
}

import 'core_exception.dart';

class CacheException implements CoreException {
  const CacheException([this.message]);

  @override
  final String? message;
}

abstract class CoreException implements Exception {
  const CoreException([this.message]);
  final String? message;
}

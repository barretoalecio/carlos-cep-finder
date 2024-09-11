import '../../domain/failures/server_failure.dart';
import 'core_exception.dart';

class ServerException implements CoreException {
  const ServerException({this.message, this.statusCode});

  @override
  final String? message;

  final int? statusCode;

  ServerFailure toFailure() {
    assert(
      statusCode != null && message != null,
      throw Exception('Unable to convert exception to failure'),
    );
    return ServerFailure('Mensagem: $message\nCódigo: $statusCode');
  }
}

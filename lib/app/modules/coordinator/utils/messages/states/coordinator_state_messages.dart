import '../errors/coordinator_error_messages.dart';

class CoordinatorStateMessages {
  const CoordinatorStateMessages();

  static const gettingProperRouteToNavigate =
      'Obtendo a rota apropriada para navegar';
  static const unableToGetProperRouteToNavigate =
      CoordinatorErrorMessages.unableToGetProperRouteToNavigate;
  static const successfullyGotProperRouteToNavigate =
      'Rota apropriada para navegar obtida com sucesso';
  static const newVersionIsAvailable =
      'Recomendamos que você mantenha seu aplicativo sempre atualizado para receber todas as novidades.';
}

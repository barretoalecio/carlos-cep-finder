import '../errors/notebook_error_state_messages.dart';

class NotebookStateMessages {
  const NotebookStateMessages();

  static const loadingAddresses = 'Buscando endereços salvos';
  static const savingAddress = 'Salvando endereço';
  static const successfullyGotAddresses = 'Endereços carregados com sucesso';
  static const successfullySavedAddress = 'Endereço salvo com sucesso';
  static const deletingAddress = 'Deletando endereço';
  static const successfullyDeletedAddress = 'Endereço deletado com sucesso';
  static const unableToGetAddresses =
      NotebookErrorStateMessages.unableToGetAddresses;
  static const unableToSaveAddress =
      NotebookErrorStateMessages.unableToSaveAddress;
  static const unableToDeleteAddress =
      NotebookErrorStateMessages.unableToDeleteAddress;
  static const addressAlreadyExists =
      NotebookErrorStateMessages.addressAlreadyExists;
}

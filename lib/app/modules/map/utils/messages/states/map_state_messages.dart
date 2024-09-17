import '../errors/map_error_state_messages.dart';

class MapStateMessages {
  const MapStateMessages();

  static const addingMarker = 'Adicionar Marker';
  static const successfullyAddedMarker = 'Marker adicionado com sucesso';
  static const successfullyClearedMarker = 'Marker apagado com sucesso';
  static const successfullyGotPostalCodes =
      'Lista de CEPs atualizada com sucesso';
  static const loadingPostalCodes = 'Carregando Lista de CEPs';
  static const successfullySavedPostalCode = 'Histórico salvo com sucesso';
  static const savingPostalCode = 'Salvando dados no histórico';
  static const searchPostalCodesEmptyParameters =
      MapErrorStateMessages.searchPostalCodesEmptyParameters;
  static const invalidPostalCode = MapErrorStateMessages.invalidPostalCode;
  static const unableToGetPostalCodes =
      MapErrorStateMessages.unableToGetPostalCodes;
  static const unableToSavePostalCode =
      MapErrorStateMessages.unableToSavePostalCode;
}

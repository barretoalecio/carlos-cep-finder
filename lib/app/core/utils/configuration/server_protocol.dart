enum ServerProtocol { http, https }

extension ServerProtocolExtension on ServerProtocol {
  String asString() {
    switch (this) {
      case ServerProtocol.http:
        return 'http';
      case ServerProtocol.https:
        return 'https';
      default:
        return '';
    }
  }
}

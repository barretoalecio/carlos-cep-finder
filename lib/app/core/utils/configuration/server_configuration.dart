import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'server_protocol.dart';

class ServerConfiguration {
  final String _googleMapsAPI = dotenv.get('GOOGLE_MAPS_API');
  final String _brasilAPI = dotenv.get('BRASIL_API');

  final ServerProtocol _protocol = ServerProtocol.https;

  String getBrasilAPI() {
    return '${_protocol.asString()}://$_brasilAPI';
  }

  String getGoogleMapsAPI() {
    return '${_protocol.asString()}://$_googleMapsAPI';
  }
}

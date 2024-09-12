import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

enum NetworkStatus { connected, disconnected }

abstract class NetworkService {
  const NetworkService();

  Future<bool> get hasActiveNetwork;
  Stream<NetworkStatus> get onNetworkStatusChanged;
}

class NetworkServiceImplementation implements NetworkService {
  const NetworkServiceImplementation(this.connectivity);

  final Connectivity connectivity;

  @override
  Future<bool> get hasActiveNetwork async {
    final status = await connectivity.checkConnectivity();
    return status.first != ConnectivityResult.none;
  }

  @override
  Stream<NetworkStatus> get onNetworkStatusChanged =>
      connectivity.onConnectivityChanged.map(
        (status) => status != ConnectivityResult.none
            ? NetworkStatus.connected
            : NetworkStatus.disconnected,
      );
}

import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

import '../../packages/network/network_status/network_status.dart';
import '../../shared/presentation/controllers/states/global_states/no_internet_connection_state.dart';
import '../../shared/presentation/widgets/snack_bar/konsi_snack_bar.dart';

mixin NoInternetMixin<T extends StatefulWidget> on State<T> {
  late StreamSubscription networkServiceStreamSubscription;

  @override
  void initState() {
    super.initState();
    networkServiceStreamSubscription =
        NetworkServiceImplementation(Connectivity())
            .connectivity
            .onConnectivityChanged
            .listen(
      (connectivityEvent) {
        if (connectivityEvent == ConnectivityResult.none) {
          KonsiSnackBar.showSnackBar(context, NoInternetConnectionState());
        } else {
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
        }
      },
    );
  }

  @override
  void dispose() {
    networkServiceStreamSubscription.cancel();
    super.dispose();
  }
}

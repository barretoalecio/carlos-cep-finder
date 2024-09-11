import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:http/http.dart' as http;

import '../core/packages/network/http_client/http_client.dart';
import '../core/packages/network/http_client/http_client_implementation.dart';
import '../core/packages/network/network_status/network_status.dart';
import '../core/utils/app_routes/coordinator_module_routes.dart';
import 'coordinator/coordinator_module.dart';

class AppModule extends Module {
  @override
  void exportedBinds(Injector i) {
    i.add(http.Client.new);
    i.add<HttpClient>(HttpClientImplementation.new);
    i.add(Connectivity.new);
    i.add<NetworkService>(NetworkServiceImplementation.new);
  }

  @override
  void routes(RouteManager router) {
    router.module(
      CoordinatorModuleRoutes.moduleName,
      module: CoordinatorModule(),
    );
  }
}

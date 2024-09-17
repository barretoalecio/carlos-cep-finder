import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:http/http.dart' as http;

import '../core/packages/cache/local_storage/local_storage_service.dart';
import '../core/packages/location/location_service.dart';
import '../core/packages/network/http_client/http_client.dart';
import '../core/packages/network/http_client/http_client_implementation.dart';
import '../core/packages/network/network_status/network_status.dart';
import '../core/utils/app_routes/coordinator_module_routes.dart';
import '../core/utils/app_routes/map_module_routes.dart';
import '../core/utils/app_routes/notebook_module_routes.dart';
import '../core/utils/app_routes/outlet_module_routes.dart';
import 'coordinator/coordinator_module.dart';
import 'map/map_module.dart';
import 'notebook/notebook_module.dart';
import 'outlet/outlet_module.dart';

class AppModule extends Module {
  @override
  void exportedBinds(Injector i) {
    i.add(http.Client.new);
    i.add<HttpClient>(HttpClientImplementation.new);
    i.add(Connectivity.new);
    i.add<NetworkService>(NetworkServiceImplementation.new);
    i.add<LocalStorageService>(
      LocalStorageServiceImplementation.new,
    );
    i.add<LocationService>(
      LocationServiceImplementation.new,
    );
  }

  @override
  void routes(RouteManager router) {
    router.module(
      CoordinatorModuleRoutes.moduleName,
      module: CoordinatorModule(),
    );
    router.module(
      OutletModuleRoutes.moduleName,
      module: OutletModule(),
    );
    router.module(
      MapModuleRoutes.moduleName,
      module: MapModule(),
    );
    router.module(
      NotebookModuleRoutes.moduleName,
      module: NotebookModule(),
    );
  }
}

import 'package:flutter_modular/flutter_modular.dart';

import '../../core/utils/app_routes/map_module_routes.dart';
import '../../core/utils/app_routes/notebook_module_routes.dart';
import '../../core/utils/app_routes/outlet_module_routes.dart';
import '../app_module.dart';
import '../map/map_module.dart';
import '../notebook/notebook_module.dart';
import 'presentation/controllers/blocs/location_bloc.dart';
import 'presentation/controllers/blocs/update_current_index_bloc.dart';
import 'presentation/pages/outlet_page.dart';

class OutletModule extends Module {
  @override
  List<Module> get imports => [
        AppModule(),
      ];

  @override
  void binds(Injector i) {
    i.add<UpdateCurrentIndexBloc>(UpdateCurrentIndexBloc.new);
    i.addSingleton<LocationBloc>(
      LocationBloc.new,
    );
  }

  @override
  void routes(RouteManager router) {
    router.child(
      OutletModuleRoutes.initialRoute,
      child: (context) => OutletPage(
        index: router.args.data['index'],
        latitude: router.args.data['latitude'],
        longitude: router.args.data['longitude'],
      ),
      children: [
        ModuleRoute(
          MapModuleRoutes.moduleName,
          module: MapModule(),
        ),
        ModuleRoute(
          NotebookModuleRoutes.moduleName,
          module: NotebookModule(),
        ),
      ],
    );
  }
}

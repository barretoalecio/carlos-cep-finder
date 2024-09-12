import 'package:flutter_modular/flutter_modular.dart';

import '../../core/utils/app_routes/outlet_module_routes.dart';
import '../app_module.dart';
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
  }

  @override
  void routes(RouteManager router) {
    router.child(
      OutletModuleRoutes.initialRoute,
      child: (context) => const OutletPage(),
    );
  }
}

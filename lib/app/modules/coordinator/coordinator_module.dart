import 'package:flutter_modular/flutter_modular.dart';

import '../../core/utils/app_routes/coordinator_module_routes.dart';
import '../app_module.dart';
import 'domain/repositories/coordinator_repository.dart';
import 'domain/usecases/get_proper_route_to_navigate.dart';
import 'infrastructure/repositories/coordinator_repository_implementation.dart';
import 'presentation/controllers/blocs/coordinator_bloc.dart';
import 'presentation/pages/coordinator_page.dart';

class CoordinatorModule extends Module {
  @override
  List<Module> get imports => [
        AppModule(),
      ];

  @override
  void binds(Injector injector) {
    injector.add<CoordinatorRepository>(
      CoordinatorRepositoryImplementation.new,
    );
    injector.add<GetProperRouteToNavigate>(
      GetProperRouteToNavigateImplementation.new,
    );
    injector.add(
      CoordinatorBloc.new,
    );
  }

  @override
  void routes(RouteManager r) {
    r.child(
      CoordinatorModuleRoutes.initialRoute,
      child: (context) => CoordinatorPage(),
    );
  }
}

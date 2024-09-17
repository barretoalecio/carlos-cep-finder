import 'package:flutter_modular/flutter_modular.dart';

import '../../core/utils/app_routes/map_module_routes.dart';
import '../app_module.dart';
import 'domain/repositories/map_repository.dart';
import 'domain/usecases/save_postal_code_data_usecase.dart';
import 'domain/usecases/search_postal_codes_usecases.dart';
import 'external/datasources/local/map_local_datasource_implementation.dart';
import 'external/datasources/remote/map_remote_datasource_implementation.dart';
import 'infrastructure/datasources/local/map_local_datasource.dart';
import 'infrastructure/datasources/remote/map_remote_datasource.dart';
import 'infrastructure/repositories/map_repository_implementation.dart';
import 'presentation/controllers/blocs/map_control_bloc.dart';
import 'presentation/controllers/blocs/postal_code_bloc.dart';
import 'presentation/interactors/map_interactors.dart';
import 'presentation/pages/display_map_page.dart';
import 'presentation/pages/search_postal_code_page.dart';
import 'utils/validators/map_validators.dart';

class MapModule extends Module {
  @override
  List<Module> get imports => [
        AppModule(),
      ];

  @override
  void binds(Injector i) {
    i.add<MapValidators>(
      MapValidatorsImplementation.new,
    );
    i.add<MapRemoteDatasource>(
      MapRemoteDatasourceImplementation.new,
    );
    i.add<MapLocalDatasource>(
      MapLocalDatasourceImplementation.new,
    );
    i.add<MapRepository>(
      MapRepositoryImplementation.new,
    );
    i.add<SearchPostalCodesUsecase>(
      SearchPostalCodesUsecaseImplementation.new,
    );
    i.add<SavePostalCodeDataUsecase>(
      SavePostalCodeDataUsecaseImplementation.new,
    );
    i.add<MapControlBloc>(
      MapControlBloc.new,
    );
    i.add<PostalCodeBloc>(
      PostalCodeBloc.new,
    );
    i.add<MapInteractors>(
      MapInteractorsImplementation.new,
    );
  }

  @override
  void routes(RouteManager router) {
    router.child(
      MapModuleRoutes.initialRoute,
      child: (context) => const DisplayMapPage(),
    );
    router.child(
      MapModuleRoutes.searchPostalCodesRoute,
      child: (context) => SearchPostalCodesPage(
        mapControlBloc: router.args.data['mapControlBloc'],
        cepTextEditingController: router.args.data['cepTextEditingController'],
      ),
    );
  }
}

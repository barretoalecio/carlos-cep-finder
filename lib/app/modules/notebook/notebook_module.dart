import 'package:flutter_modular/flutter_modular.dart';

import '../../core/utils/app_routes/notebook_module_routes.dart';
import '../app_module.dart';
import 'domain/repositories/notebook_repository.dart';
import 'domain/usecases/delete_address_by_code_usecase.dart';
import 'domain/usecases/get_addresses_usecase.dart';
import 'domain/usecases/save_address_usecase.dart';
import 'external/local/notebook_local_datasource_implementation.dart';
import 'infrastructure/datasources/local/notebook_local_datasource.dart';
import 'infrastructure/repositories/notebook_repository_implementation.dart';
import 'presentation/controllers/blocs/notebook_bloc.dart';
import 'presentation/interactors/notebook_interactors.dart';
import 'presentation/pages/listing_addresses_page.dart';
import 'presentation/pages/save_address_page.dart';
import 'presentation/pages/show_address_page.dart';

class NotebookModule extends Module {
  @override
  List<Module> get imports => [
        AppModule(),
      ];

  @override
  void binds(Injector i) {
    i.add<NotebookLocalDatasource>(
      NotebookLocalDatasourceImplementation.new,
    );
    i.add<NotebookRepository>(
      NotebookRepositoryImplementation.new,
    );
    i.add<SaveAddressUsecase>(
      SaveAddressUsecaseImplementation.new,
    );
    i.add<GetAddressesUsecase>(
      GetAddressesUsecaseImplementation.new,
    );
    i.add<DeleteAddressByCodeUsecase>(
      DeleteAddressByCodeUsecaseImplementation.new,
    );
    i.add<NotebookBloc>(
      NotebookBloc.new,
    );
    i.add<NotebookInteractors>(
      NotebookInteractorsImplementation.new,
    );
  }

  @override
  void routes(RouteManager router) {
    router.child(
      NotebookModuleRoutes.initialRoute,
      child: (context) => const ListingAddressesPage(),
    );
    router.child(
      NotebookModuleRoutes.saveAddress,
      child: (context) => SaveAddressPage(
        fullAddress: router.args.data['fullAddress'],
        postalCode: router.args.data['postalCode'],
        latitude: router.args.data['latitude'],
        longitude: router.args.data['longitude'],
      ),
    );
    router.child(
      NotebookModuleRoutes.showAddress,
      child: (context) => ShowAddressPage(
        addressDataEntity: router.args.data['addressDataEntity'],
      ),
    );
  }
}

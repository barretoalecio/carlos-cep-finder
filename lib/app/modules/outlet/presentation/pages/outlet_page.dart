import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../core/shared/presentation/controllers/states/abstractions/app_state.dart';
import '../../../../core/utils/app_routes/map_module_routes.dart';
import '../../../../core/utils/app_routes/notebook_module_routes.dart';
import '../../../../core/utils/app_routes/outlet_module_routes.dart';
import '../../../../core/utils/mixins/no_internet_mixin.dart';
import '../controllers/blocs/update_current_index_bloc.dart';
import '../controllers/events/change_current_outlet_index_event.dart';
import '../controllers/states/successfully_modified_outlet_index_state.dart';
import '../widgets/bottom_navigation_bar/outlet_bottom_navigation_bar_widget.dart';

class OutletPage extends StatefulWidget {
  const OutletPage({super.key});

  @override
  State<OutletPage> createState() => _OutletPageState();
}

class _OutletPageState extends State<OutletPage> with NoInternetMixin {
  late final UpdateCurrentIndexBloc updateCurrentIndexBloc;

  @override
  void initState() {
    super.initState();
    updateCurrentIndexBloc = Modular.get();
    _onDestinationSelected(0);
  }

  void _onDestinationSelected(int index) {
    updateCurrentIndexBloc.add(ChangeCurrentOutletIndexEvent(index: index));
    switch (index) {
      case 0:
        Modular.to.navigate(
          '${OutletModuleRoutes.moduleName}${MapModuleRoutes.moduleName}${MapModuleRoutes.initialRoute}',
        );
      default:
        Modular.to.navigate(
          '${OutletModuleRoutes.moduleName}${NotebookModuleRoutes.moduleName}${NotebookModuleRoutes.initialRoute}',
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const RouterOutlet(),
      bottomNavigationBar: BlocBuilder<UpdateCurrentIndexBloc, AppState>(
        bloc: updateCurrentIndexBloc,
        builder: (context, state) {
          if (state is SuccessfullyModifiedOutletIndexState) {
            return OutletBottomNavigationBarWidget(
              onDestinationSelected: (index) =>
                  state.index != index ? _onDestinationSelected(index) : null,
              currentIndex: state.index,
            );
          }
          return Container();
        },
      ),
    );
  }
}

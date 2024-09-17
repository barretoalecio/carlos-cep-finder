import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../core/shared/presentation/controllers/states/abstractions/app_state.dart';
import '../../../../core/utils/app_routes/map_module_routes.dart';
import '../../../../core/utils/app_routes/notebook_module_routes.dart';
import '../../../../core/utils/app_routes/outlet_module_routes.dart';
import '../../../../core/utils/mixins/no_internet_mixin.dart';
import '../controllers/blocs/location_bloc.dart';
import '../controllers/blocs/update_current_index_bloc.dart';
import '../controllers/events/change_current_outlet_index_event.dart';
import '../controllers/events/get_current_location_event.dart';
import '../controllers/states/successfully_got_location_state.dart';
import '../controllers/states/successfully_modified_outlet_index_state.dart';
import '../widgets/bottom_navigation_bar/outlet_bottom_navigation_bar_widget.dart';

class OutletPage extends StatefulWidget {
  const OutletPage({
    super.key,
    this.index = 0,
    required this.latitude,
    required this.longitude,
  });

  final int index;
  final double latitude;
  final double longitude;

  @override
  State<OutletPage> createState() => _OutletPageState();
}

class _OutletPageState extends State<OutletPage> with NoInternetMixin {
  late final UpdateCurrentIndexBloc updateCurrentIndexBloc;
  late final LocationBloc locationBloc;
  @override
  void initState() {
    super.initState();
    locationBloc = Modular.get();
    locationBloc.add(
      GetCurrentLocationEvent(
        latitude: widget.latitude,
        longitude: widget.longitude,
      ),
    );
    updateCurrentIndexBloc = Modular.get();
  }

  @override
  void dispose() {
    updateCurrentIndexBloc.dispose();
    super.dispose();
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
      body: BlocConsumer<LocationBloc, AppState>(
        bloc: locationBloc,
        listener: (context, state) {
          if (state is SuccessfullyGotLocationState) {
            _onDestinationSelected(widget.index);
          }
        },
        builder: (context, state) {
          return const RouterOutlet();
        },
      ),
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

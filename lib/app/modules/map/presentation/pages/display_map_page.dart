import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../core/shared/presentation/controllers/states/abstractions/app_state.dart';
import '../../../../core/utils/app_routes/map_module_routes.dart';
import '../../../../core/utils/app_routes/notebook_module_routes.dart';
import '../../../../core/utils/extensions/postal_code_extension.dart';
import '../../../../core/utils/mixins/no_internet_mixin.dart';
import '../../../outlet/presentation/controllers/blocs/location_bloc.dart';
import '../controllers/blocs/map_control_bloc.dart';
import '../controllers/events/clear_marker_event.dart';
import '../controllers/states/successfully_added_marker_state.dart';
import '../interactors/map_interactors.dart';
import '../widgets/postal_code_text_widget.dart';
import '../widgets/search_postal_codes_text_field_widget.dart';

class DisplayMapPage extends StatefulWidget {
  const DisplayMapPage({super.key});

  @override
  State<DisplayMapPage> createState() => _DisplayMapPageState();
}

class _DisplayMapPageState extends State<DisplayMapPage> with NoInternetMixin {
  late final GoogleMapController _mapController;
  late final LocationBloc _locationBloc;
  late final MapInteractors _mapInteractors;
  late final MapControlBloc _mapControlBloc;
  late final TextEditingController _cepTextEditingController;

  @override
  void initState() {
    _mapControlBloc = Modular.get();
    _mapInteractors = Modular.get();
    _locationBloc = Modular.get();
    _cepTextEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _mapController.dispose();
    _mapControlBloc.dispose();
    _cepTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<MapControlBloc, AppState>(
        bloc: _mapControlBloc,
        listener: (context, state) async {
          if (state is SuccessfullyAddedMarkerState) {
            await _mapController.animateCamera(
              CameraUpdate.newLatLngZoom(
                LatLng(
                  state.marker.position.latitude,
                  state.marker.position.longitude,
                ),
                18,
              ),
            );

            await _mapInteractors.showDetailsBottomSheet(
              context,
              postalCode: state.postalCodeEntity.postalCode,
              fullAddress: state.postalCodeEntity.formattedAddress,
              onTap: () => Modular.to.pushNamed(
                '${NotebookModuleRoutes.moduleName}${NotebookModuleRoutes.saveAddress}',
                arguments: {
                  'fullAddress': state.postalCodeEntity.formattedAddress,
                  'postalCode': state.postalCodeEntity.postalCode,
                  'latitude': state.postalCodeEntity.location?.latitude,
                  'longitude': state.postalCodeEntity.location?.longitude,
                },
              ),
            );

            _mapControlBloc.add(const ClearMarkerEvent());
            _cepTextEditingController.clear();
          }
        },
        builder: (context, state) {
          return SafeArea(
            top: false,
            child: Stack(
              children: [
                GoogleMap(
                  compassEnabled: false,
                  zoomControlsEnabled: false,
                  initialCameraPosition: CameraPosition(
                    target:
                        LatLng(_locationBloc.latitude, _locationBloc.longitude),
                    zoom: 18,
                  ),
                  markers: state is SuccessfullyAddedMarkerState
                      ? {state.marker}
                      : <Marker>{},
                  onMapCreated: (controller) {
                    _mapController = controller;
                  },
                ),
                Positioned.fill(
                  left: 136.0,
                  bottom: 40.0,
                  child: PostalCodeTextWidget(
                    postalCode: _cepTextEditingController.text,
                  ),
                ),
                if (state is SuccessfullyAddedMarkerState)
                  Positioned.fill(
                    child: Container(
                      color: Colors.transparent,
                    ),
                  ),
                Positioned.fill(
                  top: 64,
                  child: SearchPostalCodesFieldWidget(
                    controller: _cepTextEditingController,
                    onTap: () => Modular.to.pushNamed(
                      '${MapModuleRoutes.moduleName}${MapModuleRoutes.searchPostalCodesRoute}',
                      arguments: {
                        'mapControlBloc': _mapControlBloc,
                        'cepTextEditingController': _cepTextEditingController,
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

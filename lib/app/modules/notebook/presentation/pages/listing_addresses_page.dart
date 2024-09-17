import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../core/shared/presentation/controllers/states/abstractions/app_state.dart';
import '../../../../core/shared/presentation/controllers/states/abstractions/processing_state.dart';
import '../../../../core/shared/presentation/controllers/states/global_states/idle_state.dart';
import '../../../../core/shared/presentation/pages/error_page.dart';
import '../../../../core/shared/presentation/widgets/search_postal_code_text_field_widget.dart';
import '../../../../core/shared/presentation/widgets/snack_bar/konsi_snack_bar.dart';
import '../../../../core/utils/app_routes/notebook_module_routes.dart';
import '../controllers/blocs/notebook_bloc.dart';
import '../controllers/events/delete_address_by_code_event.dart';
import '../controllers/events/get_addresses_event.dart';
import '../controllers/states/successfully_delted_address_state.dart';
import '../controllers/states/successfully_got_addresses_state.dart';
import '../interactors/notebook_interactors.dart';
import '../widgets/address_item_tile_widget.dart';
import '../widgets/shimmer/address_item_tile_shimmer_widget.dart';

class ListingAddressesPage extends StatefulWidget {
  const ListingAddressesPage({super.key});

  @override
  State<ListingAddressesPage> createState() => _ListingAddressesPageState();
}

class _ListingAddressesPageState extends State<ListingAddressesPage> {
  late final NotebookBloc notebookBloc;
  late final NotebookInteractors notebookInteractors;
  late final TextEditingController cepTextEditingController;

  @override
  void initState() {
    notebookBloc = Modular.get();
    notebookInteractors = Modular.get();
    cepTextEditingController = TextEditingController();
    notebookBloc.add(const GetAddressesEvent());
    super.initState();
  }

  @override
  void dispose() {
    notebookBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(80.0, 160.0),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SearchPostalCodesTextFieldWidget(
              postalCodesEditingController: cepTextEditingController,
              isEnabled: true,
              onChanged: (value) =>
                  notebookBloc.add(GetAddressesEvent(postalCode: value)),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: BlocConsumer<NotebookBloc, AppState>(
          bloc: notebookBloc,
          listener: (context, state) {
            KonsiSnackBar.showSnackBar(context, state);

            if (state is SuccessfullyDeletedAddressState) {
              notebookBloc.add(const GetAddressesEvent());
            }
          },
          builder: (context, state) {
            if (state is ProcessingState || state is IdleState) {
              return ListingPostalCodesPageSkeleton(
                child: ListView.separated(
                  key: UniqueKey(),
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return const AddressItemTileShimmerWidget();
                  },
                  separatorBuilder: (context, index) {
                    return Divider(
                      color: Theme.of(context).colorScheme.secondary,
                    );
                  },
                ),
              );
            }
            if (state is SuccessfullyGotAddressesState) {
              return ListingPostalCodesPageSkeleton(
                child: ListView.separated(
                  key: UniqueKey(),
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  itemCount: state.addresses.length,
                  itemBuilder: (context, index) {
                    final address = state.addresses.elementAt(index);
                    return AddressItemTileWidget(
                      address: address,
                      onTap: () => Modular.to.pushNamed(
                        '${NotebookModuleRoutes.moduleName}${NotebookModuleRoutes.showAddress}',
                        arguments: {'addressDataEntity': address},
                      ),
                      onDelete: () => notebookInteractors.showConfirmDialog(
                        context,
                        postalCode: address.postalCode,
                        onContinue: () => notebookBloc.add(
                          DeleteAddressByCodeEvent(
                            parameters: address.code,
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Divider(
                      color: Theme.of(context).colorScheme.secondary,
                    );
                  },
                ),
              );
            }
            return ListingPostalCodesPageSkeleton(
              child: ErrorPage(
                key: UniqueKey(),
                message: state.message,
              ),
            );
          },
        ),
      ),
    );
  }
}

class ListingPostalCodesPageSkeleton extends StatelessWidget {
  const ListingPostalCodesPageSkeleton({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: AnimatedSwitcher(
          switchInCurve: Curves.easeIn,
          switchOutCurve: Curves.easeInOut,
          duration: const Duration(milliseconds: 600),
          child: child,
        ),
      ),
    );
  }
}

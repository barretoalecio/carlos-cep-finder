import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../core/shared/presentation/controllers/states/abstractions/app_state.dart';
import '../../../../core/shared/presentation/controllers/states/abstractions/processing_state.dart';
import '../../../../core/shared/presentation/controllers/states/global_states/idle_state.dart';
import '../../../../core/shared/presentation/pages/error_page.dart';
import '../../../../core/shared/presentation/pages/idle_page.dart';
import '../../../../core/shared/presentation/widgets/search_postal_code_text_field_widget.dart';
import '../../../../core/utils/mixins/no_internet_mixin.dart';
import '../controllers/blocs/map_control_bloc.dart';
import '../controllers/blocs/postal_code_bloc.dart';
import '../controllers/events/add_marker_event.dart';
import '../controllers/events/save_postal_code_history_event.dart';
import '../controllers/events/search_postal_codes_event.dart';
import '../controllers/states/search_postal_codes_empty_parameters_state.dart';
import '../controllers/states/successfully_got_postal_codes_state.dart';
import '../controllers/states/successfully_saved_postal_code_state.dart';
import '../widgets/postal_code_item_tile_widget.dart';
import '../widgets/shimmer/postal_code_item_tile_shimmer_widget.dart';

class SearchPostalCodesPage extends StatefulWidget {
  const SearchPostalCodesPage({
    super.key,
    required this.mapControlBloc,
    required this.cepTextEditingController,
  });

  final MapControlBloc mapControlBloc;
  final TextEditingController cepTextEditingController;
  @override
  State<SearchPostalCodesPage> createState() => _SearchPostalCodesPageState();
}

class _SearchPostalCodesPageState extends State<SearchPostalCodesPage>
    with NoInternetMixin {
  late final PostalCodeBloc postalCodeBloc;

  @override
  void initState() {
    postalCodeBloc = Modular.get();
    postalCodeBloc.add(const SearchPostalCodesEvent(postalCode: ''));
    super.initState();
  }

  @override
  void dispose() {
    postalCodeBloc.dispose();
    super.dispose();
  }

  void _searchPostCodes(String postalCode) {
    postalCodeBloc.add(SearchPostalCodesEvent(postalCode: postalCode));
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
              postalCodesEditingController: widget.cepTextEditingController,
              isEnabled: true,
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        elevation: 5.0,
        child: Center(
          child: Icon(
            Icons.search,
            color: Theme.of(context).colorScheme.surface,
          ),
        ),
        onPressed: () => _searchPostCodes(widget.cepTextEditingController.text),
      ),
      body: SafeArea(
        child: BlocConsumer<PostalCodeBloc, AppState>(
          bloc: postalCodeBloc,
          listener: (context, state) {
            if (state is SuccessfullySavedPostalCodeState) {
              widget.cepTextEditingController.text =
                  state.postalCodeEntity.postalCode;
              widget.mapControlBloc.add(
                AddMarkerEvent(postalCodeEntity: state.postalCodeEntity),
              );
            }
          },
          builder: (context, state) {
            if (state is SearchPostalCodesEmptyParametersState) {
              return SearchPostalCodesPageSkeleton(
                child: IdlePage(
                  key: UniqueKey(),
                  message: state.message,
                ),
              );
            }
            if (state is ProcessingState || state is IdleState) {
              return SearchPostalCodesPageSkeleton(
                child: ListView.separated(
                  key: UniqueKey(),
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return const PostalCodeItemTileShimmerWidget();
                  },
                  separatorBuilder: (context, index) {
                    return Divider(
                      color: Theme.of(context).colorScheme.secondary,
                    );
                  },
                ),
              );
            }
            if (state is SuccessfullyGotPostalCodesState) {
              return SearchPostalCodesPageSkeleton(
                child: ListView.separated(
                  key: UniqueKey(),
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  itemCount: state.postalCodes.length,
                  itemBuilder: (context, index) {
                    final postalCode = state.postalCodes.elementAt(index);
                    return PostalCodeItemTileWidget(
                      postalCode: postalCode,
                      onTap: () {
                        postalCodeBloc.add(
                          SavePostalCodeHistoryEvent(
                            postalCodeEntity: postalCode,
                          ),
                        );
                        Modular.to.maybePop(context);
                      },
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
            return SearchPostalCodesPageSkeleton(
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

class SearchPostalCodesPageSkeleton extends StatelessWidget {
  const SearchPostalCodesPageSkeleton({super.key, required this.child});
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

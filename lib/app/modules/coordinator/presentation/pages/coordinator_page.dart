import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../core/shared/presentation/controllers/states/abstractions/app_state.dart';
import '../../../../core/shared/presentation/pages/splash_page.dart';
import '../../../../core/shared/presentation/widgets/snack_bar/konsi_snack_bar.dart';
import '../controllers/blocs/coordinator_bloc.dart';
import '../controllers/events/get_proper_route_to_navigate_event.dart';
import '../controllers/states/successfully_got_proper_route_to_navigate_state.dart';
import '../controllers/states/unable_to_get_proper_route_to_navigate_state.dart';

class CoordinatorPage extends StatelessWidget {
  CoordinatorPage({Key? key}) : super(key: key);
  final coordinatorBloc = Modular.get<CoordinatorBloc>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<CoordinatorBloc, AppState>(
      bloc: coordinatorBloc,
      listener: (context, state) async {
        if (state is SuccessfullyGotProperRouteToNavigateState) {
          Modular.to.navigate(
            state.coordinatorResultEntity.properRouteToNavigate,
            arguments: state.coordinatorResultEntity.arguments,
          );
        }

        if (state is UnableToGetProperRouteToNavigateState) {
          KonsiSnackBar.showSnackBar(context, state);
        }
      },
      child: SplashPage(
        onAnimationCompleted: () async {
          coordinatorBloc.add(
            const GetProperRouteToNavigateEvent(),
          );
        },
      ),
    );
  }
}

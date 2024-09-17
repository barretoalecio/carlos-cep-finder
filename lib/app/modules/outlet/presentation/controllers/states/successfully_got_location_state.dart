import 'package:equatable/equatable.dart';

import '../../../../../core/shared/presentation/controllers/states/abstractions/success_state.dart';

class SuccessfullyGotLocationState extends Equatable implements SuccessState {
  @override
  String get message => '';

  @override
  List<Object?> get props => [];
}

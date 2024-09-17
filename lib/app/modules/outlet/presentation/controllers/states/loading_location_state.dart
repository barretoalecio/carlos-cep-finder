import 'package:equatable/equatable.dart';

import '../../../../../core/shared/presentation/controllers/states/abstractions/processing_state.dart';

class LoadingLocationState extends Equatable implements ProcessingState {
  @override
  String get message => '';

  @override
  List<Object?> get props => [];
}

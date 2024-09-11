import 'package:equatable/equatable.dart';

class CoordinatorResultEntity extends Equatable {
  const CoordinatorResultEntity({
    required this.properRouteToNavigate,
    this.arguments,
  });

  final String properRouteToNavigate;
  final Object? arguments;

  @override
  List<Object?> get props => [
        properRouteToNavigate,
        arguments,
      ];
}

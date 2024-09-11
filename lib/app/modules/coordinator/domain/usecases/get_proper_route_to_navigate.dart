import 'package:dartz/dartz.dart';

import '../../../../core/shared/domain/failures/failure.dart';
import '../../../../core/shared/domain/parameters/zero_parameters.dart';
import '../../../../core/shared/domain/usecases/async_usecase.dart';
import '../entities/coordinator_result_entity.dart';
import '../failures/coordinator_failure.dart';
import '../repositories/coordinator_repository.dart';

abstract class GetProperRouteToNavigate
    extends AsyncUsecase<CoordinatorResultEntity, ZeroParameters> {
  const GetProperRouteToNavigate();
}

class GetProperRouteToNavigateImplementation
    implements GetProperRouteToNavigate {
  const GetProperRouteToNavigateImplementation(this.repository);

  final CoordinatorRepository repository;

  @override
  Future<Either<Failure, CoordinatorResultEntity>> call(
    ZeroParameters parameters,
  ) async {
    try {
      return await repository.getProperRouteToNavigate();
    } catch (exception) {
      return Left(CoordinatorFailure(exception.toString()));
    }
  }
}

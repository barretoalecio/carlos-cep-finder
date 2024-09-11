import 'package:dartz/dartz.dart';

import '../../../../core/shared/domain/failures/failure.dart';
import '../../domain/entities/coordinator_result_entity.dart';
import '../../domain/repositories/coordinator_repository.dart';
import '../exceptions/unable_to_ger_proper_route_to_navigate_exception.dart';

class CoordinatorRepositoryImplementation implements CoordinatorRepository {
  const CoordinatorRepositoryImplementation();

  @override
  Future<Either<Failure, CoordinatorResultEntity>>
      getProperRouteToNavigate() async {
    throw const UnableToGetProperRouteToNavigateException();
  }
}

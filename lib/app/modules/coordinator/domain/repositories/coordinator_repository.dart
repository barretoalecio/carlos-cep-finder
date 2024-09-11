import 'package:dartz/dartz.dart';

import '../../../../core/shared/domain/failures/failure.dart';
import '../entities/coordinator_result_entity.dart';

abstract class CoordinatorRepository {
  const CoordinatorRepository();

  Future<Either<Failure, CoordinatorResultEntity>> getProperRouteToNavigate();
}

import 'package:dartz/dartz.dart';

import '../../../../core/shared/domain/failures/failure.dart';
import '../../../../core/shared/domain/usecases/async_usecase.dart';
import '../entities/postal_code_entity.dart';
import '../failures/map_failure.dart';
import '../repositories/map_repository.dart';

abstract class SavePostalCodeDataUsecase
    extends AsyncUsecase<void, PostalCodeEntity> {
  const SavePostalCodeDataUsecase();
}

class SavePostalCodeDataUsecaseImplementation
    implements SavePostalCodeDataUsecase {
  const SavePostalCodeDataUsecaseImplementation(
    this._repository,
  );

  final MapRepository _repository;

  @override
  Future<Either<Failure, void>> call(
    PostalCodeEntity parameters,
  ) async {
    try {
      return await _repository.savePostalCodeData(parameters);
    } catch (exception) {
      return Left(MapFailure(exception.toString()));
    }
  }
}

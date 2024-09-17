import 'package:dartz/dartz.dart';

import '../../../../core/shared/domain/failures/failure.dart';
import '../../../../core/shared/domain/usecases/async_usecase.dart';
import '../failures/notebook_failure.dart';
import '../repositories/notebook_repository.dart';

abstract class DeleteAddressByCodeUsecase extends AsyncUsecase<void, String> {
  const DeleteAddressByCodeUsecase();
}

class DeleteAddressByCodeUsecaseImplementation
    implements DeleteAddressByCodeUsecase {
  const DeleteAddressByCodeUsecaseImplementation(
    this._repository,
  );

  final NotebookRepository _repository;

  @override
  Future<Either<Failure, void>> call(String parameters) async {
    try {
      return await _repository.deleteAddressByCode(parameters);
    } catch (exception) {
      return Left(NotebookFailure(exception.toString()));
    }
  }
}

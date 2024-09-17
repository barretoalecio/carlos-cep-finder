import 'package:dartz/dartz.dart';

import '../../../../core/shared/domain/failures/failure.dart';
import '../../../../core/shared/domain/usecases/async_usecase.dart';
import '../failures/notebook_failure.dart';
import '../parameters/address_data_parameters.dart';
import '../repositories/notebook_repository.dart';

abstract class SaveAddressUsecase
    implements AsyncUsecase<void, AddressDataParameters> {
  const SaveAddressUsecase();
}

class SaveAddressUsecaseImplementation implements SaveAddressUsecase {
  const SaveAddressUsecaseImplementation(
    this.repository,
  );

  final NotebookRepository repository;

  @override
  Future<Either<Failure, void>> call(
    AddressDataParameters parameters,
  ) async {
    try {
      return await repository.saveAddress(parameters);
    } catch (exception) {
      return Left(NotebookFailure(exception.toString()));
    }
  }
}

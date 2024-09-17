import 'package:dartz/dartz.dart';

import '../../../../core/shared/domain/failures/failure.dart';
import '../../../../core/shared/domain/usecases/async_usecase.dart';
import '../entities/address_data_entity.dart';
import '../failures/notebook_failure.dart';
import '../repositories/notebook_repository.dart';

abstract class GetAddressesUsecase
    implements AsyncUsecase<List<AddressDataEntity>, String?> {
  const GetAddressesUsecase();
}

class GetAddressesUsecaseImplementation implements GetAddressesUsecase {
  const GetAddressesUsecaseImplementation(
    this.repository,
  );

  final NotebookRepository repository;

  @override
  Future<Either<Failure, List<AddressDataEntity>>> call(
    String? parameters,
  ) async {
    try {
      return await repository.getAddresses(parameters);
    } catch (exception) {
      return Left(NotebookFailure(exception.toString()));
    }
  }
}

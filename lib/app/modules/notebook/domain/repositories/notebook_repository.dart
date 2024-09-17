import 'package:dartz/dartz.dart';

import '../../../../core/shared/domain/failures/failure.dart';
import '../entities/address_data_entity.dart';
import '../parameters/address_data_parameters.dart';

abstract class NotebookRepository {
  Future<Either<Failure, List<AddressDataEntity>>> getAddresses([
    String? parameters,
  ]);
  Future<Either<Failure, void>> saveAddress(
    AddressDataParameters parameters,
  );
  Future<Either<Failure, void>> deleteAddressByCode(
    String parameters,
  );
}

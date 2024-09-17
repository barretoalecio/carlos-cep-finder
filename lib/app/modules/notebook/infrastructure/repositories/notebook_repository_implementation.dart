import 'package:dartz/dartz.dart';

import '../../../../core/shared/domain/failures/empty_data_failure.dart';
import '../../../../core/shared/domain/failures/failure.dart';
import '../../domain/entities/address_data_entity.dart';
import '../../domain/failures/address_already_exists_failure.dart';
import '../../domain/parameters/address_data_parameters.dart';
import '../../domain/repositories/notebook_repository.dart';
import '../datasources/local/notebook_local_datasource.dart';
import '../exceptions/address_already_existis_exception.dart';
import '../exceptions/addresses_empty_data_exception.dart';

class NotebookRepositoryImplementation implements NotebookRepository {
  const NotebookRepositoryImplementation(
    this.localDatasource,
  );

  final NotebookLocalDatasource localDatasource;

  @override
  Future<Either<Failure, List<AddressDataEntity>>> getAddresses([
    String? parameters,
  ]) async {
    try {
      final result = await localDatasource.getAddresses(parameters);
      return Right(result);
    } on AddressesEmptyDataException {
      return const Left(EmptyDataFailure());
    } catch (exception) {
      return Left(Failure(exception.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> saveAddress(
    AddressDataParameters parameters,
  ) async {
    try {
      final postalCodeSaved = await localDatasource.saveAddress(parameters);
      return Right(postalCodeSaved);
    } on AddressAlreadyExistsException {
      return const Left(AddressAlreadyExistsFailure());
    } catch (exception) {
      return Left(Failure(exception.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteAddressByCode(
    String parameters,
  ) async {
    try {
      final deletedData = await localDatasource.deleteAddressByCode(parameters);
      return Right(deletedData);
    } catch (exception) {
      return Left(Failure(exception.toString()));
    }
  }
}

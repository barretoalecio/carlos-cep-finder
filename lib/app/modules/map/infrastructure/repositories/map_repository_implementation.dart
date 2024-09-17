import 'package:dartz/dartz.dart';

import '../../../../core/packages/network/network_status/network_status.dart';
import '../../../../core/shared/domain/failures/empty_data_failure.dart';
import '../../../../core/shared/domain/failures/failure.dart';
import '../../../../core/shared/domain/failures/no_internet_connection_failure.dart';
import '../../domain/entities/postal_code_entity.dart';
import '../../domain/failures/idle_data_failure.dart';
import '../../domain/repositories/map_repository.dart';
import '../datasources/local/map_local_datasource.dart';
import '../datasources/remote/map_remote_datasource.dart';
import '../exceptions/map_history_empty_data_exception.dart';

class MapRepositoryImplementation implements MapRepository {
  const MapRepositoryImplementation({
    required this.networkService,
    required this.remoteDatasource,
    required this.localDatasource,
  });

  final MapRemoteDatasource remoteDatasource;
  final MapLocalDatasource localDatasource;
  final NetworkService networkService;

  @override
  Future<Either<Failure, List<PostalCodeEntity>>> searchPostalCodes(
    String parameters,
  ) async {
    try {
      if (parameters.trim().isEmpty) {
        final postalCodesEntity = await localDatasource.getPostalCodesHistory();
        return Right(postalCodesEntity);
      }
      if (await networkService.hasActiveNetwork) {
        final postalCodes = await remoteDatasource.searchPostCodesEntity(
          parameters,
        );
        return Right(postalCodes);
      }
      return const Left(NoInternetConnectionFailure());
    } on PostalCodesEmptyDataException {
      if (parameters.trim().isEmpty) {
        return const Left(IdleDataFailure());
      }
      return const Left(EmptyDataFailure());
    } catch (exception) {
      return Left(Failure(exception.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> savePostalCodeData(
    PostalCodeEntity parameters,
  ) async {
    try {
      final savedPostalCodeEntityVoid =
          await localDatasource.savePostalCodeInHistory(parameters);
      return Right(savedPostalCodeEntityVoid);
    } catch (exception) {
      return Left(Failure(exception.toString()));
    }
  }
}

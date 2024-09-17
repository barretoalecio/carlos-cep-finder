import 'package:dartz/dartz.dart';

import '../../../../core/shared/domain/failures/failure.dart';
import '../../../../core/shared/domain/usecases/async_usecase.dart';
import '../entities/postal_code_entity.dart';
import '../failures/map_failure.dart';
import '../repositories/map_repository.dart';

abstract class SearchPostalCodesUsecase
    extends AsyncUsecase<List<PostalCodeEntity>, String> {
  const SearchPostalCodesUsecase();
}

class SearchPostalCodesUsecaseImplementation
    implements SearchPostalCodesUsecase {
  SearchPostalCodesUsecaseImplementation({
    required this.repository,
  });

  final MapRepository repository;

  @override
  Future<Either<Failure, List<PostalCodeEntity>>> call(
    String parameters,
  ) async {
    try {
      return await repository.searchPostalCodes(parameters);
    } catch (exception) {
      return Left(MapFailure(exception.toString()));
    }
  }
}

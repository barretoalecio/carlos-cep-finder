import 'package:dartz/dartz.dart';

import '../../../../core/shared/domain/failures/failure.dart';
import '../entities/postal_code_entity.dart';

abstract class MapRepository {
  Future<Either<Failure, List<PostalCodeEntity>>> searchPostalCodes(
    String parameters,
  );

  Future<Either<Failure, void>> savePostalCodeData(
    PostalCodeEntity parameters,
  );
}

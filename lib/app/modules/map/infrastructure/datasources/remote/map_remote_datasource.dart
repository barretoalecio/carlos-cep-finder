import '../../../domain/entities/postal_code_entity.dart';

abstract class MapRemoteDatasource {
  Future<PostalCodeEntity> getPostalCodeEntity(String postalCode);
  Future<List<PostalCodeEntity>> searchPostCodesEntity(String postalCode);
}

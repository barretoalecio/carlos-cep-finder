import '../../../domain/entities/postal_code_entity.dart';

abstract class MapLocalDatasource {
  Future<List<PostalCodeEntity>> getPostalCodesHistory();
  Future<void> savePostalCodeInHistory(PostalCodeEntity parameters);
}

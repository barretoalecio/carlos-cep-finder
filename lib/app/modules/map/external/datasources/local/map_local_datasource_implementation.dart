import 'dart:convert';

import '../../../../../core/packages/cache/local_storage/local_storage_service.dart';
import '../../../../../core/utils/cache_keys/postal_codes_history_cache_keys.dart';
import '../../../domain/entities/postal_code_entity.dart';
import '../../../infrastructure/datasources/local/map_local_datasource.dart';
import '../../../infrastructure/exceptions/map_history_empty_data_exception.dart';
import '../../../infrastructure/mappers/postal_code_entity_mapper.dart';

class MapLocalDatasourceImplementation implements MapLocalDatasource {
  const MapLocalDatasourceImplementation({
    required this.localStorageService,
  });

  final LocalStorageService localStorageService;

  @override
  Future<List<PostalCodeEntity>> getPostalCodesHistory() async {
    try {
      if (await localStorageService.hasStoredDataInKey(
        key: PostalCodesHistoryCacheKeys.appCache,
      )) {
        final result = await localStorageService.getStoredData(
          key: PostalCodesHistoryCacheKeys.appCache,
        );

        if (result == null) {
          throw const PostalCodesEmptyDataException();
        }

        List<PostalCodeEntity> history = [];

        final decodedResponse = jsonDecode(result);

        history.addAll(
          decodedResponse
              .map<PostalCodeEntity>(
                (item) => PostalCodeEntityMapper.fromMap(item),
              )
              .toList(),
        );

        return history;
      }
      throw const PostalCodesEmptyDataException();
    } catch (exception) {
      rethrow;
    }
  }

  @override
  Future<void> savePostalCodeInHistory(
    PostalCodeEntity parameters,
  ) async {
    try {
      final history = await getPostalCodesHistory();

      final alreadyExists =
          history.any((element) => element.postalCode == parameters.postalCode);

      if (!alreadyExists) {
        history.insert(0, parameters);

        if (history.length > 5) {
          history.removeLast();
        }
        await _storePostalCodesHistory(history);
      }
    } on PostalCodesEmptyDataException {
      await _storePostalCodesHistory([parameters]);
    } catch (exception) {
      rethrow;
    }
  }

  Future<void> _storePostalCodesHistory(List<PostalCodeEntity> history) async {
    final jsonList = history
        .map((element) => PostalCodeEntityMapper.toMap(element))
        .toList();
    final encodedResponse = jsonEncode(jsonList);
    await localStorageService.storeData(
      key: PostalCodesHistoryCacheKeys.appCache,
      value: encodedResponse,
    );
  }
}

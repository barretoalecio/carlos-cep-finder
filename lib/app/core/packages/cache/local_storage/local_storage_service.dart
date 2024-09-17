import 'package:hive/hive.dart';

import '../../../shared/infrastructure/exceptions/cache_exception.dart';
import '../../../utils/cache_keys/app_cache_keys.dart';
import '../persistent_storage_service.dart';

abstract class LocalStorageService extends PersistentStorageService {}

class LocalStorageServiceImplementation implements LocalStorageService {
  const LocalStorageServiceImplementation();

  @override
  Future<dynamic> getStoredData({String? key}) async {
    if (key == null) throw const CacheException();

    try {
      final box = await Hive.openBox(AppCacheKeys.appCache);

      final result = await box.get(key);

      if (result != null) {
        return result;
      } else {
        throw const CacheException();
      }
    } catch (exception) {
      throw const CacheException();
    }
  }

  @override
  Future<void> storeData({value, String? key}) async {
    if (value == null || key == null) throw const CacheException();

    try {
      final box = await Hive.openBox(AppCacheKeys.appCache);

      await box.put(key, value);
    } catch (exception) {
      throw const CacheException();
    }
  }

  @override
  Future<bool> hasStoredDataInKey({String? key}) async {
    if (key == null) return false;

    try {
      final box = await Hive.openBox(AppCacheKeys.appCache);

      final value = box.containsKey(key);

      return value;
    } catch (exception) {
      return false;
    }
  }

  @override
  Future<void> deleteStoredData({String? key}) async {
    if (key == null) throw const CacheException();

    try {
      final box = await Hive.openBox(AppCacheKeys.appCache);

      await box.delete(key);
    } catch (exception) {
      throw const CacheException();
    }
  }
}

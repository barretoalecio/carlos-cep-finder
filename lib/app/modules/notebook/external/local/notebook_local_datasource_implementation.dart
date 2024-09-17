import 'dart:convert';

import '../../../../core/packages/cache/local_storage/local_storage_service.dart';
import '../../../../core/utils/cache_keys/addresses_cache_keys.dart';
import '../../domain/entities/address_data_entity.dart';
import '../../domain/parameters/address_data_parameters.dart';
import '../../infrastructure/datasources/local/notebook_local_datasource.dart';
import '../../infrastructure/exceptions/address_already_existis_exception.dart';
import '../../infrastructure/exceptions/addresses_empty_data_exception.dart';
import '../../infrastructure/mappers/address_data_entity_mapper.dart';
import '../../infrastructure/mappers/address_data_parameters_mapper.dart';

class NotebookLocalDatasourceImplementation implements NotebookLocalDatasource {
  const NotebookLocalDatasourceImplementation(
    this.localStorageService,
  );

  final LocalStorageService localStorageService;

  @override
  Future<List<AddressDataEntity>> getAddresses([String? parameters]) async {
    try {
      if (await localStorageService.hasStoredDataInKey(
        key: AddressesCacheKeys.appCache,
      )) {
        final result = await localStorageService.getStoredData(
          key: AddressesCacheKeys.appCache,
        );

        if (result == null) {
          throw const AddressesEmptyDataException();
        }

        List<AddressDataEntity> addresses = [];

        final decodedResponse = jsonDecode(result);

        addresses.addAll(
          decodedResponse
              .map<AddressDataEntity>(
                (item) => AddressDataEntityMapper.fromMap(item),
              )
              .toList(),
        );

        if (parameters != null && parameters.isNotEmpty) {
          addresses = addresses.where((address) {
            return address.postalCode.toString().startsWith(parameters);
          }).toList();
        }

        return addresses.isEmpty
            ? throw const AddressesEmptyDataException()
            : addresses;
      }
      throw const AddressesEmptyDataException();
    } catch (exception) {
      rethrow;
    }
  }

  @override
  Future<void> saveAddress(
    AddressDataParameters parameters,
  ) async {
    try {
      final addresses = await getAddresses();

      final alreadyExists = addresses.any(
        (element) =>
            element.postalCode == parameters.postalCode &&
            element.complement == parameters.complement &&
            element.fullAddress == parameters.fullAddress &&
            element.number == parameters.number,
      );

      if (alreadyExists) {
        throw const AddressAlreadyExistsException();
      }

      addresses.insert(
        0,
        AddressDataEntity(
          code: parameters.code,
          postalCode: parameters.postalCode,
          fullAddress: parameters.fullAddress,
          complement: parameters.complement,
          number: parameters.number,
          latitude: parameters.latitude,
          longitude: parameters.longitude,
        ),
      );

      await _storeAddresses(addresses);
    } on AddressesEmptyDataException {
      await _storeAddresses([
        AddressDataEntity(
          code: parameters.code,
          postalCode: parameters.postalCode,
          fullAddress: parameters.fullAddress,
          complement: parameters.complement,
          number: parameters.number,
          latitude: parameters.latitude,
          longitude: parameters.longitude,
        ),
      ]);
    } catch (exception) {
      rethrow;
    }
  }

  @override
  Future<void> deleteAddressByCode(
    String parameters,
  ) async {
    final result = await localStorageService.getStoredData(
      key: AddressesCacheKeys.appCache,
    );

    await localStorageService.deleteStoredData(
      key: AddressesCacheKeys.appCache,
    );

    if (result == null) {
      throw const AddressesEmptyDataException();
    }

    List<AddressDataEntity> addresses = [];

    final decodedResponse = jsonDecode(result);

    addresses.addAll(
      decodedResponse
          .map<AddressDataEntity>(
            (item) => AddressDataEntityMapper.fromMap(item),
          )
          .toList(),
    );

    addresses.removeWhere(
      (item) => item.code == parameters,
    );

    await _storeAddresses(addresses);
  }

  Future<void> _storeAddresses(List<AddressDataEntity> addresses) async {
    final jsonList = addresses
        .map(
          (element) => AddressDataParametersMapper.toMap(
            AddressDataParameters(
              postalCode: element.postalCode,
              fullAddress: element.fullAddress,
              complement: element.complement,
              number: element.number,
              latitude: element.latitude,
              longitude: element.longitude,
            ),
          ),
        )
        .toList();
    final encodedResponse = jsonEncode(jsonList);
    await localStorageService.storeData(
      key: AddressesCacheKeys.appCache,
      value: encodedResponse,
    );
  }
}

import '../../../domain/entities/address_data_entity.dart';
import '../../../domain/parameters/address_data_parameters.dart';

abstract class NotebookLocalDatasource {
  Future<List<AddressDataEntity>> getAddresses([String? parameters]);
  Future<void> saveAddress(AddressDataParameters parameters);
  Future<void> deleteAddressByCode(String parameters);
}

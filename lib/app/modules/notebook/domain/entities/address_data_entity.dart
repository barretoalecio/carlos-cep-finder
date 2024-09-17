import 'package:equatable/equatable.dart';

class AddressDataEntity extends Equatable {
  const AddressDataEntity({
    required this.postalCode,
    required this.fullAddress,
    required this.complement,
    required this.number,
    required this.latitude,
    required this.longitude,
    required this.code,
  });
  final String code;
  final String postalCode;
  final String fullAddress;
  final String? complement;
  final int? number;
  final double? latitude;
  final double? longitude;

  @override
  List<Object?> get props => [
        postalCode,
        fullAddress,
        complement,
        number,
        latitude,
        longitude,
      ];
}

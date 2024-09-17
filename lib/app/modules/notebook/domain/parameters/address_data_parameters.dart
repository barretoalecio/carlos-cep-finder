import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

class AddressDataParameters extends Equatable {
  AddressDataParameters({
    required this.postalCode,
    required this.fullAddress,
    required this.complement,
    required this.number,
    required this.latitude,
    required this.longitude,
    String? code,
  }) : code = code ?? const Uuid().v4();

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

import '../../../../core/utils/regex/core_regular_expressions.dart';

abstract class MapValidators {
  const MapValidators();

  bool hasValidPostalCode(String postalCode);
}

class MapValidatorsImplementation implements MapValidators {
  MapValidatorsImplementation();

  @override
  bool hasValidPostalCode(String postalCode) {
    if (CoreRegularExpressions.postalCodeValidation.hasMatch(postalCode)) {
      return true;
    }
    return false;
  }
}

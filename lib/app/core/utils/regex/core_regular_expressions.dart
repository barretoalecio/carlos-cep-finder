class CoreRegularExpressions {
  const CoreRegularExpressions();

  static RegExp get postalCodeValidation => RegExp(r'^\d{8}$');
}

extension StringExtension on String {
  String toPostalCodeFormat() {
    return '${substring(0, 5)}-${substring(5)}';
  }
}

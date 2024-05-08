class FormatHelper {
  String formatDecimalAndRemoveTrailingZeros(double value) {
    String formattedValue = removeTrailingZeros(value)
        .toStringAsFixed(value.truncateToDouble() == value ? 0 : 2);
    return formattedValue;
  }

  double removeTrailingZeros(double value) {
    RegExp regex = RegExp(r'([.]*0)(?!.*\d)');
    return double.parse(
        value == 0 ? "0" : value.toString().replaceAll(regex, ''));
  }

  String removeTrailingZerosFromString(String value) {
    RegExp regex = RegExp(r'([.]*0)(?!.*\d)');
    return value == "0" ? "0" : value.replaceAll(regex, '');
  }
}

extension ConvertValue on String {
  String convert() {
    double convertedValue = double.parse(this) / 10;
    return convertedValue.toString();
  }
}

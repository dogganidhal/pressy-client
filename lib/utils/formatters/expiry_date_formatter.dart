import 'package:flutter/services.dart';


class ExpiryDateInputFormatter implements TextInputFormatter {

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {

    switch (newValue.text.length) {
      case 1:
        if (int.parse(newValue.text) > 1) {
          return new TextEditingValue();
        }
        break;
      case 2:
        if (int.parse(newValue.text) > 12) {
          return oldValue;
        }
        break;
      case 4:
        final dateComponents = newValue.text.split("/");
        final month = dateComponents[0], year = dateComponents[1];
        final minYear = int.parse(month) <= new DateTime.now().month ? new DateTime.now().year + 1 : new DateTime.now().year;
        if (int.parse(year) < minYear ~/ 10 % 10) {
          return oldValue;
        }
        break;
      case 5:
        final dateComponents = newValue.text.split("/");
        final month = dateComponents[0], year = dateComponents[1];
        if (new DateTime(int.parse(year) + 2000, int.parse(month)).isBefore(DateTime.now()))
          return oldValue;
        break;
      default:
        break;
    }

    return newValue;
  }

}

import 'package:intl/intl.dart';

class Formats {

  static String formattedNumber(double number) {
    return NumberFormat.compactCurrency(
      decimalDigits: 0,
      locale: 'en',
      symbol: ''
    ).format(number);
  }

}
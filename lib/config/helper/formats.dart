
import 'package:intl/intl.dart';

class Formats {

  static String formattedNumber(double number, [ int decimal = 0 ]) {
    return NumberFormat.compactCurrency(
      decimalDigits: decimal,
      locale: 'en',
      symbol: ''
    ).format(number);
  }

}
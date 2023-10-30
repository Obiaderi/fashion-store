import 'package:intl/intl.dart';

final formatCurrency = NumberFormat.currency(locale: 'en_US', symbol: '');

final formatCurrencyWithoutDecimal =
    NumberFormat.currency(locale: 'en_US', symbol: '', decimalDigits: 0);

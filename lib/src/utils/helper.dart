import 'package:intl/intl.dart';


String formatCurrency(dynamic number, [String format = '\$ #,##0.00#']) {
  final f = NumberFormat(format, 'en_US');
  final value = f.format(number);
  return value;
}
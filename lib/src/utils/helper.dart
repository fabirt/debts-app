import 'package:intl/intl.dart';


String formatCurrency(dynamic number, [String format = '\$ #,##0.00#']) {
  final f = NumberFormat(format, 'en_US');
  final value = f.format(number);
  return value;
}

String formatDate(DateTime date, [String format = 'dd/MM/yyyy']) {
  final d = DateFormat(format, 'en_US').format(date);
  return d;
}
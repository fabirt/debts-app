import 'package:intl/intl.dart';

/// Format a number into currency .
String formatCurrency(dynamic number, [String format = '\$ #,##0.00#']) {
  final f = NumberFormat(format);
  final value = f.format(number);
  return value;
}

/// Format a [DateTime] date into a [String].
String formatDate(DateTime date, [String format = 'dd/MM/yyyy']) {
  final d = DateFormat(format, 'en_US').format(date);
  return d;
}

/// Get the first 2 letters of a string.
String getInitials(String name) {
  String initials = '';
  final values = name.split(' ');
  for (final v in values) {
    if (initials.length < 2) initials += v[0];
  }
  return initials;
}

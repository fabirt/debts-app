import 'package:flutter/services.dart';
import 'package:debts_app/core/utils/helper.dart';

class NumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) {
      return newValue;
    } else if (newValue.text.length > 9) {
      return oldValue;
    } else if (newValue.text.compareTo(oldValue.text) != 0) {
      final int selectionIndexFromTheRight = newValue.text.length - newValue.selection.end;
      final value = double.tryParse(newValue.text.replaceAll('.', ''));
      final newText = formatCurrency(value, '#,###');
      return newValue.copyWith(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length - selectionIndexFromTheRight),
      );
    } else {
      return newValue;
    }
  }
}

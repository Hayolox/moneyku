import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CurrencyPtBrInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    int value = int.parse(newValue.text);
    String newText =
        NumberFormat.currency(locale: 'id', decimalDigits: 0, symbol: '')
            .format(value)
            .toString();

    return newValue.copyWith(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length));
  }
}

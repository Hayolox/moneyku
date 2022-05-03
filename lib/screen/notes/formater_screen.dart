import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CurrencyPtBrInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    double _value = double.parse(newValue.text);
    final _formatter = NumberFormat("#,##0.00", "pt_BR");
    String _newText = _formatter.format(_value / 100);

    return newValue.copyWith(
        text: _newText,
        selection: TextSelection.collapsed(offset: _newText.length));
  }
}

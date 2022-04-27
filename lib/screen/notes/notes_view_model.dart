import 'package:flutter/material.dart';

class NotesViewModel extends ChangeNotifier {
  DateTime dueDate = DateTime.now();
  final currenDate = DateTime.now();

  Future<void> showDate(BuildContext context) async {
    final selectDate = await showDatePicker(
      context: context,
      initialDate: dueDate,
      firstDate: DateTime(currenDate.year),
      lastDate: DateTime(currenDate.year + 1),
    );
    dueDate = selectDate!;
    notifyListeners();
  }
}

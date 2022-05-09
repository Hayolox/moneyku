import 'package:flutter_test/flutter_test.dart';
import 'package:moneyku/constant/state.dart';
import 'package:moneyku/model/transaction_model.dart';
import 'package:moneyku/screen/notes/notes_view_model.dart';

void main() {
  NotesViewModel _notes = NotesViewModel();

  test('Test State', () {
    expect(_notes.state, StatusState.loding);

    _notes.changeStatusState(StatusState.error);
    expect(_notes.state, StatusState.error);

    _notes.changeStatusState(StatusState.none);
    expect(_notes.state, StatusState.none);
  });

  test('Get status transaction', () async {
    await _notes.getStatusTransaction();
    expect(_notes.incomeDataTransaction.isNotEmpty, true);
    expect(_notes.spendingDataTransaction.isNotEmpty, true);
  });

  group('Add transaction', () {
    test('Add income transaction', () async {
      await _notes.getStatusTransaction();
      int _incomeOld = _notes.incomeDataTransaction.length;
      await _notes.addTransaction(
          TransactionModel(
            title: 'Unit Testing',
            price: '1000',
            status: 'income',
            createdAt: DateTime.now().toString(),
          ),
          'admin');

      await _notes.getStatusTransaction();
      int _incomeNew = _notes.incomeDataTransaction.length;

      expect(_incomeNew > _incomeOld, true);
    });

    test('Add expenditure transaction', () async {
      await _notes.getStatusTransaction();
      int _spendingOld = _notes.spendingDataTransaction.length;
      await _notes.addTransaction(
          TransactionModel(
            title: 'Unit Testing',
            price: '1000',
            status: 'spending',
            createdAt: DateTime.now().toString(),
          ),
          'admin');

      await _notes.getStatusTransaction();
      int _spendingNew = _notes.spendingDataTransaction.length;

      expect(_spendingNew > _spendingOld, true);
    });
  });
}

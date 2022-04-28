import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:moneyku/model/api/transaction_api.dart';
import 'package:moneyku/model/transaction_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constant/state.dart';
import '../../model/user_model.dart';

class NotesViewModel extends ChangeNotifier {
  DateTime dueDate = DateTime.now();
  final currenDate = DateTime.now();

  List<TransactionModel> allDataTransaction = [];
  List<TransactionModel> incomeDataTransaction = [];
  List<TransactionModel> spendingDataTransaction = [];
  late String income, spending, name;
  late int total;
  StatusState state = StatusState.loding;

  changeStatusState(StatusState s) {
    state = s;
    notifyListeners();
  }

  getAllDataTransaction() async {
    changeStatusState(StatusState.loding);
    try {
      Map<String, dynamic> _getTransactionApi =
          await TransactionApi().getAllDataTransaction();

      /// get all data transaction
      List<dynamic> _allData = _getTransactionApi['alldata'];
      for (var element in _allData) {
        allDataTransaction.add(TransactionModel.fromJson(element));
      }

      /// get  data income transaction
      List<dynamic> _dataIncome = _getTransactionApi['income'];
      for (var element in _dataIncome) {
        incomeDataTransaction.add(TransactionModel.fromJson(element));
      }

      /// get  data spending transaction
      List<dynamic> _dataSpending = _getTransactionApi['spending'];
      for (var element in _dataSpending) {
        incomeDataTransaction.add(TransactionModel.fromJson(element));
      }

      // get status money
      income = _getTransactionApi['sumIncome'];
      spending = _getTransactionApi['sumSpending'];
      total = _getTransactionApi['total'];

      final prefs = await SharedPreferences.getInstance();
      Map<String, dynamic> decodeUser =
          json.decode(prefs.getString('user') as String);
      UserModel _user = UserModel.fromJson(decodeUser);
      name = _user.name;
      changeStatusState(StatusState.none);
      notifyListeners();
    } catch (e) {
      changeStatusState(StatusState.error);
    }
  }

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

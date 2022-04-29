import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:moneyku/model/api/transaction_api.dart';
import 'package:moneyku/model/transaction_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import '../../constant/state.dart';
import '../../future_pub_dev/toast.dart';
import '../../model/user_model.dart';

class NotesViewModel extends ChangeNotifier {
  DateTime dueDate = DateTime.now();
  final currenDate = DateTime.now();

  TextEditingController titleC = TextEditingController();
  var priceC = MaskedTextController(
    mask: '000.000.000',
  );

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
      ///get storage user
      final prefs = await SharedPreferences.getInstance();
      Map<String, dynamic> decodeUser =
          json.decode(prefs.getString('user') as String);
      UserModel _user = UserModel.fromJson(decodeUser);
      name = _user.name;

      Map<String, dynamic> _getTransactionApi =
          await TransactionApi().getAllDataTransaction();

      /// get all data transaction
      List<dynamic> _allData = _getTransactionApi['alldata'];
      List<TransactionModel> _allDataTransactionSecond = [];
      for (var element in _allData) {
        _allDataTransactionSecond.add(TransactionModel.fromJson(element));
      }
      allDataTransaction = _allDataTransactionSecond;

      // get status money

      if (_getTransactionApi['sumIncome'] == 0 &&
          _getTransactionApi['sumSpending'] == 0) {
        income = '0';
        spending = '0';
        total = 0;
      } else if (_getTransactionApi['sumIncome'] == 0) {
        income = '0';
        spending = _getTransactionApi['sumSpending'];
        total = _getTransactionApi['total'];
      } else if (_getTransactionApi['sumSpending'] == 0) {
        spending = '0';
        income = _getTransactionApi['sumIncome'];
        total = _getTransactionApi['total'];
      } else {
        income = _getTransactionApi['sumIncome'];
        spending = _getTransactionApi['sumSpending'];
        total = _getTransactionApi['total'];
      }

      changeStatusState(StatusState.none);
      notifyListeners();
    } catch (e) {
      changeStatusState(StatusState.error);
      notifyListeners();
    }
  }

  getStatusTransaction() async {
    changeStatusState(StatusState.loding);

    try {
      var _getStatusTransactionApi =
          await TransactionApi().getStatusTransaction();

      /// get  status data income
      List<dynamic> _income = _getStatusTransactionApi[0];
      List<TransactionModel> _incomeSecond = [];
      for (var element in _income) {
        _incomeSecond.add(TransactionModel.fromJson(element));
      }
      incomeDataTransaction = _incomeSecond;

      /// get  status data income
      List<dynamic> spending = _getStatusTransactionApi[1];
      List<TransactionModel> _spendingSecond = [];
      for (var element in spending) {
        _spendingSecond.add(TransactionModel.fromJson(element));
      }
      spendingDataTransaction = _spendingSecond;
      changeStatusState(StatusState.none);
      notifyListeners();
    } catch (e) {
      changeStatusState(StatusState.none);
      notifyListeners();
    }
  }

  addTransactionIncome(
    String paramTitle,
    int paramPrice,
    String paramDate,
  ) async {
    try {
      await TransactionApi()
          .addTransactionIncome(paramTitle, paramPrice, paramDate);
      titleC.clear();
      priceC.clear();
      toastInformation('Data Berhasil Ditambahkan');
    } catch (e) {
      toastAlert('Gagal Menambahkan Data');
    }
  }

  addTransactionExpenditure(
    String paramTitle,
    int paramPrice,
    String paramDate,
  ) async {
    try {
      await TransactionApi()
          .addTransactionExpenditure(paramTitle, paramPrice, paramDate);
      titleC.clear();
      priceC.clear();
      toastInformation('Data Berhasil Ditambahkan');
    } catch (e) {
      toastAlert('Gagal Menambahkan Data');
    }
  }

  deleteTransaction(String paramId, int paramIndex, String paramStatus) async {
    try {
      await TransactionApi().deleteTransaction(int.parse(paramId));
      if (paramStatus == 'income') {
        incomeDataTransaction.removeAt(paramIndex);
      } else {
        spendingDataTransaction.removeAt(paramIndex);
      }
      toastInformation('Berhasil hapus Data');
    } catch (e) {
      toastAlert('Gagal hapus Data');
    }
    notifyListeners();
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

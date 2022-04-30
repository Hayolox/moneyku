import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:moneyku/model/api/transaction_api.dart';
import 'package:moneyku/model/transaction_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constant/state.dart';
import '../../future/toast_future.dart';
import '../../model/user_model.dart';

class NotesViewModel extends ChangeNotifier {
  DateTime dueDate = DateTime.now();
  final currenDate = DateTime.now();

  TextEditingController titleC = TextEditingController();
  TextEditingController priceC = TextEditingController();

  List<TransactionModel> allDataTransaction = [];
  List<TransactionModel> incomeDataTransaction = [];
  List<TransactionModel> spendingDataTransaction = [];
  late String sumIncome, sumSpending, name;
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
      sumIncome = _getTransactionApi['sumIncome'].toString();
      sumSpending = _getTransactionApi['sumSpending'].toString();
      total = _getTransactionApi['total'];

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

      /// get  status data expenditure
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

  addTransaction(TransactionModel paraModel) async {
    try {
      /// Add data transaction
      await TransactionApi().addTransaction(paraModel);
      titleC.clear();
      priceC.clear();
      toastInformation('Data Berhasil Ditambahkan');
    } catch (e) {
      toastAlert('Gagal Menambahkan Data');
    }
  }

  editTransaction(TransactionModel paramTransaction) async {
    try {
      /// Edit data transaction
      await TransactionApi().editTransaction(paramTransaction);
      toastInformation('Data Berhasil DiEdit');
    } catch (e) {
      toastAlert('Gagal Edit Data');
    }
  }

  deleteTransaction(String paramId, int paramIndex, String paramStatus) async {
    try {
      ///Delete data transaction
      await TransactionApi().deleteTransaction(int.parse(paramId));

      /// Conditional status transaction for remove data
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

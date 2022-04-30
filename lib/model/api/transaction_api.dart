import 'package:dio/dio.dart';
import 'package:moneyku/model/transaction_model.dart';

class TransactionApi {
  final _baseUrl = 'https://api.hizbullahhaidar.xyz/api/Transaction';
  final _dio = Dio();

  Future getAllDataTransaction() async {
    final _response = await _dio.get(_baseUrl);

    if (_response.statusCode == 200) {
      return _response.data;
    } else {
      throw Exception('Failed to get data');
    }
  }

  Future getStatusTransaction() async {
    final _response = await _dio.get(_baseUrl);

    if (_response.statusCode == 200) {
      return [_response.data['income'], _response.data['spending']];
    } else {
      throw Exception('Failed to get data');
    }
  }

  Future addTransaction(TransactionModel model) async {
    final _response = await _dio.post(_baseUrl, data: {
      "title": model.title,
      "price": model.price,
      "status": model.status,
      "created_at": model.createdAt
    });

    if (_response.statusCode == 200) {
      return _response.data;
    } else {
      throw Exception('Failed to get data');
    }
  }

  Future editTransaction(TransactionModel transaction) async {
    final _response = await _dio.put(
      '$_baseUrl/' + transaction.id.toString(),
      data: {
        "title": transaction.title,
        "price": transaction.price,
        "status": transaction.status,
        "created_at": transaction.createdAt
      },
    );

    if (_response.statusCode == 200) {
      return _response;
    } else {
      throw Exception('Failed  edit data');
    }
  }

  Future deleteTransaction(int id) async {
    final _response = await _dio.delete('$_baseUrl/' + id.toString());
    return _response.data;
  }
}

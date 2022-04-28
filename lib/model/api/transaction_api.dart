import 'package:dio/dio.dart';

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
}

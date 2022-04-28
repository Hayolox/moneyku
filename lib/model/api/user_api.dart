import 'package:dio/dio.dart';
import 'package:moneyku/model/user_model.dart';

class UserApi {
  final _baseUrl = 'https://api.hizbullahhaidar.xyz/api/token/generator';
  final _dio = Dio();

  Future getDataUser(String email, String password) async {
    final _response =
        await _dio.post(_baseUrl, data: {"email": email, "password": password});

    if (_response.statusCode == 200) {
      return _response.data;
    } else {
      throw Exception('Failed to get data');
    }
  }
}

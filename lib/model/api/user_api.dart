import 'package:dio/dio.dart';
import 'package:moneyku/model/user_model.dart';

class UserApi {
  final _baseUrl = 'https://api.hizbullahhaidar.xyz/api/token/generator';
  final _user = 'https://api.hizbullahhaidar.xyz/api/User';
  final _dio = Dio();

  Future getDataUser(String email, String password) async {
    final _response = await _dio.post(
      _baseUrl,
      data: {"email": email, "password": password},
      options: Options(
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          }),
    );
    if (_response.statusCode == 200) {
      return _response.data;
    } else {
      throw Exception('Failed to get data');
    }
  }

  Future editDataUser(UserModel user) async {
    final _response = await _dio.put(
      '$_user/' + user.id.toString(),
      data: {
        "name": user.name,
        "email": user.email,
      },
    );

    if (_response.statusCode == 200) {
      return _response.data;
    } else {
      throw Exception('Failed to get data');
    }
  }
}

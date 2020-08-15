import 'package:dio/dio.dart';

class AuthRepository {
  Dio _dio = Dio();

  Future<String> signInUser({String email, String password}) async {
    Response _response;
    dynamic _data = {"email": email, "password": password};

    try {
      _response = await _dio.post("https://reqres.in/api/login", data: _data);
      print(_response.data['token']);
      return _response.data['token'];
    } on DioError catch (e) {
      throw Exception(e.response.data.toString());
    }
  }
}

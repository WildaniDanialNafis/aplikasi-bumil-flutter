import 'package:untitled/helper/ApiHelper.dart';
import 'package:untitled/models/error/ErrorResponse.dart';
import 'package:untitled/models/login/LoginResponse.dart';

class LoginService {
  static Future<LoginResponse> login(String email, String password) async {
    try {
      return await ApiHelper.post('/api/mobile-login', null, {
        'email': email,
        'password': password
      }, (json) => LoginResponse.fromJson(json));
    } catch (e) {
      if (e is ErrorResponse) {
        throw ('${e.message}');
      }
      throw Exception('Gagal Login : $e');
    }
  }

  static Future<LoginResponse> validatePassword(String inputPassword, String password) async {
    try {
      return await ApiHelper.post('/api/validate-password', null, {
        'inputPassword': inputPassword,
        'password': password
      }, (json) => LoginResponse.fromJson(json));
    }  catch (e) {
      throw Exception('Gagal Login : $e');
    }
  }
}